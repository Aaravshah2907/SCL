Dim Matlab As Object 
Dim MATLAB_version As String 
Dim data(6) As Double 
Set Matlab = CreateObject("matlab.application") 
For i = 0 To 6 
    data(i) = i * 15 
Next i 
x = Matlab.PutWorkspaceData("A", "base", data) 
Matlab.Execute ("A = A.*2;") 
y = Matlab.GetWorkspaceData("A", "base", B) 
MsgBox ("Doubled second value of A = " & B(0, 1))
