set notifs to 0

tell application "System Events"
	tell list 1 of application process "Dock"
		repeat with appElement in UI elements
			if subrole of appElement is "AXApplicationDockItem" then
				set notifString to value of attribute "AXStatusLabel" of appElement
				if exists notifString then set notifs to notifs + (notifString as number)
			end if
		end repeat
	end tell
end tell

notifs
