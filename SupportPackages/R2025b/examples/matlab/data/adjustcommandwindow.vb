Dim Matlab As Object

Matlab = CreateObject("matlab.application")
Matlab.MinimizeCommandWindow

'Now return the server window to its former state on 
'the desktop and make it the currently active window.

Matlab.MaximizeCommandWindow
