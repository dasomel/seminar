<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovMailXml.jsp
  * @Description : 발송요청메일 XML 파일내용 보기
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.09    박지욱          최초 생성
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.04.09
  *  @version 1.0
  *  @see
  *
  */
%>
<%pageContext.setAttribute("crlf", "\r\n"); %>

<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/com.css' />" type="text/css">
<title>MOPAS 발송요청 XML파일 내용 조회</title>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * XML형태의 발송메일 보기
 ******************************************************** */
function fnInit(){
	var message = document.all.message.value;
	if (message != "") {
		alert(message);
		window.close();
	}
}
</script>
</head>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
<body onLoad="fnInit();">
  <input type="hidden" name="message" value="${message}">

  <table width="100%">
    <tr>
      <td>
		<table width="100%" cellpadding="8" class="table-search" border="0">
		 <tr>
		  <td width="100%"class="title_left">
		   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle" alt="제목아이콘이미지">&nbsp;발송요청 XML파일 내용 조회</td>
		 </tr>
		</table>
		<table width="500" border="0" cellpadding="0" cellspacing="1" class="table-register">
		  <tr>
		    <th width="150" height="23" class="required_text" >내용&nbsp;&nbsp;</th>
		    <td width="350" nowrap>
		      ${xmldata}
		    </td>
		  </tr>
		</table>
	  </td>
	</tr>
	<tr>
	  <td>
		<table border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" width="8" height="20" alt="버튼이미지"></td>
		    <td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif' />" class="text_left" nowrap><a href="javascript:window.close();">닫기</a>
		    </td>
		    <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif' />" width="8" height="20" alt="버튼이미지"></td>
		  </tr>
		</table>
	  </td>
	</tr>
  </table>
</body>
</html>

