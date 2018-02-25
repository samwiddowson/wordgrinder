local function findDocumentSetInRecents()
	for i, recent in ipairs(GlobalSettings.recents) do
		if recent == DocumentSet.name then
			return i
		end
	end
end
	
function SetMostRecentDocumentSet()

	if not GlobalSettings then
		LoadGlobalSettings()
	end

	if not GlobalSettings.recents then
		GlobalSettings.recents = {}
	end

	local curr = findDocumentSetInRecents()

	if curr then
		table.remove(GlobalSettings.recents, curr)
	end

	table.insert(GlobalSettings.recents, 1, DocumentSet.name)

	if #GlobalSettings.recents > 10 then
		for i in 11, #GlobalSettings.recents do
			GlobalSettings.recents[i] = nil
		end
	end

	SaveGlobalSettings()

	RebuildRecentsMenu()
end
