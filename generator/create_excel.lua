require 'luacom'

local excel = luacom.CreateObject('Excel.Application')

excel.Visible = true

local book = excel.Workbooks:Add()

local sheet = book.Worksheets(1)

sheet.Name = 'gty'

local range = sheet:Range('A1:A10')

local cell = sheet.Cells(1,1)

sheet:Range('D3:D6'):Merge()--合并单元格

range.Value2 = 1

range.Font.Size = 20

sheet.Cells(1,2).FormulaR1C1 = '=R3C1+R4C1' --公式

cell.Value2 = 'gty'

cell.Font.Name = 'Arial'

--cell.Font.FontStyle = 'bold'

cell.Font.Bold = true

sheet.Cells(4,5).EntireRow.Interior.Color = 0x334455    --整行操作

sheet.Cells(4,5).EntireColumn.Interior.Color = 0x998877 --整列操作

cell.Font.Size = 20

cell.Font.Color = 0x0000ff

cell.Font.Underline = true

cell.Font.Strikethrough = true  --删除线

cell.font.OutlineFont = true    --下划线

range.Interior.Color = 0x778899 --区域上色

range.Borders.LineStyle = 1     --边框样式 --每个小的内边框

sheet:Range('C2:G7').BorderAround(1)--外边框

--range.Borders.Weight = 4      --边框宽度

--range.Interior.Pattern = 8    --区域花纹

--cell.Font.Shadow = true

--cell.Font.SuperScript = true

--cell.Font.SubScript = true

print(range.Cells.Count)    --统计单元格数

print(range.Rows.Count)

print(range.Columns.Count)

range.NumberFormat = '$#,##0.00'    --格式化数字

sheet:Range('A2'):Cut()     --剪切

sheet:Range('A3'):Copy()    --复制

sheet:Paste(sheet:Range('B3')) --粘贴

book.Worksheets('sheet3'):Delete()

book:SaveAs(filePath,51)--51xlsx -4143xls

excel:Quit()