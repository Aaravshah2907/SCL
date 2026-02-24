Dim Matlab As Object
Dim out As Object
Matlab = CreateObject("matlab.application")
Matlab.Feval("fileparts",3,out,"d:\work\ConsoleApp.cpp")