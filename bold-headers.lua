-- Lua filter to make table headers bold
function Table(tbl)
  if tbl.head then
    for i, row in ipairs(tbl.head.rows) do
      for j, cell in ipairs(row.cells) do
        -- Map over all inline content in the cell and make it bold
        cell.contents = pandoc.walk_block(
          pandoc.Div(cell.contents),
          {
            Str = function(el)
              return pandoc.Strong{pandoc.Str(el.text)}
            end
          }
        ).content
      end
    end
  end
  return tbl
end
