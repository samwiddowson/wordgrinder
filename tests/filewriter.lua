require("tests/testsuite")

local filename = os.tmpname()
local fw = CreateFileWriter(filename)

AssertEquals(filename, fw.filename)
AssertEquals(nil, fw.err)
local success = fw:open()
AssertEquals(true, success)

fw:writeToBuffer("one","two","three")

AssertEquals("onetwothree", fw:getBufferAsString())

fw:finalize()

local f = io.open(filename)
local filecontents = f:read("*a")

AssertEquals("onetwothree", filecontents)

local fw2 = CreateFileWriter("moo/moo/cow/")
local dummy, fnfErr = io.open("moo/moo/cow/")

AssertEquals(fnfErr, fw2.err)

success = fw2:open()

AssertEquals(false, success)

fw2 = CreateFileWriter()

AssertEquals("No filename specified.", fw2.err)
