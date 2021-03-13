on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars

on FinderItemExists(thePath)
	try
		set thePath to thePath as alias
	on error
		return false
	end try
	return true
end FinderItemExists

on replaceText(search_string, replacement_text, this_document)
	tell application "TextEdit"
		open this_document
		set AppleScript's text item delimiters to the search_string
		set this_text to the text of the front document as list
		set AppleScript's text item delimiters to the replacement_text
		set the text of the front document to (this_text as string)
		close this_document saving yes
	end tell
end replaceText

on central_process(the_file)
	set AppleScript's text item delimiters to "."
	set file_extension to text item -1 of the_file
	
	set jsonhelper_location to "/Applications/JSON Helper.app/"
	set jsonhelper_location to POSIX file jsonhelper_location
	set config_location to (POSIX path of (path to me))
	set AppleScript's text item delimiters to "/Scripts/main.scpt"
	set config_location to text item 1 of config_location
	set config_location to config_location & "/Config/config.json"
	set config_location to POSIX file config_location
	
	set jsonhelper_status to FinderItemExists(jsonhelper_location)
	set config_status to FinderItemExists(config_location)
	
	if jsonhelper_status is true then
		if config_status is true then
			set configLocation to config_location
			set configRaw to read configLocation
		else
			set configRaw to "{\"customReferenceDoc\": false, \"referenceDocLocation\": \"undefined\"}"
		end if
		tell application "JSON Helper"
			set config to (read JSON from configRaw)
			tell config
				set customReferenceDoc to its customReferenceDoc
				set referenceDocLocation to its referenceDocLocation
			end tell
		end tell
	else
		set customReferenceDoc to false
		set referenceDocLocation to "undefined"
	end if
	
	if file_extension = "md" then
		set input_format to "markdown"
		set describe_input to "Markdown"
	else if file_extension = "docx" then
		set input_format to "docx --wrap=none"
		set describe_input to "Word document"
	else if file_extension = "icml" then
		set input_format to "icml"
		set describe_input to "InCopy"
		display dialog "Pandoc does not support conversion from InCopy. Please use Adobe InCopy or InDesign for further edits on this file."
		return 0
	else if file_extension = "pdf" then
		set input_format to "pdf"
		set describe_input to "PDF"
		display dialog "Pandoc does not support conversion from PDF. Please use another application for further edits on this file."
		return 0
	else
		display dialog "This pandoc helper does not support conversion from this format. Please use pandoc using your computer's command line interface."
		return 0
	end if
	
	set theResponse to choose from list {"InCopy", "Word Document - Default", "Word Document - Santa Fean Magazine", "Word Document - Custom Reference", "Markdown", "HTML", "PDF (Requires LaTeX)", "Custom"} with title "Markdown Converter" with prompt "Convert " & describe_input & " to: " default items "InCopy"
	
	if theResponse = {"InCopy"} then
		set output_format to "icml"
		set output_file to replace_chars(the_file, "." & file_extension, ".icml")
	else if theResponse = {"Word Document - Default"} then
		set output_format to "docx"
		set output_file to replace_chars(the_file, "." & file_extension, ".docx")
	else if theResponse = {"Word Document - Santa Fean Magazine"} then
		set output_format to "docx --reference-doc='/Applications/Pandoc Helper/Config/SantaFean.docx'"
		set output_file to replace_chars(the_file, "." & file_extension, ".docx")
	else if theResponse = {"Word Document - Custom Reference"} then
		if customReferenceDoc is true then
			set referenceDoc to referenceDocLocation
		else
			set referenceDoc to choose file with prompt "Select reference document (.docx):"
		end if
		set referenceDoc to POSIX path of referenceDoc
		set output_format to "docx --reference-doc='" & referenceDoc & "'"
		set output_file to replace_chars(the_file, "." & file_extension, ".docx")
	else if theResponse = {"Markdown"} then
		set output_format to "markdown --atx-headers"
		set output_file to replace_chars(the_file, "." & file_extension, ".md")
	else if theResponse = {"HTML"} then
		set output_format to "html"
		set output_file to replace_chars(the_file, "." & file_extension, ".html")
	else if theResponse = {"PDF (Requires LaTeX)"} then
		-->		set pdf_title to display dialog "What would you like to title this PDF?" default answer ""
		display dialog "Warning: PDF creation requires that you have installed LaTeX. Refer to documentation for details."
		-->		set pdf_title to "\"" & text returned of pdf_title & "\""
		-->		set output_format to "pdf --metadata title=" & pdf_title
		set output_format to "pdf --pdf-engine=/usr/local/texlive/2020basic/bin/x86_64-darwin/pdflatex"
		set output_file to replace_chars(the_file, "." & file_extension, ".pdf")
		-->		display dialog "This feature is not yet complete. Please use pandoc at the command line."
		-->		return 0
	else if theResponse = {"Custom"} then
		set custom_pandoc to display dialog "Custom Pandoc Options:" default answer "/usr/local/bin/pandoc -s -f " & input_format & " -t [OUTPUT FORMAT HERE] -o " & quoted form of the_file & "[<- OUTPUT EXTENSION INSIDE SINGLE BRACKET. DELETE THIS TEXT] " & quoted form of the_file
		set custom_pandoc to text returned of custom_pandoc
		do shell script custom_pandoc
		if result is "" then
			display dialog "Pandoc has not returned any errors. Please check intended output file for accuracy."
			return 1
		else
			display dialog "Pandoc has returned an ERROR. Please check your intended output file for accuracy."
			return 0
		end if
	else
		return 0
	end if
	
	do shell script "/usr/local/bin/pandoc -s -f " & input_format & " -t " & output_format & " -o " & quoted form of output_file & " " & quoted form of the_file
	
	if result is "" then
		display dialog describe_input & " converted to " & theResponse & " at " & output_file
		return 1
	else
		display dialog "Pandoc has returned an error. Please check your intended output file for accuracy."
		return 0
	end if
end central_process

on open the_file
	set the_file to POSIX path of the_file
	
	central_process(the_file)
end open

on run
	set the_file to choose file with prompt "Select file to convert:"
	set the_file to POSIX path of the_file
	
	central_process(the_file)
end run
