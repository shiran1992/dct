require 'os'
require 'engine'
require 'convert'
require 'do_qa_data'

local file = io.open("../qa_chart.json", "w")
if not file then
    print("failed to open output file : test_data.lua")
else
	file:write([[

{]])
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
handle_week_trend()
--------------------------------------------   function end     ---------------------------------------------------

file:write([[

"gdWeekTrend":]])
output_json(gdWeekTrend, file)



file:write([[
		
}]])

