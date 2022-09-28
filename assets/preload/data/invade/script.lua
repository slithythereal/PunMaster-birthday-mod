function onCreatePost()
	if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
		setPropertyFromGroup('strumLineNotes', 0, 'x', defaultPlayerStrumX0)
		setPropertyFromGroup('strumLineNotes', 1, 'x', defaultPlayerStrumX1)
		setPropertyFromGroup('strumLineNotes', 2, 'x', defaultPlayerStrumX2)
		setPropertyFromGroup('strumLineNotes', 3, 'x', defaultPlayerStrumX3)

		setPropertyFromGroup('strumLineNotes', 4, 'x', defaultOpponentStrumX0)
		setPropertyFromGroup('strumLineNotes', 5, 'x', defaultOpponentStrumX1)
		setPropertyFromGroup('strumLineNotes', 6, 'x', defaultOpponentStrumX2)
		setPropertyFromGroup('strumLineNotes', 7, 'x', defaultOpponentStrumX3)
	end
end