<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
 /**
  * @Class Name : EgovBdMstrRegistByTrget.jsp
  * @Description : 커뮤니티/동호회의 게시판 생성 화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.04.08   이삼섭          최초 생성
  * @ 2009.06.26   한성곤          2단계 기능 추가 (댓글관리, 만족도조사)
  *   2011.09.15   서준식          댓글, 만족도조사 컴포넌트 사용 체크 방법 변경
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.04.08
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
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cop/bbs/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_validateForm(obj){
		return true;
	}

	function fn_egov_regist_brdMstr(){
		if (!validateBoardMaster(document.boardMaster)){
			return;
		}

		//----------------------------
		// 2009.06.26 : 2단계 기능 추가
		//----------------------------
		var theForm = document.boardMaster;
		if (theForm.bbsTyCode.options[theForm.bbsTyCode.selectedIndex].value == 'BBST04' &&
				theForm.option.options[theForm.option.selectedIndex].value != '') {
			alert('방명록의 경우는 추가 선택사항을 지원하지 않습니다.');
			theForm.option.focus();
			return;
		}
		////--------------------------

		if (confirm('<spring:message code="common.regist.msg" />')) {
			document.boardMaster.action = "<c:url value='/cop/bbs/insertBdMstrByTrget.do'/>";
			document.boardMaster.submit();
		}
	}

	function fn_egov_inqire_tmplatInqire(){
		var retVal;
		var url = "<c:url value='/cop/com/openPopup.do?requestUrl=/cop/tpl/selectTemplateInfsPop.do&typeFlag=BBS&width=850&height=360'/>";
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";

		retVal = window.showModalDialog(url,"p_tmplatInqire", openParam);
		if(retVal != null){
			var tmp = retVal.split("|");
			document.boardMaster.tmplatId.value = tmp[0];
			document.boardMaster.tmplatNm.value = tmp[1];
		}
	}

	function fn_egov_select_brdMstrList() {
		document.boardMaster.action = "<c:url value='/cop/bbs/selectBdMstrListByTrget.do'/>";
		document.boardMaster.submit();
	}
	
	function fn_egov_message(){
		alert('<spring:message code="success.common.insert" />');
	}
</script>

<title>게시판 생성</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body >
<form:form commandName="boardMaster" name="boardMaster" method="post">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input name="trgetId" type="hidden" value="<c:out value='${searchVO.trgetId}'/>" />

<div id="border" style="width:730px">
	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="제목버튼이미지">&nbsp;게시판 생성</td>
	 </tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
	  <tr>
	    <th width="20%" height="23" class="required_text" nowrap >게시판명
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="80%" nowrap colspan="3">
	      <form:input path="bbsNm" size="60" cssStyle="width:100%" />
	      <br/><form:errors path="bbsNm" />
	    </td>
	  </tr>
	  <tr>
	    <th height="23" class="required_text" >게시판 소개
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td colspan="3">
	      <form:textarea path="bbsIntrcn" cols="75" rows="4" cssStyle="width:100%" />
	      <form:errors path="bbsIntrcn" />
	    </td>
	  </tr>
	  <tr>
	    <th width="20%" height="23" class="required_text" nowrap >게시판 유형
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="30%" nowrap>
	        <form:select path="bbsTyCode">
    	  		<form:option value='' label="--선택하세요--" />
	      		<form:options items="${typeList}" itemValue="code" itemLabel="codeNm"/>
      		</form:select>
	  	   <br/><form:errors path="bbsTyCode" />
	    </td>
	    <th width="20%" height="23" class="required_text" nowrap >게시판 속성
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="30%" nowrap>
	        <form:select path="bbsAttrbCode">
    	  		<form:option value='' label="--선택하세요--" />
	      		<form:options items="${attrbList}" itemValue="code" itemLabel="codeNm"/>
      		</form:select>
	  	    <br/><form:errors path="bbsAttrbCode" />
	    </td>
	  </tr>
	  <tr>
	    <th width="20%" height="23" class="required_text" nowrap >답장가능여부
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="30%" nowrap class="">
	     	<spring:message code="button.possible" /> : <form:radiobutton path="replyPosblAt"  value="Y" />&nbsp;
	     	<spring:message code="button.impossible" /> : <form:radiobutton  path="replyPosblAt"  value="N"  />
	     	 <br/><form:errors path="replyPosblAt" />
	    </td>
	    <th width="20%" height="23" class="required_text" nowrap >파일첨부가능여부
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="30%" nowrap class="">
	     	<spring:message code="button.possible" /> : <form:radiobutton path="fileAtchPosblAt"  value="Y" />&nbsp;
	     	<spring:message code="button.impossible" /> : <form:radiobutton path="fileAtchPosblAt"  value="N"  />
	     	 <br/><form:errors path="fileAtchPosblAt" />
 	    </td>
	  </tr>
	  <tr>
	    <th width="20%" height="23" class="required_text" nowrap >첨부가능파일 숫자
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="30%" nowrap colspan="3">
	     	<form:select path="posblAtchFileNumber" >
	  		   <form:option value="0"  label="---선택하세요--" />
	  		   <form:option value='1'>1개</form:option>
	  		   <form:option value='2'>2개</form:option>
	  		   <form:option value='3'>3개</form:option>
	  	   </form:select>
	  	    <br/><form:errors path="posblAtchFileNumber" />
	    </td>
	  </tr>
	  <tr>
	    <th width="20%" height="23" class="required_text" nowrap >템플릿 정보
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="30%" nowrap colspan="3">
	     <form:input path="tmplatNm"  size="20"  />
	     <form:hidden path="tmplatId"  />
	     &nbsp;<a href="javascript:fn_egov_inqire_tmplatInqire()" style="selector-dummy: expression(this.hideFocus=false);"><img src="<c:url value='/images/egovframework/com/cmm/icon/search.gif' />"
	     			width="15" height="15" align="middle" alt="search" /></a>
		<br/><form:errors path="tmplatId" />
	    </td>
	  </tr>
		<!-- 2011.09.15 : 2단계 기능 추가 방법 변경  -->
		<c:if test="${useComment == 'true' || useSatisfaction == 'true'}">

		  <tr>
		    <th width="20%" height="23" class="">추가 선택사항</th>
		    <td width="30%" nowrap colspan="3" >
		     	<form:select path="option" >
		  		   <!-- form:option value=''--><!--선택하세요--><!-- /option-->
		  		   	<form:option value=""  label="미선택" />
		  		   <c:if test="${useComment == 'true' }">
		  		   	<form:option value='comment'>댓글</form:option>
		  		   </c:if>
		  		   <c:if test="${useSatisfaction == 'true' }">
		  		   	<form:option value='stsfdg'>만족도조사</form:option>
		  		   </c:if>

		  	   </form:select>
		    </td>
		  </tr>

		</c:if>
		<!-- 2011.09.15 : 2단계 기능 추가 방법 변경  -->
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="10"></td>
	  </tr>
	</table>
	<div align="center">
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
      <td><span class="button"><input type="submit" value="등록" title="등록" onclick="javascript:fn_egov_regist_brdMstr()();return false;"></span></td>
      <td width="10"></td>
      <td><span class="button"><input type="submit" value="목록" title="목록" onclick="javascript:fn_egov_select_brdMstrList();return false;"></span></td>
	</tr>
	</table>
	</div>
</div>
</form:form>
</body>
</html>
