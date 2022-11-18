require 'os'
require 'engine'

ENUM_BOOLEAN = {
	["Fail"] = 1,
	["Y"] = 1
}

function getBoolean(data)
	if data then
		if ENUM_BOOLEAN[data] then
			return ENUM_BOOLEAN[data]
		end
	end
	return 0
end

function parse_string(txt)
	if not txt then
		return nil
	end

	txt = tostring(txt)

	txt = txt:gsub("\"", "\\\"")
	txt = txt:gsub("，", ",")
	txt = txt:gsub("；", ";")
	txt = txt:gsub("。", ".")

	return txt
end

function parse_text(txt)
	if not txt then
		return nil
	end

	txt = tostring(txt)

	txt = txt:gsub("！", "@")
	txt = txt:gsub("，", "#")
	txt = txt:gsub("\\n", "&")

	local ttbl = {}
	local breakline = ""

	for v in txt:gfind("[^@#&]+[@#&]?") do
		v = v:gsub("@", "！")
		v = v:gsub("#", "，")
		v = v:gsub("&", "\\n")

		if v=="\\n" then
			breakline = "\\n"
		else
			if v:find("%[") then
				for h,c in v:gfind("([^%[%]]+)([%[%]]?)") do
					if h=="\\n" then
						breakline = "\\n"
					elseif h~="" then
						local attr = {}
						if c==']' then
							attr.color = h:sub(1, 1)
							attr.content = breakline .. h:sub(2, -1)
							breakline = ""
						else
							attr.color = 'w'
							attr.content = breakline .. h
							breakline = ""
						end
						table.insert(ttbl, attr)
					end
				end
			else
				local attr = {}
				attr.color="w"
				attr.content=breakline .. v
				breakline = ""
				table.insert(ttbl, attr)
			end
		end
	end

	return ttbl
end

--字符串分割
function split(s, sep)
    if string.len(s) == 0 then
        return {}
    end

    local t = {}
    local pos1 = 1
    while true do
        local pos2 = string.find(s, sep, pos1);
        if pos2 == nil then
            table.insert(t, string.sub(s, pos1))
            break
        end

        if pos2 == pos1 then
            table.insert(t, "")
        else
            table.insert(t, string.sub(s, pos1, pos2 - 1))
        end

        pos1 = pos2 + 1
    end

    return t
end

function parse_item_cnt(str)
	if not str or type(str) ~= "string" then
		return
	end

	local _,_,a,b = string.find(str,"(%d+)[-*:](%d+)")
	if a and b then
		return tonumber(a),tonumber(b)
	end
end

function parse_item_cnt_ex(str)
	if not str or type(str) ~= "string" then
		return
	end

	local _,_,a,b,c = string.find(str,"(%d+)[*:](%d+)[*:](%d+)")
	if a and b and c then
		return tonumber(a),tonumber(b),tonumber(c)
	end
end

function gettime(td)
	if not td or type(td)~="string" then
		--print("#####Event missing  time ")
		return
	end

	local _, _, a, b = td:find("(%d+)[-:](%d+)")
	td= tonumber(a) * 60 * 60 +tonumber(b) * 60
	return td
end