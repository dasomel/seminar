<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
 /**
  * @Class Name  : EgovRestdeRegist.jsp
  * @Description : EgovRestdeRegist 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  *   2011.08.12   서준식              CSS 경로 수정
  *
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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<html lang="ko">
<head>
<title>휴일 등록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/com.css' />" >
<link href="<c:url value='/css/egovframework/com/cmm/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/js/egovframework/com/sym/cal/EgovCalPopup.js' />" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="restde" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Restde(){
	location.href = "<c:url value='/sym/cal/EgovRestdeList.do' />";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
 function fn_egov_regist_Restde(form){
	if(confirm("<spring:message code='common.save.msg' />")){
		if(!validateRestde(form)){
			return;
		}else{
			form.submit();
		}
	}
}
-->
</script>
</head>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
<body>
<DIV id="content" style="width:712px">
<!-- 상단타이틀  -->
<form:form commandName="restde" name="restde" method="post">
<!-- 상단 타이틀  영역 -->
<table width="700" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%"class="title_left"><h1 class="title_left">
   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목아이콘이미지">&nbsp;휴일 등록</h1></td>
 </tr>
</table>
<!-- 줄간격조정  -->
<table width="700" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>

<!-- 등록  폼 영역  -->
<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="휴일 일자, 휴일명, 휴일설명, 휴일구분을 입력하여 휴일을 등록한다.">
<CAPTION style="display: none;">휴일 등록</CAPTION>
  <tr>
    <th scope="row" width="20%" height="23" class="required_text" nowrap >휴일일자<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" alt="필수입력표시"  width="15" height="15"  style="vertical-align: middle"></th>
    <td width="80%" nowrap>
		<input type="hidden" name="cal_url" value="<c:url value='/sym/cal/EgovNormalCalPopup.do'/>" />
    	<form:hidden path="restdeDe" />
		<input name="vrestdeDe" type="text" size="10" value=""  maxlength="10" readonly onClick="javascript:fn_egov_NormalCalendar(document.restde, document.restde.restdeDe, document.restde.vrestdeDe);" title="<spring:message code="sym.cal.restDay" />(새창)"/>
		<a href="#noscript" onclick="fn_egov_NormalCalendar(document.restde, document.restde.restdeDe, document.restde.vrestdeDe); return false;" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif' />" alt="달력창팝업버튼이미지"></a>
   	</td>
  </tr>
  <tr>
    <th scope="row" width="20%" height="23" class="required_text" nowrap >휴일명<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" alt="필수입력표시"  width="15" height="15"></th>
    <td width="80%" nowrap>
      <form:input  path="restdeNm" size="50" maxlength="50" title="휴일명"/>
      <form:errors path="restdeNm"/>
    </td>
  </tr>
  <tr>
    <th scope="row" width="20%" height="23" class="required_text" nowrap >휴일설명<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" alt="필수입력표시"  width="15" height="15"></th>
    <td>
      <form:textarea path="restdeDc" rows="3" cols="60" title="휴일설명"/>
      <form:errors   path="restdeDc"/>
    </td>
  </tr>
  <tr>
    <th scope="row" width="20%" height="23" class="required_text" nowrap >휴일구분<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" alt="필수입력표시"  width="15" height="15"></th>
    <td width="80%" nowrap>
      <form:select path="restdeSeCode" title="휴일구분">
	      <form:options items="${restdeCode}" itemValue="code" itemLabel="codeNm" />
      </form:select>
	</td>
  </tr>
</table>
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="10"></td>
  </tr>
</table>

<!-- 줄간격조정  -->
<table width="700" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>
<!-- 목록/저장버튼  -->
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
  <td><span class="button"><input type="submit" value="목록" onclick="fn_egov_list_Restde(); return false;"></span></td>
  <td width="10"></td>

  <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" alt="저장" width="8" height="20"></td>
  <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap><a href="#noscript" onclick="fn_egov_regist_Restde(document.restde); return false;">저장</a></td>
  <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif' />" alt="저장" width="8" height="20"></td>
</tr>
</table>

<input name="cmd" type="hidden" value="<c:out value='save'/>"/>
</form:form>
</DIV>
</body>
</html>
