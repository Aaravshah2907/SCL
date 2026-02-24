Dim Matlab As Object 
Dim data(6) As Double 
Dim i As Integer 
Matlab = CreateObject("matlab.application") 
For i = 0 To 6 
    data(i) = i * 15 
Next i 
Matlab.PutWorkspaceData("A", "base", data) 
MsgBox("In MATLAB, type" & vbCrLf & "A") 