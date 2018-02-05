-- © 2008-2013 David Given.
-- WordGrinder is licensed under the MIT open source license. See the COPYING
-- file in this distribution for the full text.

FileFormats = {}

FileFormats.HTML = "HTML"
FileFormats.LATEX = "LaTeX"
FileFormats.MARKDOWN = "Markdown"
FileFormats.ODT = "OpenDocument"
FileFormats.RTF = "RTF"
FileFormats.TEXT = "Text"
FileFormats.TROFF = "TROFF"
FileFormats.WORDGRINDER= "WordGrinder"

local fileformatfunction_map = {
	[FileFormats.HTML] = 		{	Cmd.ImportHTMLFile, 	Cmd.ExportHTMLFile},
	[FileFormats.LATEX] = 		{	nil,			Cmd.ExportLatexFile},
	[FileFormats.MARKDOWN] = 	{	nil,			Cmd.ExportMarkdownFile},
	[FileFormats.ODT] = 		{	Cmd.ImportODTFile,	Cmd.ExportODTFile},
	--[FileFormats.RTF] = 		{	nil,			Cmd.ExportRTFFile},
	[FileFormats.TEXT] = 		{	Cmd.ImportTextFile,	Cmd.ExportTextFile},
	[FileFormats.TROFF] = 		{	nil,			Cmd.ExportTroffFile},
	[FileFormats.WORDGRINDER]=	{	Cmd.ImportWGFile,	Cmd.ExportWGFile},
}

function GetDefaultIoFormat()
	if not GlobalSettings.defaultiofileformat then
		GlobalSettings.defaultiofileformat = FileFormats.WORDGRINDER
		SaveGlobalSettings()
	end
	return GlobalSettings.defaultiofileformat
end

function GetImportFunction(fileformat)
	return fileformatfunction_map[fileformat][1]
end

function GetExportFunction(fileformat)
	return fileformatfunction_map[fileformat][2]
end
