require("tests/testsuite")

function ModalMessage() end

local r = Cmd.LoadDocumentSet("testdocs/README-v0.1.wg")
AssertEquals(true, r)
