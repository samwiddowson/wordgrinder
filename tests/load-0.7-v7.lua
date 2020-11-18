require("tests/testsuite")

local success = Cmd.LoadDocumentSet("testdocs/File-v7-test.wg")
AssertEquals(true, success)

AssertEquals(2, #DocumentSet.documents)
AssertEquals("This is a test.", DocumentSet.documents[1][1]:asString())
AssertEquals("This is another test.", DocumentSet.documents[2][1]:asString())
