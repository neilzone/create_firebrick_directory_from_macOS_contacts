-- Save comma separated values (CSV) file to desktop
set exportPath to (path to desktop as string) & "contacts_for_firebrick.txt"
set contactsHolder to "" -- variable to collect rows of addresses
set quoteString to "\"" -- constant to ease concatenation
tell application "Contacts"
	-- Repeat with every person in your Contacts
	repeat with x from 1 to the count of people
		set thePerson to person x
		set theirName to the name of thePerson
		-- A person may have multiple phone numbers, add one row for each
		repeat with aPhoneNumber in the phone of thePerson
			set contactsHolder to contactsHolder & "<directory number=\"" & (value of aPhoneNumber) & quoteString & " name=\"" & theirName & quoteString & "/>" & "
"
		end repeat
	end repeat
end tell
-- Write the contents to a file
set exportFile to open for access file exportPath with write permission
set eof of exportFile to 0
write contactsHolder to exportFile starting at eof
close access exportFile
