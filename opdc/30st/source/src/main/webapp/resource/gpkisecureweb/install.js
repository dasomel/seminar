var sProxyData = "DIRECT";
var nEndLoop = -1;
var nContinue = -1;
var Count = 0;

// GPKIInstaller ��ü �����Ǿ����� Ȯ��
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


// xp sp2 ���� üũ�ؼ� ������ �̵��Ѵ�.
function SP2Check()
{
	var userAgent;
	userAgent = navigator.userAgent;

	if( userAgent.indexOf("SV1") > 0 ) // xp sp2 �̴�. 
	{
		return true;
	}

	return false;
}
//������ ���� üũ
function BrowserVersionCheck()
{
	// IE ���� üũ 5.0 �̻� ����
	rv = document.GPKIInstaller.IEVersionCheck();
	if(rv < 5)
	{		
		nContinue = 0;
		return false;
	}
	
	nContinue = 1;
	return true;
}

// ��ġ���� ����üũ �� �ٿ�ε�
function VersionCheckAndDownload()
{
	rv = document.GPKIInstaller.VerCheckAndDownload(ServerAddr,ConfigFilePath);
	if(rv == 1)
	{
		alert("�������α׷� ��ġ�� �����մϴ�. Ȯ�ι�ư�� �����ֽʽÿ�.");
		rv = document.GPKIInstaller.RunSetup();  
		if( rv == -1) 
		{
			alert("���� ���α׷� ��ġ�� �����߽��ϴ�.\n(���α׷��� �������� �ʰų�, ������ �ùٸ��� �ʽ��ϴ�.)");	
			return false;
		}
		else if( rv == -2)
		{
			alert("���� ���α׷��� ������ �ùٸ��� �ʾ� ������ �� �����ϴ�.");	
			return false;
		}
		return true;
	}
	else if(rv == 2) // �̹� ��ġ�Ǿ��ִ� ���
	{
		return rv;
	}
	else
	{	
		alert("���α׷��� �ٿ�ε����� ���߽��ϴ�.");
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

