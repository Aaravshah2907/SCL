Dim Matlab As Object 
Set Matlab = CreateObject("matlab.application") 
MsgBox ("MATLAB window created; now open it...") 
x = Matlab.PutCharArray("str", "base", "He jests at scars that never felt a wound.") 
MsgBox ("In MATLAB, type" & vbCrLf & "str") 
MsgBox ("closing MATLAB window...") 
y = Matlab.Quit()
