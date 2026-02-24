Dim Matlab As Object 
Dim rows As Double 
Dim cols As Double 
Dim out As Object 
out = Nothing 
Dim data(7) As Double 
For i = 0 To 7 
    data(i) = i * 15 
Next i 
Matlab = CreateObject("matlab.application") 
Matlab.PutWorkspaceData("A", "base", data) 
rows = 4 
cols = 2 
Matlab.Feval("reshape", 1, out, "A=", rows, cols)