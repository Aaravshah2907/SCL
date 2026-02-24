Dim Matlab As Object
Dim S As String
Set Matlab = CreateObject("matlab.application")
MsgBox("In MATLAB, type" & vbCrLf & "str='new text';")
S = Matlab.GetCharArray("str", "base")
MsgBox("str = " & S)
