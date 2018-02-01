require("tests/testsuite")
globalSettings = {}
GetDefaultIoFormat()

AssertEquals(FileFormats.WORDGRINDER, GetDefaultIoFormat())
