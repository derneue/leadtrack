-- gtd stands for getting things done
--
-- it is like a daybook where you can move freely in the history. It is targeted for projects
-- where you need to track your daily work.--
-- Features:
--  * At start an empty day will be shown or the entries of the current day
--  * Command l lists all entries of the current day
--  * A range with l is also possible, e.g "l 2017-02-20 2017-02-28"
--  * Command n creates a new entry. Topic and tag can be set. After enter the 
--    informations an editor will be launched for a long description of the
--    task
--  * Command r can generate a report (start date, end date given) and lanches
--    the editor with that information--  * ...
--
-- All data is saved into an sqlite3 backend. Editor is configurable.
--
--
--

-- callback handling
cbm = require('luacbm')

helptext = [[
  leadtrack commands
  ------------------
  ?			This helptext
  l			List journal of the day
  n			Add new entry of the day
  d			Delete entry
  e			Exit
]]


-- Preliminary data tank
tank = {}

function print_helptext(param)
	print(helptext)
end

function cmd_list_journal(param)
	print("Journal items for today")
	print("-----------------------")
	print("")
	
	-- Iterate over data tank
	for _, v in pairs(tank) do
		print("   "..v["short_desc"])
		print("   Dur: "..v["duration"].."  Pay: "..v["paytype"].."  Date: "..v["date"])
		print("")	
	end
end

function cmd_add_new_journal_entry(param)
	local short_desc
	local long_desc
	local duration
	local paytype
	
	print("Add new journal entry")
	print("---------------------")
	print("")

	-- Read short description
	io.write("Short description [none]: ")
	short_desc = io.read()
	
	-- Read duration
	io.write("Duration (h) [none]: ")
	duration = io.read()

	-- Read paytype
	io.write("Project paytype [none]: ")
	paytype = io.read()

	-- Read long description by launching external
	-- editor.
	-- Generate temporary file
	local tmpfile = os.tmpname()
	print("Launching external editor for long desc...")
	os.execute("vim "..tmpfile)
	
	local long_desc_fd = io.open(tmpfile, "r")
	long_desc = long_desc_fd:read("*a")
	
	-- Closing file descriptor and remove file
	long_desc_fd:close()	
	os.remove(tmpfile)	
	-- Write data to tank
	local entry = {}
	entry["short_desc"] = short_desc
	entry["long_desc"] = long_desc
	entry["duration"] = duration
	entry["paytype"] = paytype
	entry["date"] = os.date()

	table.insert(tank, entry) 

end

function cmd_delete_journal_entry(param)
	print("Journal entry deleted")
end

function cmd_exit(param)
	ltstate = "DO_EXIT"
end

-- Fill callback table
ctable = {
	{ txt="?", cmd=print_helptext },
	{ txt="l", cmd=cmd_list_journal },
	{ txt="n", cmd=cmd_add_new_journal_entry },
	{ txt="d", cmd=cmd_delete_journal_entry },
	{ txt="e", cmd=cmd_exit },
}

ltstate = "DO_RUN"

-- Add handlers
cbm:setCbTable(ctable)


-- Command shell
while ltstate ~= "DO_EXIT" do
	io.write("> ")
	local cmd = io.read()
	cbm:parse(cmd)	
end

