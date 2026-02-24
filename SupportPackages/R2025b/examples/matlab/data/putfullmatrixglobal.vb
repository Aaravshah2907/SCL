Dim MatLab As Object
Dim XReal(1,2) As Double
Dim XImag(1,2) As Double
Dim result As String
Dim i,j As Integer

For i = 0 To 1
   For j = 0 To 2
      XReal(i,j) = (j * 2 + 1) + i
      XImag(i,j) = 1
   Next j
Next i

Matlab = CreateObject("matlab.application")
MatLab.PutFullMatrix("X","global",XReal,XImag)
result = Matlab.Execute("whos global")
MsgBox(result)
