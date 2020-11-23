<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<%
 /**
  * @Class Name : EgovMailDetail.jsp
  * @Description : 발송메일 상세 조회 화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.11    박지욱          최초 생성
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.11
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/com.css' />" type="text/css">
<link href="<c:url value='/css/egovframework/com/cmm/button.css' />" rel="stylesheet" type="text/css">
<title>MOPAS 발송메일 상세 조회</title>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>"></script>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
	var ret = confirm("삭제하시겠습니까?");
	if (ret == true) {
		document.detailForm.action = "<c:url value='/cop/ems/deleteSndngMail.do'/>";
		document.detailForm.target = "";
		document.detailForm.submit();
	}
}
/* ********************************************************
 * 뒤로 처리 함수
 ******************************************************** */
function fnBack(){
	document.detailForm.action = "<c:url value='/cop/ems/backSndngMailDetail.do'/>";
	document.detailForm.target = "";
	document.detailForm.submit();
}

/* ********************************************************
 * XML형태의 발송메일 보기
 ******************************************************** */
function fnSelectXml(){
	document.detailForm.action = "<c:url value='/cop/ems/selectSndngMailXml.do'/>";
	document.detailForm.target = "_blank";
	document.detailForm.submit();
}
</script>
</head>


<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

  <form name="detailForm" action ="<c:url value='/cop/ems/deleteSndngMail.action'/>" method="post">
  	  <input name="mssageId" type="hidden" value="${resultInfo.mssageId}"/>
  	  <input name="atchFileIdList" type="hidden" value="${resultInfo.atchFileId}"/>
	  <table width="700">
	    <tr>
	      <td>
			<table width="700" cellpadding="8" class="table-search" border="0">
			 <tr>
			  <td width="700"class="title_left"><h1 class="title_left">
			   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목아이콘이미지">&nbsp;발송메일 상세조회</h1></td>
			 </tr>
			</table>
			<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="보내는 사람, 받는 사람, 제목, 발신 내용, 발송 결과, XML메일보기, 첨부파일에 대한 정보를 가진 발송메일을 상세조회한다.">
			<CAPTION style="display: none;">발송메일 상세조회</CAPTION>
			  <tr> 
			    <th scope="row" width="200" height="23" class="required_text" nowrap >보내는사람&nbsp;&nbsp;</th>
			    <td width="500" nowrap>${resultInfo.dsptchPerson}</td>
			  </tr>
			  <tr> 
			    <th scope="row" width="200" height="23" class="required_text" nowrap >받는사람&nbsp;&nbsp;</th>
			    <td width="500" nowrap>${resultInfo.recptnPerson}</td>
			  </tr>
			  <tr> 
			    <th scope="row" width="200" height="23" class="required_text" nowrap >제목&nbsp;&nbsp;</th>
			    <td width="500" nowrap>${resultInfo.sj}</td>
			  </tr>
			  <tr> 
			    <th scope="row" width="200" height="23" class="required_text" >발신 내용&nbsp;&nbsp;</th>
			    <td width="500" nowrap>
			      <c:out value="${fn:replace(resultInfo.emailCn , crlf , '<br/>')}" escapeXml="false" />
			    </td>
			  </tr> 
			  <tr> 
			    <th scope="row" width="200" height="23" class="required_text" >발송 결과&nbsp;&nbsp;</th>
			    <td width="500" nowrap>${resultInfo.sndngResultCode}</td>
			  </tr> 
			  <tr> 
			    <th scope="row" width="200" height="23" class="required_text" >XML메일보기&nbsp;&nbsp;</th>
			    <td width="500" nowrap><a href="#noscript" onclick="fnSelectXml(); return false;">${resultInfo.mssageId}.xml</a></td>
			  </tr>
			  <c:if test="${result.atchFileId != ''}">
			  <tr> 
			    <th scope="row" width="200" height="23" class="required_text" >첨부파일&nbsp;&nbsp;</th>
			    <td width="500" nowrap>
					<c:import url="/cmm/fms/selectFileInfs.do" >
						<c:param name="param_atchFileId" value="${resultInfo.atchFileId}" />
					</c:import>
			    </td>
			  </tr>
			  </c:if>
			</table>
			<table width="700" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
			    <td height="10"></td>
			  </tr>
			</table>
		  </td>
		</tr>
		<tr>
		  <td>
			<table border="0" cellspacing="0" cellpadding="0" align="right">
			  <tr> 
			    <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" width="8" height="20" alt="버튼이미지"></td>
			    <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap><a href="#noscript" onclick="fnBack(); return false;">뒤로</a> 
			    </td>
			    <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif' />" width="8" height="20" alt=""></td>    
			    <td>&nbsp;&nbsp;</td>  
			    <td><span class="button"><input type="submit" value="삭제" onclick="fnDelete(); return false;"></span></td>
			  </tr>
			</table>
		  </td>
		</tr>
	  </table>
  </form>	  
</body>
</html>

