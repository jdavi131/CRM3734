-- remove-pauses.lua
-- Strips RevealJS ". . ." pause paragraphs when rendering to non-revealjs formats.
function Para(el)
  if FORMAT == "revealjs" then return nil end
  local c = el.content
  if #c == 5
    and c[1].t == "Str"   and c[1].text == "."
    and c[2].t == "Space"
    and c[3].t == "Str"   and c[3].text == "."
    and c[4].t == "Space"
    and c[5].t == "Str"   and c[5].text == "."
  then
    return {}
  end
end
