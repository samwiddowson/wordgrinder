-- © 2008 David Given.
-- WordGrinder is licensed under the MIT open source license. See the COPYING
-- file in this distribution for the full text.

local ITALIC = wg.ITALIC
local UNDERLINE = wg.UNDERLINE
local ParseWord = wg.parseword
local WriteU8 = wg.writeu8
local bitand = bit32.band
local bitor = bit32.bor
local bitxor = bit32.bxor
local bit = bit32.btest
local string_char = string.char
local string_find = string.find
local string_sub = string.sub
local table_concat = table.concat

function ParseStringIntoWords(s)
	local words = {}
	for w in s:gmatch("[^ \t\r\n]+") do
		words[#words + 1] = w
	end
	if (#words == 0) then
		return {""}
	end
	return words
end

-- Import helper functions. These functions build styled words and paragraphs.

function CreateImporter(document)
	local pbuffer
	local wbuffer
	local oldattr
	local attr

	return
	{
		reset = function(self)
			pbuffer = {}
			wbuffer = {}
			oldattr = 0
			attr = 0
		end,

		style_on = function(self, a)
			attr = bitor(attr, a)
		end,

		style_off = function(self, a)
			attr = bitxor(bitor(attr, a), a)
		end,

		text = function(self, t)
			if (oldattr ~= attr) then
				wbuffer[#wbuffer + 1] = string_char(16 + attr)
				oldattr = attr
			end

			wbuffer[#wbuffer + 1] = t
		end,

		flushword = function(self, force)
			if (#wbuffer > 0) or force then
				local s = table_concat(wbuffer)
				pbuffer[#pbuffer + 1] = s
				wbuffer = {}
				oldattr = 0
			end
		end,

		flushparagraph = function(self, style)
			style = style or "P"

			if (#wbuffer > 0) then
				self:flushword()
			end

			if (#pbuffer > 0) then
				local p = CreateParagraph(style, pbuffer)
				document:appendParagraph(p)

				pbuffer = {}
			end
		end
	}
end

-- Does the standard selector-box-and-progress UI for each importer.

function ImportFileWithUI(filename, title, callback, document)
	if not filename then
		filename = FileBrowser(title, "Import from:", false)
		if not filename then
			return false
		end
	end

	local alreadyopendocument = DocumentSet:findDocumentByFilename(filename)
	if alreadyopendocument then
		DocumentSet:setCurrent(alreadyopendocument.name)
		ModalMessage(nil, "This file is already open!")
		QueueRedraw()
		return false
	end

	ImmediateMessage("Importing "..filename.."...")

	local fp = io.open(filename)
	if not fp then
		ModalMessage(nil, "The import failed because file "..filename.." could not be opened.")
		return false
	end

	local docname = Leafname(filename)

	if not document then
		document = CreateDocument()

		--we didn't pass a document object in, so the DocumentSet stuff needs handling here
		if DocumentSet.documents[docname] then
			local id = 1
			while true do
				local f = docname.."-"..id
				if not DocumentSet.documents[f] then
					docname = f
					break
				end
			end
		end

		DocumentSet:addDocument(document, docname)

	end

	if not document.name then
		document.name = docname
	end

	-- Actually import the file.
	local importsuccess, err = callback(fp, document)

	if not importsuccess then
		local message = "The import of file, "..filename.." failed."
		if err then
			message = message.." "..err
		end
		ModalMessage(nil, message)
		QueueRedraw()
		return false
	end

	fp:close()

	-- All the importers produce a blank line at the beginning of the
	-- document (the default content made by CreateDocument()). Remove it.

	if (#document > 1) then
		document:deleteParagraphAt(1)
	end

	document.filename = filename

	--replace the default document if it was the only one, and it hasn't been touched
	if (#DocumentSet.documents == 2) and (DocumentSet.documents[1].virgin) then
		DocumentSet:deleteDocument(DocumentSet.documents[1].name)
	end

	DocumentSet:setCurrent(docname)

	QueueRedraw()
	return true
end
