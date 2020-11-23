<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
 /**
  * @Class Name  : EgovRestdeDetail.jsp
  * @Description : EgovRestdeDetail 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.01   이중호              최초 생성
  *   2011.08.12   서준식              CSS 경로 수정
  *  @author 공통서비스팀
  *  @since 2009.04.01
  *  @version 1.0
  *  @see
  *
  */
%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html lang="ko">
<head>
<title>휴일 상세조회</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/com.css' />">
<link href="<c:url value='/css/egovframework/com/cmm/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Restde(){
	location.href = "<c:url value='/sym/cal/EgovRestdeList.do' />";
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fn_egov_modify_Restde(){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/sym/cal/EgovRestdeModify.do'/>";
	varForm.restdeNo.value   = "${result.restdeNo}";
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_Restde(){
	if (confirm("<spring:message code='common.delete.msg'/>")) {
		var varForm				 = document.all["Form"];
		varForm.action           = "<c:url value='/sym/cal/EgovRestdeRemove.do'/>";
		varForm.restdeNo.value   = "${result.restdeNo}";
		varForm.submit();
	}
}
-->
</script>
</head>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
<body>

<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%" class="title_left"><h1 class="title_left">
   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목아이콘이미지">&nbsp;휴일 상세조회</h1></td>
 </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="선택한 휴일의 휴일일자, 휴일명, 휴일설명, 휴일구분의 정보를 상세조회한다.">
<CAPTION style="display: none;">휴일 상세조회</CAPTION>
  <tr>
    <th scope="row" width="20%" height="23" class="required_text" nowrap >휴일일자<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" alt="필수입력표시"  width="15" height="15"></th>
    <td><c:out value='${fn:substring(result.restdeDe, 0,4)}'/>-<c:out value='${fn:substring(result.restdeDe, 4,6)}'/>-<c:out value='${fn:substring(result.restdeDe, 6,8)}'/></td>
  </tr>
  <tr>
    <th scope="row" width="20%" height="23" class="required_text" nowrap >휴일명<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" alt="필수입력표시"  width="15" height="15"></th>
    <td>${result.restdeNm}</td>
  </tr>
  <tr>
    <th scope="row" width="20%" height="23" class="required_text" nowrap >휴일설명<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" alt="필수입력표시"  width="15" height="15"></th>
    <td><textarea class="textarea"  cols="75" rows="14"  style="width:450px;" disabled title="휴일설명">${result.restdeDc}</textarea></td>
  </tr>
  <tr>
    <th scope="row" width="20%" height="23" class="required_text" nowrap >휴일구분<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" alt="필수입력표시"  width="15" height="15"></th>
    <td>${result.restdeSe}</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="10"></td>
  </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
  <td><span class="button"><input type="submit" value="수정" onclick="fn_egov_modify_Restde(); return false;"></span></td>
  <td width="10"></td>

  <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" alt="삭제" width="8" height="20"></td>
  <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap><a href="#noscript" onclick="fn_egov_delete_Restde(); return false;">삭제</a></td>
  <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif' />" alt="삭제" width="8" height="20"></td>
  <td width="10"></td>

  <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" alt="목록" width="8" height="20"></td>
  <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap><a href="#noscript" onclick="fn_egov_list_Restde(); return false;">목록</a></td>
  <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif' />" alt="목록" width="8" height="20"></td>
</tr>
</table>
<form name="Form" method="post" action="">
	<input type=hidden name="restdeNo">
	<input type="submit" id="invisible" class="invisible">
</form>
</body>
</html>
