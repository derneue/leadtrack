cmdp = require('luacbm')
cmdp:init("Hello")

-- Help text
function printHelp()
	print([[
leadtrack commands
------------------
  ? 		This helptext
  q			Quit leadtrack
  l			list journal
]])
end

myjt = { 
	{txt="ugga", cmd=func1},
	{txt="blaa", cmd=func2}
}

cmdp:setCbTable(myjt)
--cmdp:getJT()ftmp = io.tmpfile()

tmp = os.tmpname()
print("File: "..os.tmpname())
--os.execute("C:\\vim\\vim74\\gvim.exe "..tmp)

state = "DO_RUN"

while state ~= "DO_EXIT" do
	io.write("> ")
	local str = io.read()
	print("You say: "..str)
end

