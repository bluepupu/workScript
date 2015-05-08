/*
   This script is no good at using basic operation since it can't
   show the orignal messag of commands.
*/
var isPushToADB = false;
var targetPath = "";
var srcFile = "";

srcFile = ".\\framework.jar";
WScript.Echo(CheckFile(srcFile));
targetPath = "/system/framework";
pushFileToADB(srcFile, targetPath);

srcFile = ".\\libwebcore.so"
WScript.Echo(CheckFile(srcFile));
targetPath = "/system/lib";
pushFileToADB(srcFile, targetPath);


function CheckFile(aFile)
{
  var fs, s = aFile;
  fs = new ActiveXObject("Scripting.FileSystemObject");
  
  if (fs.FileExists(aFile)){
	var f = fs.GetFile(aFile)
    s += "  " + f.DateLastModified;
	isPushToADB = true;
  }else{
    s += " doesn¡¦t exist.";
  }
    return(s);
}

function pushFileToADB(srcFile, targetPath){
	var ws = WScript.CreateObject("WScript.Shell");
	//ws.Run("adb push " + srcFile + " " + targetPath);
	
	var oExec = ws.Exec("adb push " + srcFile + " " + targetPath);

	while (oExec.Status == 0)
	{
		WScript.Sleep(100);
	}

	WScript.Echo(oExec.Status);
	
	isPushToADB = false;
}