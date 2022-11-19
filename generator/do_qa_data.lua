require 'os'
require 'engine'
require 'convert'

local file = io.open("../qa_data.json", "w")
if not file then
    print("failed to open output file : test_data.lua")
else
	file:write([[

{]])
end
-- 所有记录的ID
gdAllIds = {}
-- 总记录
gdRecord = {}
-- 服务标准
gdRubric = {}
-- 知识
gdKnowledge = {}
-- 指导技巧
gdGuidance = {}
-- 专业素质
gdProfession = {}
-- 保留
gdHold = {}
-- 效率
gdEfficiency = {}
-- 记录/工具
gdTool = {}
-- 跟进
gdFollow = {}
-- 升级
gdEscalation = {}
-- 隐私
gdPrivacy = {}
-- 失误
gdFatal = {}
-- rca
gdRca = {}
-- action
gdAction = {}

-- 记录最新的一周
newWeek = 0

-- 平台
gdEnumPlatform = {}
function handle_platform(str)
	local isHave = false 
	for key, value in pairs(gdEnumPlatform) do
		if value == str then
			isHave = true
			break
		end
	end
	if not isHave then
		table.insert(gdEnumPlatform, str)
	end

	return #gdEnumPlatform
end

-- 回邮件员工
gdAdvisor = {}
function handle_advisor(str)
	local isHave = false 
	for key, value in pairs(gdAdvisor) do
		if value == str then
			isHave = true
			break
		end
	end
	if not isHave then
		table.insert(gdAdvisor, str)
	end
end

-- 质检员工
gdEvalutor = {}
function handle_evalutor(str)
	local isHave = false 
	for key, value in pairs(gdEvalutor) do
		if value == str then
			isHave = true
			break
		end
	end
	if not isHave then
		table.insert(gdEvalutor, str)
	end
end

-- 质检方式
gdEnumQAType = {}
function handle_qa_type(str)
	local isHave = false 
	for key, value in pairs(gdEnumQAType) do
		if value == str then
			isHave = true
			break
		end
	end
	if not isHave then
		table.insert(gdEnumQAType, str)
	end

	return #gdEnumQAType
end

gdEnumTallyS = {}
function handle_tally_s(str)
	local isHave = false 
	for key, value in pairs(gdEnumTallyS) do
		if value == str then
			isHave = true
			break
		end
	end
	if not isHave then
		table.insert(gdEnumTallyS, str)
	end

	return #gdEnumTallyS
end

gdEnumTallyX = {}
function handle_tally_x(str)
	local isHave = false 
	for key, value in pairs(gdEnumTallyX) do
		if value == str then
			isHave = true
			break
		end
	end
	if not isHave then
		table.insert(gdEnumTallyX, str)
	end

	return #gdEnumTallyX
end

gdEnumTallyY = {}
function handle_tally_y(str)
	local isHave = false 
	for key, value in pairs(gdEnumTallyY) do
		if value == str then
			isHave = true
			break
		end
	end
	if not isHave then
		table.insert(gdEnumTallyY, str)
	end

	return #gdEnumTallyY
end

gdEnumTallyZ = {}
function handle_tally_z(str)
	local isHave = false 
	for key, value in pairs(gdEnumTallyZ) do
		if value == str then
			isHave = true
			break
		end
	end
	if not isHave then
		table.insert(gdEnumTallyZ, str)
	end

	return #gdEnumTallyZ
end

function handle_record(o)
	if not (o.i and o.i ~= "" and tonumber(o.i) ~= 0) then
        return
    end

	local id = tonumber(o.i)
	table.insert(gdAllIds, id)

    local record = {}
    record.id = id
	if o.a and o.a ~= "" then
		local dateArr = split(o.a, "/")
		if #dateArr >= 3 then
			local year = tonumber(dateArr[1])
			local month = tonumber(dateArr[2])
			local day = tonumber(dateArr[3])
			if tonumber(dateArr[3]) > 100 then
				month = tonumber(dateArr[1])
				day = tonumber(dateArr[2])
				year = tonumber(dateArr[3])
			end
			local time = os.time({year = year, month = month, day = day, hour = 0, minute = 0, second = 0})
			record.qaTime = time
			record.qaWeek = tonumber(os.date("%W", time)) + 1

			if record.qaWeek > newWeek then
				newWeek = record.qaWeek
			end
		end
    end
	if o.b and o.b ~= "" then
		local dateArr = split(o.b, "/")
		if #dateArr >= 3 then
			local year = tonumber(dateArr[1])
			local month = tonumber(dateArr[2])
			local day = tonumber(dateArr[3])
			if tonumber(dateArr[3]) > 100 then
				month = tonumber(dateArr[1])
				day = tonumber(dateArr[2])
				year = tonumber(dateArr[3])
			end
			local time = os.time({year = year, month = month, day = day, hour = 0, minute = 0, second = 0})
			record.rhTime = time
			record.rhWeek = tonumber(os.date("%W", time))
		end
    end
	record.name = o.h
	handle_advisor(record.name)
	record.platform = handle_platform(o.g)
	record.qaName = o.e
	handle_evalutor(record.qaName)
	record.qaType = handle_qa_type(o.f)
	record.rca = parse_string(o.ca)
	record.action = parse_string(o.cb)
	record.datas = handle_tally_s(o.j)
	record.datax = handle_tally_x(o.k)
	record.datay = handle_tally_y(o.l)
	record.dataz = handle_tally_z(o.m)

	local rubric = {}
	rubric.id = id
	rubric.rrc1 = getBoolean(o.q)
	rubric.rrc2 = getBoolean(o.r)
	local flag = rubric.rrc1 == 1 or rubric.rrc2 == 1
	rubric.rrc = flag and 0 or 1
	gdRubric[id] = rubric

	local knowledge = {}
	knowledge.id = id
	knowledge.klg1 = getBoolean(o.t)
	knowledge.klg2 = getBoolean(o.u)
	knowledge.klg3 = getBoolean(o.v)
	knowledge.klg4 = getBoolean(o.w)
	knowledge.klg5 = getBoolean(o.x)
	knowledge.klg6 = getBoolean(o.y)
	knowledge.klg7 = getBoolean(o.z)
	local flag = knowledge.klg1 == 1 or knowledge.klg2 == 1 or knowledge.klg3 == 1 or knowledge.klg4 == 1 or
	knowledge.klg5 == 1 or knowledge.klg6 == 1 or knowledge.klg7 == 1
	knowledge.klg = flag and 0 or 1
	gdKnowledge[id] = knowledge

	local guidance = {}
	guidance.id = id
	guidance.gdc1 = getBoolean(o.ab)
	guidance.gdc2 = getBoolean(o.ac)
	local flag = guidance.gdc1 == 1 or guidance.gdc2 == 1
	guidance.gdc = flag and 0 or 1
	gdGuidance[id] = guidance

	local profession = {}
	profession.id = id
	profession.pfs1 = getBoolean(o.ae)
	profession.pfs2 = getBoolean(o.af)
	profession.pfs3 = getBoolean(o.ag)
	profession.pfs4 = getBoolean(o.ah)
	profession.pfs5 = getBoolean(o.ai)
	profession.pfs6 = getBoolean(o.aj)
	profession.pfs7 = getBoolean(o.ak)
	profession.pfs8 = getBoolean(o.al)
	local flag = profession.pfs1 == 1 or profession.pfs2 == 1 or profession.pfs3 == 1 or profession.pfs4 == 1 
	or profession.pfs5 == 1 or profession.pfs6 == 1 or profession.pfs7 == 1 or profession.pfs8 == 1
	profession.pfs = flag and 0 or 1
	gdProfession[id] = profession

	local hold = {}
	hold.id = id
	hold.hd1 = getBoolean(o.an)
	hold.hd2 = getBoolean(o.ao)
	hold.hd3 = getBoolean(o.ap)
	hold.hd4 = getBoolean(o.aq)
	local flag = hold.hd1 == 1 or hold.hd2 == 1 or hold.hd3 == 1 or hold.hd4 == 1
	hold.hd = flag and 0 or 1
	gdHold[id] = hold

	local efficiency = {}
	efficiency.id = id
	efficiency.efc1 = getBoolean(o.as)
	efficiency.efc2 = getBoolean(o.at)
	efficiency.efc3 = getBoolean(o.au)
	efficiency.efc4 = getBoolean(o.av)
	efficiency.efc5 = getBoolean(o.aw)
	local flag = efficiency.efc1 == 1 or efficiency.efc2 == 1 or efficiency.efc3 == 1 or efficiency.efc4 == 1 or efficiency.efc5 == 1
	efficiency.efc = flag and 0 or 1
	gdEfficiency[id] = efficiency

	local tool = {}
	tool.id = id
	tool.tl1 = getBoolean(o.ay)
	tool.tl2 = getBoolean(o.az)
	tool.tl3 = getBoolean(o.ba)
	tool.tl4 = getBoolean(o.bb)
	tool.tl5 = getBoolean(o.bc)
	tool.tl6 = getBoolean(o.bd)
	local flag = tool.tl1 == 1 or tool.tl2 == 1 or tool.tl3 == 1 or tool.tl4 == 1 or tool.tl5 == 1 or tool.tl6 == 1
	tool.tl = flag and 0 or 1
	gdTool[id] = tool

	local follow = {}
	follow.id = id
	follow.flw1 = getBoolean(o.bf)
	follow.flw2 = getBoolean(o.bg)
	follow.flw3 = getBoolean(o.bh)
	follow.flw4 = getBoolean(o.bi)
	follow.flw5 = getBoolean(o.bj)
	follow.flw6 = getBoolean(o.bk)
	local flag = follow.flw1 == 1 or follow.flw2 == 1 or follow.flw3 == 1 or follow.flw4 == 1 or follow.flw5 == 1
	if flag then
		follow.flw = 0
	else
		if follow.flw6 == 0 then
			follow.flw = 1
		elseif follow.flw6 == 1 then
			follow.flw = 2
		end
	end
	gdFollow[id] = follow

	local escalation = {}
	escalation.id = id
	escalation.eln1 = getBoolean(o.bm)
	escalation.eln2 = getBoolean(o.bn)
	escalation.eln3 = getBoolean(o.bo)
	escalation.eln4 = getBoolean(o.bp)
	escalation.eln5 = getBoolean(o.bq)
	local flag = escalation.eln1 == 1 or escalation.eln2 == 1 or escalation.eln3 == 1 or escalation.eln4 == 1
	if flag then
		escalation.eln = 0
	else
		if escalation.eln5 == 0 then
			escalation.eln = 1
		elseif escalation.eln5 == 1 then
			escalation.eln = 2
		end
	end
	gdEscalation[id] = escalation

	local privacy = {}
	privacy.id = id
	privacy.pvy1 = getBoolean(o.bs)
	privacy.pvy2 = getBoolean(o.bt)
	local flag = privacy.pvy1 == 1 or privacy.pvy2 == 1
	privacy.pvy = flag and 0 or 1
	gdPrivacy[id] = privacy

	local fatal = {}
	fatal.id = id
	fatal.ftl1 = getBoolean(o.bv)
	fatal.ftl2 = getBoolean(o.bw)
	fatal.ftl3 = getBoolean(o.bx)
	fatal.ftl4 = getBoolean(o.by)
	fatal.ftl5 = getBoolean(o.bz)
	local flag = fatal.ftl1 == 1 or fatal.ftl2 == 1 or fatal.ftl3 == 1 or fatal.ftl4 == 1 or fatal.ftl5 == 1
	fatal.ftl = flag and 0 or 1
	gdFatal[id] = fatal

	-- 计算准确率
	record.rate = 100
	local count = 0
	local right = 0

	if rubric.rrc == 1 then
		right = right + 1
	end
	if rubric.rrc <= 1 then
		count = count + 1
	end

	if knowledge.klg == 1 then
		right = right + 1
	end
	if knowledge.klg <= 1 then
		count = count + 1
	end

	if guidance.gdc == 1 then
		right = right + 1
	end
	if guidance.gdc <= 1 then
		count = count + 1
	end

	if profession.pfs == 1 then
		right = right + 1
	end
	if profession.pfs <= 1 then
		count = count + 1
	end

	if hold.hd == 1 then
		right = right + 1
	end
	if hold.hd <= 1 then
		count = count + 1
	end
	
	if efficiency.efc == 1 then
		right = right + 1
	end
	if efficiency.efc <= 1 then
		count = count + 1
	end

	if tool.tl == 1 then
		right = right + 1
	end
	if tool.tl <= 1 then
		count = count + 1
	end

	if follow.flw == 1 then
		right = right + 1
	end
	if follow.flw <= 1 then
		count = count + 1
	end

	if escalation.eln == 1 then
		right = right + 1
	end
	if escalation.eln <= 1 then
		count = count + 1
	end

	if privacy.pvy == 1 then
		right = right + 1
	end
	if privacy.pvy <= 1 then
		count = count + 1
	end

	if fatal.ftl == 1 then
		right = right + 1
	end
	if fatal.ftl <= 1 then
		count = count + 1
	end
	record.rate = tonumber(string.format("%.2f", right / count * 100))
	gdRecord[id] = record


	handle_week_trend()
end




--------------------------------------------   function start   ---------------------------------------------------
-- 东软每周趋势
gdWeekTrend = {}
function handle_week_trend()
	local weekData = {}
	for k, v in pairs(gdRecord) do
		if v.platform == 1 then
			if not weekData[v.qaWeek] then
				weekData[v.qaWeek] = {}
			end
			table.insert(weekData[v.qaWeek], v)
		end
	end
	
	for k = 1, 60, 1 do
		local v = weekData[k]
		if v then
			local weekCount = {week = k, platform = gdEnumPlatform[1], count = 0, sum = 0, rate = 0}
			for kk, vv in pairs(v) do
				weekCount.count = weekCount.count + 1
				weekCount.sum = weekCount.sum + vv.rate
			end
			if weekCount.count > 0 then
				weekCount.rate = tonumber(string.format("%.2f", weekCount.sum / weekCount.count))
			end
			table.insert(gdWeekTrend, weekCount)
		end
	end
end
--------------------------------------------   function end     ---------------------------------------------------

export_csv("..\\design\\W46_Neusoft_Chat_QA_Record.xlsx")
handle_file("tmp\\Rawdata.csv", handle_record)

file:write([[

"newWeek":]] .. newWeek .. ",\n")

file:write([[

"gdEnumPlatform":]])
output_json(gdEnumPlatform, file, ",")

file:write([[

"gdAdvisor":]])
output_json(gdAdvisor, file, ",")

file:write([[

"gdEvalutor":]])
output_json(gdEvalutor, file, ",")

file:write([[

"gdEnumQAType":]])
output_json(gdEnumQAType, file, ",")

file:write([[

"gdEnumTallyS":]])
output_json(gdEnumTallyS, file, ",")

file:write([[

"gdEnumTallyX":]])
output_json(gdEnumTallyX, file, ",")

file:write([[

"gdEnumTallyY":]])
output_json(gdEnumTallyY, file, ",")

file:write([[

"gdEnumTallyZ":]])
output_json(gdEnumTallyZ, file, ",")

file:write([[

"gdAllIds":]])
output_json(gdAllIds, file, ",")

file:write([[

"gdRecord":]])
output_json(gdRecord, file, ",")

file:write([[

"gdRubric":]])
output_json(gdRubric, file, ",")

file:write([[

"gdKnowledge":]])
output_json(gdKnowledge, file, ",")

file:write([[

"gdGuidance":]])
output_json(gdGuidance, file, ",")

file:write([[

"gdProfession":]])
output_json(gdProfession, file, ",")

file:write([[

"gdHold":]])
output_json(gdHold, file, ",")

file:write([[

"gdEfficiency":]])
output_json(gdEfficiency, file, ",")

file:write([[

"gdTool":]])
output_json(gdTool, file, ",")

file:write([[

"gdFollow":]])
output_json(gdFollow, file, ",")

file:write([[

"gdEscalation":]])
output_json(gdEscalation, file, ",")

file:write([[

"gdPrivacy":]])
output_json(gdPrivacy, file, ",")

file:write([[

"gdFatal":]])
output_json(gdFatal, file, ",")

file:write([[

"gdWeekTrend":]])
output_json(gdWeekTrend, file)



file:write([[
		
}]])

