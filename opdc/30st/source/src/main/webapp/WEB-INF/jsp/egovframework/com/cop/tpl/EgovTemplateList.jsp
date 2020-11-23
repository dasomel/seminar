<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovTemplateList.jsp
  * @Description : 템플릿 목록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.18   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.18
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
			fn_egov_select_tmplatInfo('1');
		}
	}

	function fn_egov_insert_addTmplatInfo(){
		document.frm.action = "<c:url value='/cop/tpl/addTemplateInf.do'/>";
		document.frm.submit();
	}

	function fn_egov_select_tmplatInfo(pageNo){
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/cop/tpl/selectTemplateInfs.do'/>";
		document.frm.submit();
	}

	function fn_egov_inqire_tmplatInfor(tmplatId){
		document.frm.tmplatId.value = tmplatId;
		document.frm.action = "<c:url value='/cop/tpl/selectTemplateInf.do'/>";
		document.frm.submit();
	}
</script>
<title>템플릿 목록</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}

	A:link    { color: #000000; text-decoration:none; }
	A:visited { color: #000000; text-decoration:none; }
	A:active  { color: #000000; text-decoration:none; }
	A:hover   { color: #fa2e2e; text-decoration:none; }
</style>


</head>
<body>
<form name="frm" action ="" method="post">
<input type="hidden" name="tmplatId" value="" />

<div id="border" style="width:730px">
	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="40%"class="title_left">
	  	<h1>
	  		<img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="제목버튼이미지">&nbsp;템플릿 목록
	  	</h1>
	  </td>
	  <th >
	  </th>
	  <td width="10%" >
	   		<select name="searchCnd" class="select" title="검색조건선택">
			   <!-- option selected value=''--><!--선택하세요--><!--/option-->
			   <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >템플릿명</option>
			   <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >템플릿구분</option>
		   </select>
		</td>
	  <td width="35%">
	    <input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>'  maxlength="35" onkeypress="press(event);" title="검색단어입력">
	  </td>
	  <th width="10%">
	   <table border="0" cellspacing="0" cellpadding="0">
	    <tr>
	    <!-- 
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" width="8" height="20" alt="button left"></td>
	      <td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>" class="text_left" nowrap>
	      <a href="javascript:fn_egov_select_tmplatInfo('1')">조회</a>
	      </td>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	      <td>&nbsp;&nbsp;</td>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	      <td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>" class="text_left" nowrap>
	      <a href="javascript:fn_egov_insert_addTmplatInfo()">등록</a>
	      </td>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	    -->
	    	<td><span class="button"><input type="submit" value="조회" title="조회" onclick="javascript:fn_egov_select_tmplatInfo('1');return false;"></span></td>
	    	<td width="10"> </td>
	    	<td><span class="button"><input type="submit" value="등록" title="등록" onclick="javascript:fn_egov_insert_addTmplatInfo();return false;"></span></td>
	    </tr>
	   </table>
	  </th>
	 </tr>
	</table>
	<table width="100%" cellpadding="8" class="table-line">
	 <thead>
	  <tr>
	    <!-- th class="title" width="3%" nowrap><input type="checkbox" name="all_check" class="check2"></th-->
	    <th class="title" width="10%" nowrap>번호</th>
	    <th class="title" width="15%" nowrap>템플릿명</th>
	    <th class="title" width="10%" nowrap>템플릿구분</th>
	    <th class="title" width="32%" nowrap>템플릿경로</th>
	    <th class="title" width="10%" nowrap>사용여부</th>
	    <th class="title" width="10%" nowrap>등록일자</th>
	  </tr>
	 </thead>
	 <tbody>
		 <c:forEach var="result" items="${resultList}" varStatus="status">
		  <tr>
		    <!--td class="lt_text3" nowrap><input type="checkbox" name="check1" class="check2"></td-->
		    <td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>

		    <!-- 2010.10.15
		    <td class="lt_text3" nowrap>
		    	<a href="javascript:fn_egov_inqire_tmplatInfor('<c:out value="${result.tmplatId}"/>')">
		    	<c:out value="${result.tmplatNm}"/></a>
		    </td>
			-->

		    <td class="lt_text3" nowrap>
				<a href="<c:url value='/cop/tpl/selectTemplateInf.do'/>?tmplatId=<c:out value='${result.tmplatId}'/>" onclick="">
					<c:out value="${result.tmplatNm}"/>
				</a>
		    </td>

		    <td class="lt_text3" nowrap><c:out value="${result.tmplatSeCodeNm}"/></td>
		    <td class="lt_text3" nowrap><c:out value="${result.tmplatCours}"/></td>
		    <td class="lt_text3" nowrap>
		    	<c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
		    	<c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>
		    </td>
			<td class="lt_text3" nowrap><c:out value="${result.frstRegisterPnttm}"/></td	>
		  </tr>
		 </c:forEach>
		 <c:if test="${fn:length(resultList) == 0}">
		  <tr>
		    <td class="lt_text3" nowrap colspan="5" ><spring:message code="common.nodata.msg" /></td>
		  </tr>
		 </c:if>

	 </tbody>
	 <!--tfoot>
	  <tr class="">
	   <td colspan=6 align="center"></td>
	  </tr>
	 </tfoot -->
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="10"></td>
	  </tr>
	</table>
	<div align="center">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_tmplatInfo" />
	</div>
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
</div>
</form>
</body>
</html>
