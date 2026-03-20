-- pdf-slides-pages.lua
-- In PDF output, wraps each slide (## heading + content) in a minipage
-- so it cannot be split across pages. Multiple slides can share a page.

function Pandoc(doc)
  if not FORMAT:match('latex') then return nil end

  local new_blocks = {}
  local in_slide = false

  for _, block in ipairs(doc.blocks) do
    if block.t == "Header" and block.level == 2 then
      if in_slide then
        table.insert(new_blocks, pandoc.RawBlock('latex', '\\end{minipage}\\medskip\\par'))
      end
      table.insert(new_blocks, pandoc.RawBlock('latex', '\\begin{minipage}{\\linewidth}'))
      in_slide = true
    end
    table.insert(new_blocks, block)
  end

  if in_slide then
    table.insert(new_blocks, pandoc.RawBlock('latex', '\\end{minipage}\\medskip\\par'))
  end

  return pandoc.Pandoc(new_blocks, doc.meta)
end
