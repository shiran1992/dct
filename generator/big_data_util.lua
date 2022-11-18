if not big_data_util then
    big_data_util = {}
end
local splitdatafilelist={}   -- 分割文件列表
local crtcount = 0  --- 当前数量
local crtFilename =""   -- 当前文件名称 
local spiltcount = 500 -- 分割数量
local crtindex = 0

local splittablelist={}   -- 当前分文件的数据文件列表




--filename 保存的文件名
--tablename 数据表名
--spilt 分割数量
--
function big_data_util.GetBigDataFile(filename,tablename,spilt)
	if filename ~= crtFilename then
		crtcount = 0
		splitdatafilelist= {}
		crtFilename = filename
	end 
	crtcount = crtcount+1
	 
	if spilt then
		spiltcount = spilt
	end 
	local index = math.floor(crtcount/spiltcount) +1
	
	if index ~= crtindex then
		splittablelist = {} 
	end
	 
	local crtfile = splitdatafilelist[index]
	if not crtfile  then
		crtfile = io.open("../database/"..filename..index..".lua", "w")
		if not crtfile then
			print("Failed to open output file: "..filename..".lua")
		else
		    -- crtfile:write( "\nif not (type("..tablename..")==\"table\") then "..tablename.." = {}  end \n  ")
		end
		splitdatafilelist[index] = crtfile
	
	end  
	
	if not splittablelist[tablename] then
		crtfile:write( "\nif not (type("..tablename..")==\"table\") then "..tablename.." = {}  end \n ")
		splittablelist[tablename] = 1
	end
	crtindex = index
	
	return crtfile
end


