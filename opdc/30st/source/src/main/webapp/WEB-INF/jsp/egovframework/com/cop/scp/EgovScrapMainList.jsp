<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
/**
 * @Class Name : EgovScrapMainList.jsp
 * @Description : 마이페이지 스크랩 목록조회
 * @Modification Information
 * @
 * @  수정일      수정자            수정내용
 * @ -------        --------    ---------------------------
 * @ 2009.09.25   한성곤          최초 생성
 *
 *  @author 공통컴포넌트개발팀 한성곤
 *  @since 2009.09.25
 *  @version 1.0
 *  @see
 *
 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/egovframework/com/cmm/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript">

	function fn_egov_inqire_scrap(scrapId) {
		document.scrapForm.scrapId.value = scrapId;
		document.scrapForm.submit();
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
<form name="scrapForm" method="post" action="<c:url value='/cop/scp/selectScrap.do'/>">
<div id="all" style="margin:0 auto;width:200px;">
	<table width="100%" cellpadding="8" class="table-line" summary="등록된 스크랩에 대한 목록을 제공합니다.">
	 <tbody>
		 <c:forEach var="result" items="${resultList}" varStatus="status">
		  <tr>
		    <!-- td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td> -->
		    <td class="lt_text6">
			<span class="link"><input type="text" value="<c:out value="${result.scrapNm}"/>" onclick="javascript:fn_egov_inqire_scrap('<c:out value="${result.scrapId}"/>'); return false;" title="스크랩이름"></span>
		    </td>
		  </tr>
		 </c:forEach>
		 <c:if test="${fn:length(resultList) == 0}">
		  <tr>
		    <td class="lt_text6" colspan="1">자료가 없습니다.</td>
		  </tr>
		 </c:if>
	 </tbody>
	</table>
</div>
<input name="pageIndex" type="hidden" value="1">
<input type="hidden" name="scrapId" value="">
</form>
</body>
</html>
