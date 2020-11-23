<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
/**
 * @Class Name : EgovScrapInqire.jsp
 * @Description : 스크랩 등록 상세조회
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
	function fn_egov_select_scrapList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/cop/scp/selectScrapList.do'/>";
		document.frm.submit();
	}

	function fn_egov_delete_scrap() {
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.frm.action = "<c:url value='/cop/scp/deleteScrap.do'/>";
			document.frm.submit();
		}
	}

	function fn_egov_moveUpdt_scrap() {
		document.frm.action = "<c:url value='/cop/scp/forUpdateScrap.do' />";
		document.frm.submit();
	}
</script>
<title>스크랩 상세조회</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body>

<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<form name="frm" method="post" action="">
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">

	<input type="hidden" name="bbsId" value="<c:out value='${scrap.bbsId}'/>" >
	<input type="hidden" name="nttId" value="<c:out value='${scrap.nttId}'/>" >

	<input type="hidden" name="scrapId" value="<c:out value='${scrap.scrapId}'/>" >
</form>

<div id="border" style="width:730px">

	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목아이콘이미지">
	   &nbsp;스크랩 상세조회</td>
	 </tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="등록된 스크랩에 대한 상세정보를 제공합니다.">
	<tbody>
	  <tr>
	    <th width="14%" height="23" nowrap >스크랩명</th>
	    <td width="86%" nowrap colspan="5"><c:out value="${scrap.scrapNm}" />
	    </td>
	  </tr>
	  <tr>
	    <th width="14%" height="23" nowrap >게시판 명</th>
	    <td width="20%"><c:out value="${board.bbsNm}" />
	    </td>
	    <th width="13%" height="23" nowrap >스크랩 작성자</th>
	    <td width="20%" class="listCenter"><c:out value="${scrap.frstRegisterNm}" />
	    </td>
	    <th width="13%" height="23" nowrap >스크랩 작성시간</th>
	    <td width="20%" class="listCenter"><c:out value="${scrap.frstRegisterPnttm}" />
	    </td>
	  </tr>
	  <tr>
	    <th width="14%" height="23" nowrap >게시물 제목</th>
	    <td width="86%" colspan="5" nowrap><c:out value="${board.nttSj}" />
	    </td>
	  </tr>
	  <tr>
	    <th width="14%" height="23" nowrap >게시물 작성자</th>
	    <td width="20%" class="listCenter" nowrap>
			<c:out value="${board.frstRegisterNm}" />
	    </td>
	    <th width="13%" height="23" nowrap >게시물 작성시간</th>
	    <td width="20%" class="listCenter" nowrap><c:out value="${board.frstRegisterPnttm}" />
	    </td>
	    <th width="13%" height="23" nowrap >게시물 조회수</th>
	    <td width="20%" class="listCenter" nowrap><c:out value="${board.inqireCo}" />
	    </td>
	  </tr>
	  <tr>
	    <th height="23" >글내용</th>
	    <td colspan="5">
	     <div id="bbs_cn">
<c:out value="${board.nttCn}" escapeXml="false" />
	     </div>
	    </td>
	  </tr>
	  <c:if test="${not empty board.atchFileId}">
		  <c:if test="${board.bbsAttrbCode == 'BBSA02'}">
		  <tr>
		    <th height="23" >첨부이미지</th>
		    <td colspan="5">
					<c:import url="/cmm/fms/selectImageFileInfs.do" charEncoding="utf-8">
						<c:param name="atchFileId" value="${board.atchFileId}" />
					</c:import>
		    </td>
		  </tr>
		  </c:if>
		  <tr>
		    <th height="23">첨부파일 목록</th>
		    <td colspan="5">
				<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
					<c:param name="param_atchFileId" value="${board.atchFileId}" />
				</c:import>
		    </td>
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
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<c:if test="${scrap.frstRegisterId == sessionUniqId}">
		  <td>
		  	<form name="modifyFrm" method="post" action="<c:url value='/cop/scp/forUpdateScrap.do'/>">
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
				<input type="hidden" name="bbsId" value="<c:out value='${scrap.bbsId}'/>" >
				<input type="hidden" name="nttId" value="<c:out value='${scrap.nttId}'/>" >
				<input type="hidden" name="scrapId" value="<c:out value='${scrap.scrapId}'/>" >
				<span class="button"><input type="submit" value="수정" onclick="fn_egov_moveUpdt_scrap(); return false;"></span>
		  	</form>
		  </td>
	      <td width="10"></td>
		  <td>
		  	<form name="deleteFrm" method="post" action="<c:url value='/cop/scp/deleteScrap.do'/>">
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
				<input type="hidden" name="bbsId" value="<c:out value='${scrap.bbsId}'/>" >
				<input type="hidden" name="nttId" value="<c:out value='${scrap.nttId}'/>" >
				<input type="hidden" name="scrapId" value="<c:out value='${scrap.scrapId}'/>" >
				<span class="button"><input type="submit" value="삭제" onclick="fn_egov_delete_scrap(); return false;"></span>
		  	</form>
		  </td>
	      <td width="10"></td>
		</c:if>

      <td>
      	<form name="listFrm" method="post" action="<c:url value='/cop/scp/selectScrapList.do'/>">
      		<input name="pageIndex" type="hidden" value="1">
      		<span class="button"><input type="submit" value="목록" onclick="fn_egov_select_scrapList('1'); return false;"></span>
      	</form>
      </td>
	</tr>
	</table>
	</div>
</div>

</body>
</html>