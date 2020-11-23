var sProxyData = "DIRECT";
var nEndLoop = -1;
var nContinue = -1;
var Count = 0;

// GPKIInstaller 객체 생성되었는지 확인
function HaveObject()
{
		
	if(document.GPKIInstaller==null || document.GPKIInstaller.object==null)
	{
		return false;
	}
	else
	{
		return true;
	}
}


// xp sp2 인지 체크해서 페이지 이동한다.
function SP2Check()
{
	var userAgent;
	userAgent = navigator.userAgent;

	if( userAgent.indexOf("SV1") > 0 ) // xp sp2 이다. 
	{
		return true;
	}

	return false;
}
//브라우저 버전 체크
function BrowserVersionCheck()
{
	// IE 버전 체크 5.0 이상만 지원
	rv = document.GPKIInstaller.IEVersionCheck();
	if(rv < 5)
	{		
		nContinue = 0;
		return false;
	}
	
	nContinue = 1;
	return true;
}

// 설치파일 버전체크 및 다운로드
function VersionCheckAndDownload()
{
	rv = document.GPKIInstaller.VerCheckAndDownload(ServerAddr,ConfigFilePath);
	if(rv == 1)
	{
		alert("보안프로그램 설치를 시작합니다. 확인버튼을 눌러주십시오.");
		rv = document.GPKIInstaller.RunSetup();  
		if( rv == -1) 
		{
			alert("보안 프로그램 설치에 실패했습니다.\n(프로그램이 존재하지 않거나, 서명이 올바르지 않습니다.)");	
			return false;
		}
		else if( rv == -2)
		{
			alert("보안 프로그램의 서명이 올바르지 않아 실행할 수 없습니다.");	
			return false;
		}
		return true;
	}
	else if(rv == 2) // 이미 설치되어있는 경우
	{
		return rv;
	}
	else
	{	
		alert("프로그램을 다운로드하지 못했습니다.");
		return false;
	}
}

function DisplayMsg(title, body)
{
	msg = "&nbsp;<font color='blue' class='12p'>\r\n";
	msg = msg + "<B>" + title +" : </B></font>";
	msg = msg + "<font class='12p'>\r\n";
	msg = msg + body +"</font><br>";
	document.write(msg);
}


//------------------------------------------------------------------------------
//  Determine OS Version from a Script
//------------------------------------------------------------------------------
function getOSVersion()
{
	version=/NT \d+.\d+/;
	strTemp = String(navigator.appVersion.match(version));
	if(strTemp == "null")
		return null;
	re = /(\w+)\s(\w+)/;
	return Number(strTemp.replace(re, "$2"));
}

