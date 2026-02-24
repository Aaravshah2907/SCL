Dim Matlab As Object
Try
    Matlab = GetObject(, "matlab.application")
Catch e As Exception
    Matlab = CreateObject("matlab.application")
End Try
MsgBox("MATLAB window created; now open it...")
Matlab.PutCharArray("str", "base", _
  "He jests at scars that never felt a wound.")
MsgBox("In MATLAB, type" & vbCrLf & "str")
MsgBox("closing MATLAB window...")
Matlab.Quit()
