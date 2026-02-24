Dim MatLab As Object
Dim Result As String
Dim XReal(4, 4) As Double
Dim XImag(4, 4) As Double
Dim i, j As Integer

MatLab = CreateObject("matlab.application")
Result = MatLab.Execute("M = rand(5);")
MsgBox("In MATLAB, type" & vbCrLf & "M(3,4)")
MatLab.GetFullMatrix("M", "base", XReal, XImag)
' Display element (3,4). The array in VB .NET
' is 0-based.
i = 2
j = 3
MsgBox("XReal(" & i + 1 & "," & j + 1 & ")" & _
    " = " & XReal(i, j))
