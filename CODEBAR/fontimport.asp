<%
' Instructions: Make a .bmp file containing the following characters in order:
' !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[/]^abcdefghijklmnopqrstuvwxyz{|}~
'
' These characters must be one per line.  The width of the .bmp should be
' exactly equal to the width of one character.  The height of the .bmp should
' be 92 * the height of 1 character.
'
' When you have this file, change the few settings below to match your font and
' run this file.  It will output a font config file that you can then place in
' the barcode.asp file and use  ^_^

dim letters(94)

' courier new, 12px
'letters(0)	 = 12	' height per letter
'letters(1)	 = 9	'  width per letter
'spacer		 = 2
'FontName    = "CN12"
'FontImage   = "/images/couriernew12.bmp"

' courier new, 10px
letters(0)	= 10
letters(1)	= 7
spacer		= 3
FontName    = "CN10"
FontImage   = "/images/couriernew10.bmp"

' file format: line + 14, top to bottom.  14 extra bits occur at end of line, presumably to make a multiple of 8, + some header.

keys	= "!""#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[/]^abcdefghijklmnopqrstuvwxyz{|}~"
final	= "Font" & FontName & " = """

function bytetobinary(tbyte)
	out		= ""
	numval	= asc(tbyte)
	for x = 7 to 0 step -1
		if numval AND 2^x then out	= out & "1" else out	= out & "0"
	next
	bytetobinary	= out
end function

set FSO	= server.createobject("Scripting.FileSystemObject")
set File	= FSO.OpenTextFile(server.mappath(FontImage), 1, false)
file.read(62)

red	= 0
for i = 1 to len(keys)
	for j = 1 to letters(0)
		red	= red + 3
		letters(i+1)	= letters(i+1) & left(bytetobinary(file.read(1)), 7)
		file.read(spacer)
	next
	final	= final & letters(i+1)
next
response.write final & """"

File.close
set File	= nothing
set FSO	= nothing
%>