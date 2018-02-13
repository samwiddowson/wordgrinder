-- © 2008 David Given.
-- WordGrinder is licensed under the MIT open source license. See the COPYING
-- file in this distribution for the full text.

local function callback(writer, document)

	return ExportFileUsingCallbacks(document,
	{
		prologue = function()
		end,
		
		rawtext = function(s)
			writer(s)
		end,
		
		text = function(s)
			writer(s)
		end,
		
		notext = function(s)
		end,
		
		italic_on = function()
		end,
		
		italic_off = function()
		end,
		
		underline_on = function()
		end,
		
		underline_off = function()
		end,
		
		bold_on = function()
		end,
		
		bold_off = function()
		end,
		
		list_start = function()
		end,
		
		list_end = function()
		end,
		
		paragraph_start = function(style)
		end,		
		
		paragraph_end = function(style)
			writer('\n')
		end,
		
		epilogue = function()
		end
	})
end

function Cmd.SaveAsTextFile(filename, document)
	if not document then
		document = Document
	end
	document.ioFileFormat = GetIoFileFormats().Text.name
	document.filename = filename
	--document.name = Leafname(filename)
	SaveDocument(document)
	return Cmd.SaveDocumentSet()
end

function Cmd.ExportTextFile(filename, document)
	local success = ExportFileWithUI(filename, "Export Text File", ".txt",
		callback, document)
	if success then
		document.filename = filename
		document.name = Leafname(filename)
	end
	return success
end

function Cmd.ExportToTextString()
	return ExportToString(Document, callback)
end
