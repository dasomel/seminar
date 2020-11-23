<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
 /**
  * @Class Name : EgovGuestList.jsp
  * @Description : 방명록
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.04.02   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.04.02
  *  @version 1.0
  *  @see
  *
  */
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_select_guestList(pageNo) {
		document.board.pageIndex.value = pageNo;
		document.board.action = "<c:url value='/cop/bbs/selectGuestList.do'/>";
		document.board.submit();
	}

	function fn_egov_selectForupdt(nttId) {
		document.board.nttId.value = nttId;
		document.board.action = "<c:url value='/cop/bbs/selectSingleGuestList.do'/>";
		document.board.submit();
	}

	function fn_egov_deleteGuestList(nttId) {
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.board.nttId.value = nttId;
			document.board.action = "<c:url value='/cop/bbs/deleteGuestList.do'/>";
			document.board.submit();
		}
	}

	function fn_egov_updt_guestList() {
		if (!validateBoard(document.board)){
			return;
		}
		if (confirm('<spring:message code="common.update.msg" />')) {
			document.board.action = "<c:url value='/cop/bbs/updateGuestList.do'/>";
			document.board.submit();
		}
	}

	function fn_egov_insert_guestList() {
		if (!validateBoard(document.board)){
			return;
		}

		if (confirm('<spring:message code="common.regist.msg" />')) {
			document.board.action = "<c:url value='/cop/bbs/insertGuestList.do'/>";
			document.board.submit();
		}
	}
</script>
<title>방명록</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

</head>
<body>
<form:form commandName="board" name="board"  method="post">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input name="bbsId" type="hidden" value="<c:out value='${brdMstrVO.bbsId}'/>"/>
<input name="nttId" type="hidden" value='<c:out value="${boardVO.nttId}" />' />
<input name="nttSj" type="hidden" value='<spring:message code="cop.guestList.subject" />' />
<input name="ntceBgnde" type="hidden" value="10000101">
<input name="ntceEndde" type="hidden" value="99991231">

<input type="hidden" name="password" value="dummy">	<!-- validator 처리를 위해 지정 -->

<div id="border" style="width:730px">
	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle" alt="제목버튼이미지">
	   &nbsp;<spring:message code="cop.guestList" /></td>
	 </tr>
	</table>

	<table width="100%" cellpadding="8" class="table-line">
	 <tbody>
 		<c:forEach var="result" items="${resultList}" varStatus="status">
		  <tr>
		    <td class="lt_text" nowrap>
		    <c:choose>
		    	<c:when test="${not empty result.ntcrNm}">
		    		<b><c:out value="${result.ntcrNm}" /></b>&nbsp;
		    	</c:when>
		    	<c:otherwise>
		    		<b><c:out value="${result.frstRegisterNm}" /></b>&nbsp;
		    	</c:otherwise>
		    </c:choose>
		     <c:out value="${result.frstRegisterPnttm}" /><br>
		     <c:out value="${result.nttCn}" />
		    </td>
		    <td class="lt_text" nowrap>
		    <c:if test="${result.frstRegisterId == sessionUniqId}">
		     <a href="javascript:fn_egov_selectForupdt('<c:out value="${result.nttId}" />');"><spring:message code="button.update" /></a>
		      | <a href="javascript:fn_egov_deleteGuestList('<c:out value="${result.nttId}" />');"><spring:message code="button.delete" /></a>
		     </c:if>
		    </td>
		  </tr>
 		</c:forEach>
		 <c:if test="${fn:length(resultList) == 0}">
		  <tr>
	  		<td class="lt_text" nowrap colspan="2"></td>
  		  </tr>
		 </c:if>
	 </tbody>

	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="10"></td>
	  </tr>
	</table>
	<div align="center">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_guestList" />
	</div>

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="10"></td>
	  </tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
	  <tr>
	    <th width="20%" height="23" class="" nowrap ><spring:message code="cop.ntcrNm" /></th>
	    <td width="30%" nowrap>
	      <input name="ntcrNm" type="text" size="20" value='<c:out value="${boardVO.ntcrNm}" />' maxlength="20" title="작정자이름입력">
	    </td>
	  </tr>
	  <tr>
	    <th height="23" class="required_text" ><spring:message code="cop.guestListCn" />
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td>
	      <textarea name="nttCn" class="textarea"  cols="50" rows="4"  style="width:100%;" title="방명록내용입력"><c:out value="${boardVO.nttCn}" /></textarea>
	      <form:errors path="nttCn" />
	    </td>
	  </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="10"></td>
	  </tr>
	</table>
	<div align="center">
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
	<c:choose>
		<c:when test="${boardVO.nttId == '0'}">
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	      <td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>" class="text_left" nowrap>
	      <a href="javascript:fn_egov_insert_guestList()"><spring:message code="button.create" /></a>
	      </td>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
		</c:when>
		<c:otherwise>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	      <td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>" class="text_left" nowrap>
	      <a href="javascript:fn_egov_updt_guestList()"><spring:message code="button.update" /></a>
	      </td>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
		</c:otherwise>
	</c:choose>
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_select_guestList('1')">초기화</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	</tr>
	</table>
	</div>
</div>
</form:form>
</body>
</html>
