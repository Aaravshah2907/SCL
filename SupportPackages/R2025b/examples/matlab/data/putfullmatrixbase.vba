Dim MatLab As Object 
Dim XReal(4, 4) As Double 
Dim XImag(4, 4) As Double 
Dim ZReal(4, 4) As Double 
Dim ZImag(4, 4) As Double 
Dim i, j As Integer 
 
For i = 0 To 4 
    For j = 0 To 4 
        XReal(i, j) = Rnd() * 6 
        XImag(i, j) = 0 
    Next j 
Next i 

Set MatLab = CreateObject("matlab.application") 
x = MatLab.PutFullMatrix("M", "base", XReal, XImag) 
y = MatLab.GetFullMatrix("M", "base", ZReal, ZImag)
