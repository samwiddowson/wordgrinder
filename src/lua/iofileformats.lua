-- © 2008-2013 David Given.
-- WordGrinder is licensed under the MIT open source license. See the COPYING
-- file in this distribution for the full text.

function GetIoFileFormats()

	iofileformats = {}
	iofileformats.HTML = {
		name = "HTML",
		exporter = Cmd.ExportHTMLFile,
		importer = Cmd.ImportHTMLFile }
	iofileformats.OpenDocument = {
		name = "OpenDocument",
		exporter = Cmd.ExportODTFile,
		importer = Cmd.ImportODTFile }
	iofileformats.Text = {
		name = "Text",
		exporter = Cmd.ExportTextFile,
		importer = Cmd.ImportTextFile }
	iofileformats.WordGrinder = {
		name = "WordGrinder",
		exporter = Cmd.ExportWGFile,
		importer = Cmd.ImportWGFile }
	iofileformats.RTF = {
		name = "RTF",
		exporter = Cmd.ExportWGFile,
		importer = nil }
	iofileformats.LaTex = {
		name = "LaTex",
		exporter = Cmd.ExportLatexFile,
		importer = nil }
	iofileformats.Markdown = {
		name = "Markdown",
		exporter = Cmd.ExportMarkdownFile,
		importer = Cmd.ImportMarkdownFile }
	iofileformats.troff = {
		name = "troff",
		exporter = Cmd.ExportTroffFile,
		importer = Cmd.ImportTroffFile }

	iofileformats.default = iofileformats["WordGrinder"]

	return iofileformats
end
