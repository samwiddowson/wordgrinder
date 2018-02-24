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
	if document.integrated then
		ModalMessage(nil, "The Scrapbook document cannot be maintained separately to the session file. Try the Export menu if you wish to save an external copy.")
		QueueRedraw()
		return false
	end
	document.ioFileFormat = GetIoFileFormats().Text.name
	return SaveDocument(filename, document)
end

function Cmd.ExportTextFile(filename, document)
	local success, filename = ExportFileWithUI(filename, "Export Text File", ".txt",
		callback, document)
	return success, filename
end

function Cmd.ExportToTextString()
	return ExportToString(Document, callback)
end
