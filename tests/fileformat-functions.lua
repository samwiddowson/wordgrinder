require("tests/testsuite")


globalSettings = {}
GetDefaultIoFormat()

AssertEquals(FileFormats.WORDGRINDER, GetDefaultIoFormat())

AssertClass( Cmd.ImportHTMLFile, GetImportFunction(FileFormats.HTML) )
AssertClass( Cmd.ImportODTFile, GetImportFunction(FileFormats.ODT) )
AssertClass( Cmd.ImportTextFile, GetImportFunction(FileFormats.TEXT) )
AssertClass( Cmd.ImportWGFile, GetImportFunction(FileFormats.WORDGRINDER) )

AssertClass( Cmd.ExportHTMLFile, GetExportFunction(FileFormats.HTML) )
AssertClass( Cmd.ExportLatexFile, GetExportFunction(FileFormats.LATEX) )
AssertClass( Cmd.ExportMarkdownFile, GetExportFunction(FileFormats.MARKDOWN) )
AssertClass( Cmd.ExportODTFile, GetExportFunction(FileFormats.ODT) )
AssertClass( Cmd.ExportTextFile, GetExportFunction(FileFormats.TEXT) )
AssertClass( Cmd.ExportTroffFile, GetExportFunction(FileFormats.TROFF) )
AssertClass( Cmd.ExportWGFile, GetExportFunction(FileFormats.WORDGRINDER) )
