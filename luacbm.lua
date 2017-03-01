-- Lua cmdparse module
-- 
-- --
-- Handles parsing of commands from std input
--
local M = {}

function M:init()
	print("init")
end

-- Set the callback table
function M:setCbTable(cbt)
	if cbt ~= nil then
		M.cbt = cbt
	end
end

-- Add callback to callback table
function M:addCb(name, cb)
	local newentry = { name, cb }
	table.insert(M.cbt, newentry)
end

function M:getCb()
	-- Iterate over all command entries
	for i,v in ipairs(M.cbt) do
		print("Command: "..v["txt"])
	end
end

-- Parse input string
function M:parse(instring)
	local newtoken = {}
	
	-- Split input string
	for i in string.gmatch(instring, "%S+") do
		table.insert(newtoken, i)
	end

	-- Command entered?
	if #newtoken > 0 then
		-- Do lookup here
		for _,v in ipairs(M.cbt) do
			if v["txt"] == newtoken[1] then
				-- Call function
				v["cmd"]()
			end
		end
	end
end

return M
