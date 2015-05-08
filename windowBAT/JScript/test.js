

var vs = WScript.Version;
var wshShell = WScript.CreateObject("WScript.Shell");

if(vs > 5){
	//WScript.Quit(1);
	main();
}else{
	error();
}

printEnv1();
printEnv2();
printDate();	

function printDate(){
	WScript.Echo("DATE: ", new Date);
}


function printEnv2(){
	WScript.Echo("printEnv2(): ===Environment varaibles===");
	var sysEnv = wshShell.Environment("SYSTEM");
	var usrEnv = wshShell.Environment("USER");
	var volEnv = wshShell.Environment("VOLATILE");
	WScript.Echo("PATH: ", sysEnv("PATH"));
	WScript.Echo("INCLUDE: ", usrEnv("INCLUDE")); //question
	WScript.Echo("LIB: ", usrEnv("LIB")); //question
	WScript.Echo("COMPUTERNAME: ", volEnv("COMPUTERNAME")); //question
	WScript.Echo("USERNAME: ", sysEnv("USERNAME"));//question
}

function printEnv1(){
	WScript.Echo("printEnv1(): ===Environment varaibles===");
	WScript.Echo("PATH: ", wshShell.ExpandEnvironmentStrings("%PATH%"));
	WScript.Echo("COMPUTERNAME: ", wshShell.ExpandEnvironmentStrings("%COMPUTERNAME%"));
	WScript.Echo("USERNAME: ", wshShell.ExpandEnvironmentStrings("%USERNAME%"));
}

function main(){
	WScript.Echo("WScript.FullName: ", WScript.FullName); 
	WScript.Echo("WScript.Path: ", WScript.Path); 
	WScript.Echo("WScript.Version: ", WScript.Version); 
}

function error(){
	WScript.Echo("WScript.Version: ", WScript.Version); 
}

