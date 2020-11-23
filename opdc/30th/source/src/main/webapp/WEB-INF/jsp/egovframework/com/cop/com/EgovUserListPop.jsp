<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="${pageContext.request.contextPath}/images/egovframework/com/cmm/"/>

<%
 /**
  * @Class Name : EgovUserListPop.jsp
  * @Description : 사용자 목록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.04.06   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.04.06
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
			fn_egov_select_userInfo('1');
		}
	}
	function fn_egov_returnUserInfo(uniqId, userNm, userId){
		var retVal = uniqId +"|"+userNm+"|"+userId;
		parent.fn_egov_returnValue(retVal);

	}

	function fn_egov_select_userInfo(pageIndex){
		var _target = document.frm.targetMethod.value;
		var actionUrl;

		if(_target == 'selectClubOprtrList'){
			actionUrl = "<c:url value='/cop/com/selectClubOprtrList.do'/>";
		}else if(_target == 'selectClubUserList'){
			actionUrl = "<c:url value='/cop/com/selectClubUserList.do'/>";
		}else if(_target == 'selectCmmntyMngrList'){
			actionUrl = "<c:url value='/cop/com/selectCmmntyMngrList.do'/>";
		}else if(_target == 'selectCmmntyUserList'){
			actionUrl = "<c:url value='/cop/com/selectCmmntyUserList.do'/>";
		}else{
			actionUrl = "<c:url value='/cop/com/selectUserList.do'/>";
		}
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = actionUrl;
		document.frm.submit();
	}

	function fn_egov_close(){
		parent.closeWindow();
	}
</script>
<title>사용자 목록</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body>
<form name="frm" action ="<c:url value='/cop/com/selectUserList.do'/>" method="post">
<input type="hidden" name="targetMethod" value="${targetMethod}" />
<input type="hidden" name="trgetId" value="${trgetId}" />
<input type="hidden" name="PopFlag" value="Y" />


	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="40%"class="title_left">
	  	<h1>
	  		<img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="제목버튼이미지">&nbsp;사용자 목록
	  	</h1>
	  </td>
	  <th >
	  </th>
	  <td width="10%" >
	   		<select name="searchCnd" class="select" title="검색조건선택">
			   <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >사용자명</option>
		   </select>
		</td>
	  <td width="35%">
	    <input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색어 입력" >
	  </td>
	  <th width="10%">
	   <table border="0" cellspacing="0" cellpadding="0">
	    <tr>
	    <!--
	      <td><img src="${ImgUrl}btn/bu2_left.gif"  width="8" height="20" "alt="버튼이미지"></td>
	      <td class="btnBackground" nowrap><input type="submit" value="<spring:message code="button.inquire" />" onclick="fn_egov_select_userInfo('1'); return false;" class="btnNew" style="height:20px;width:26px;padding:0px 0px 0px 0px;" ></td>
	      <td><img src="${ImgUrl}btn/bu2_right.gif"  width="8" height="20" alt="버튼이미지"></td>
	    -->
	      <td><span class="button"><input type="submit" value="<spring:message code="button.inquire" />" title="<spring:message code="button.inquire" />" onclick="javascript:fn_egov_select_userInfo('1');return false;"></span></td>
	    </tr>
	   </table>
	  </th>
	 </tr>
	</table>
	<table width="100%" cellpadding="8" class="table-line"  summary="번호, 사용자아이디, 사용자명, 주소, 이메일, 사용여부, 선택   목록입니다"  >
	 <thead>
	  <tr>
	    <!-- th class="title" width="3%" nowrap><input type="checkbox" name="all_check" class="check2"></th-->
	    <th scope="col" class="title" width="10%" nowrap>번호</th>
	    <th scope="col" class="title" width="15%" nowrap>사용자아이디</th>
	    <th scope="col" class="title" width="15%" nowrap>사용자명</th>
	    <th scope="col" class="title" width="23%" nowrap>주소</th>
	    <th scope="col" class="title" width="12%" nowrap>이메일</th>
	    <th scope="col" class="title" width="8%" nowrap>사용여부</th>
 	    <th scope="col" class="title" width="8%" nowrap>선택</th>
	  </tr>
	 </thead>
	 <tbody>

		 <c:forEach var="result" items="${resultList}" varStatus="status">
		  <tr>
		    <!--td class="lt_text3" nowrap><input type="checkbox" name="check1" class="check2"></td-->
		    <td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
		    <td class="lt_text3" nowrap><c:out value="${result.userId}" /></td>
		    <td class="lt_text3" nowrap><c:out value="${result.userNm}" /></td>
		    <td class="lt_text3" nowrap><c:out value="${result.userAdres}" /></td>
		    <td class="lt_text3" nowrap><c:out value="${result.userEmail}" /></td>
		    <td class="lt_text3" nowrap>
		    <c:choose>
		    	<c:when test="${result.useAt == 'Y'}">
		    		<spring:message code="button.use" />
		    	</c:when>
		    	<c:otherwise>
		    		<spring:message code="button.notUsed" />
		    	</c:otherwise>
		    </c:choose>
		    </td>
			<td class="lt_text3" nowrap>
			<c:if test="${result.useAt == 'Y' || result.deletedAt == 'Y'}">
	    		<input type="button" name="selectUser" value="선택" title="선택"
		    			onClick="javascript:fn_egov_returnUserInfo('<c:out value="${result.uniqId}" />','<c:out value="${result.userNm}" />','<c:out value="${result.userId}" />');"  />
			</c:if>
			</td>
		  </tr>
		 </c:forEach>
		 <c:if test="${fn:length(resultList) == 0}">
		  <tr>
		    <td class="lt_text3" nowrap colspan="6" ><spring:message code="common.nodata.msg" /></td>
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
		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_userInfo" />
	</div>
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="10"></td>
	  </tr>
	</table>
	<div align="center">
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
	<!-- 
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_close()">닫기</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
    -->
      <td><span class="button"><input type="button" value="닫기" title="닫기" onclick="javascript:fn_egov_close();return false;"></span></td>
	</tr>
	</table>
	</div>
</form>
</body>
</html>
