Dim Matlab As Object 
Dim out As Object 
out = Nothing 
Matlab = CreateObject("matlab.application") 
Matlab.Feval("strcat",1,out,"hello"," world") 
Dim clistr As String
clistr = " world"
Matlab.Feval("strcat",1,out,"hello",clistr)
Matlab.PutCharArray("srvstr","base"," world")
Matlab.Feval("strcat",1,out,"hello","srvstr=")
