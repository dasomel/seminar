<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
/**
 * @Class Name : EgovScrapList.jsp
 * @Description : 스크랩 목록조회
 * @Modification Information
 * @
 * @  수정일      수정자            수정내용
 * @ -------        --------    ---------------------------
 * @ 2009.07.10   한성곤          최초 생성
 *
 *  @author 공통컴포넌트개발팀 한성곤
 *  @since 2009.07.10
 *  @version 1.0
 *  @see
 *
 */
%>

<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/egovframework/com/cmm/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript">

	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_scrap('1');
		}
	}

	function fn_egov_select_scrap(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/cop/scp/selectScrapList.do'/>";
		document.frm.submit();
	}

	function fn_egov_inqire_scrap(scrapId) {
		document.frm.scrapId.value = scrapId;
		document.frm.action = "<c:url value='/cop/scp/selectScrap.do'/>";
		document.frm.submit();
	}
</script>
<title>스크랩 목록조회</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body>

<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<div id="border" style="width:730px">

	<form name="frm" method="post" action="<c:url value='/cop/scp/selectScrapList.do'/>">

	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
	<input type="hidden" name="scrapId">

	<table width="100%" cellpadding="8" class="table-search" border="0">
	<tbody>
	 <tr>
	  <td width="40%" class="title_left">
	   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목아이콘이미지">&nbsp;스크랩</td>
		<td width="10%" >
	   		<select name="searchCnd" class="select" title="검색조건선택">
				<option value=''>--선택하세요--</option>
				<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >스크랩명</option>
		   </select>
		</td>
	  <td width="35%">
	    <input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색단어입력">
	  </td>
	  <th width="10%">
	   <table border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td><span class="button"><input type="submit" value="조회" onclick="fn_egov_select_scrap('1'); return false;"></span></td>
	    </tr>
	   </table>
	  </th>
	 </tr>
	</tbody>
	</table>

	</form>

	<table width="100%" cellpadding="8" class="table-list" summary="등록된 스크랩에 대한 목록을 제공합니다.">
	 <thead>
	  <tr>
	    <th class="title" width="10%" nowrap>번호</th>
	    <th class="title" width="35%" nowrap>스크랩명</th>
	    <th class="title" width="35%" nowrap>등록자</th>
	    <th class="title" width="20%" nowrap>등록일</th>
	  </tr>
	 </thead>
	 <tbody>
		 <c:forEach var="result" items="${resultList}" varStatus="status">
		  <tr>
		    <!--td class="lt_text3" nowrap><input type="checkbox" name="check1" class="check2"></td-->
		    <td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
		    <td class="lt_text3" nowrap>
		    <form name="item" method="post" action="<c:url value='/cop/scp/selectScrap.do'/>">
		    	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
				<input type="hidden" name="scrapId" value="<c:out value="${result.scrapId}"/>">
			<span class="link"><input type="submit" value="<c:out value="${result.scrapNm}"/>" onclick="javascript:fn_egov_inqire_scrap('<c:out value="${result.scrapId}"/>'); return false;"></span>
			</form>
		    </td>
		    <td class="lt_text3" nowrap><c:out value="${result.frstRegisterNm}"/></td>
		    <td class="lt_text3" nowrap><c:out value="${result.frstRegisterPnttm}"/></td>
		  </tr>
		 </c:forEach>
		 <c:if test="${fn:length(resultList) == 0}">
		  <tr>
		    <td class="lt_text3" nowrap colspan="4"><spring:message code="common.nodata.msg" /></td>
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
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_scrap" />
	</div>
</div>

</body>
</html>
