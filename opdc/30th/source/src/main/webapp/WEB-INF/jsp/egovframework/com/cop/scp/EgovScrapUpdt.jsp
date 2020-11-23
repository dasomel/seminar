<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<% 
/**
 * @Class Name : EgovScrapUpdt.jsp
 * @Description : 스크랩 수정
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/egovframework/com/cmm/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="scrap" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_update_scrap() {
		if (!validateScrap(document.scrap)){
			return;
		}
		
		if (confirm('<spring:message code="common.update.msg" />')) {
			document.scrap.action = "<c:url value='/cop/scp/updateScrap.do'/>";
			document.scrap.submit();					
		}
	}
	
	function fn_egov_select_scrap(){
		var form = document.scrap;
		form.action = "<c:url value='/cop/scp/selectScrapList.do'/>";
		form.submit();	
	}	
</script>
<title>스크랩 수정</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

</head>
<body>

<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<form:form commandName="scrap" name="scrap" method="post" action="${pageContext.request.contextPath}/cop/scp/updateScrap.do' />">

<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">

<input type="hidden" name="bbsId" value="<c:out value='${board.bbsId}'/>" >
<input type="hidden" name="nttId" value="<c:out value='${board.nttId}'/>" >

<input type="hidden" name="scrapId" value="<c:out value='${scrap.scrapId}'/>" >

<div id="border" style="width:730px">

	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목아이콘이미지">
	   &nbsp;스크랩 수정</td>
	 </tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="스크랩에 대한 정보를 수정합니다.">
	<tbody>
	  <tr> 
	    <th width="20%" height="23" class="required_text" nowrap ><label for="scrapNm">스크랩명</label>
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="80%" nowrap colspan="5">
	    	<input id="scrapNm" name="scrapNm" size="50" maxlength="50" style="width:100%" value="<c:out value='${scrap.scrapNm}'/>" >
	    	<br><form:errors path="scrapNm" />
	    </td>
	  </tr>
	  <tr> 
	    <th width="15%" height="23" nowrap >제목</th>
	    <td width="85%" colspan="5" nowrap><c:out value="${board.nttSj}" />
	    </td>
	  </tr>
	  <tr> 
	    <th width="15%" height="23" nowrap >작성자</th>
	    <td width="15%" class="lt_text3" nowrap>
			<c:out value="${board.frstRegisterNm}" />
	    </td>
	    <th width="15%" height="23" nowrap >작성시간</th>
	    <td width="15%" class="listCenter" nowrap><c:out value="${board.frstRegisterPnttm}" />
	    </td>
	    <th width="15%" height="23" nowrap >조회수</th>
	    <td width="15%" class="listCenter" nowrap><c:out value="${board.inqireCo}" />
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
	  <td><span class="button"><input type="submit" value="<spring:message code="button.save" />" onclick="fn_egov_update_scrap(); return false;"></span></td>
      <td width="10"></td>
      <td><span class="button"><a href="<c:url value='/cop/scp/selectScrapList.do'/>?pageIndex=1" onclick="fn_egov_select_scrap(); return false;"><spring:message code="button.list" /></a></span></td>
	</tr>
	</table>
	</div>
</div>
</form:form>
</body>
</html>
