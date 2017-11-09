#!/bin/bash

osascript -e '
	tell application "Safari"
		activate
		make new document
		set URL of document 1 to system attribute "URL"
	end tell
	
	delay 5
	
	# repeat with i from 1 to the 10
	# 	tell application "Safari"
	# 		if (do JavaScript "document.readyState" in document 1) is "complete" then
	# 			return true
	# 		else if i is the timeout_value then
	# 			return false
	# 		end if
		
	# 		delay 1
	# 	end tell
	# end repeat

	tell application "System Events"
		tell process "Safari"
			set value of text field 1 of group 1 of tab group 1 of splitter group 1 of window "Favorites"  to system attribute "USERNAME"
			set value of text field 2 of group 1 of tab group 1 of splitter group 1 of window "Favorites"  to system attribute "PASSWORD"
			click checkbox "Remember this password"  of group 1 of tab group 1 of splitter group 1 of window "Favorites" 
			click button "Log In"  of group 1 of tab group 1 of splitter group 1 of window "Favorites" 
		end tell
	end tell'

