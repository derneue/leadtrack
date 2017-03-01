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
]]

function print_helptext(param)
	print(helptext)
end

function cmd_list_journal(param)
	print("Print journal")
end

function cmd_add_new_journal_entry(param)
	print("New journal entry added")
end

function cmd_delete_journal_entry(param)
	print("Journal entry deleted")
end

-- Fill callback table
ctable = {
	{ txt="?", cmd=print_helptext },
	{ txt="l", cmd=cmd_list_journal },
	{ txt="n", cmd=cmd_add_new_journal_entry },
	{ txt="d", cmd=cmd_delete_journal_entry },
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

