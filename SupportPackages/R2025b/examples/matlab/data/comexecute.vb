Dim Matlab As Object 
Dim data(6) As Double 
Dim B As Object 
B = Nothing 
Matlab = CreateObject("matlab.application") 
For i = 0 To 6 
    data(i) = i * 15 
Next i 
Matlab.PutWorkspaceData("A", "base", data) 
Matlab.Execute("A = A.*2;") 
Matlab.GetWorkspaceData("A", "base", B) 
MsgBox("Doubled second value of A = " & B(0, 1))
