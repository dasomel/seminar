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
  * @Class Name : EgovBBSLoneMstrRegist.jsp
  * @Description : 게시판 생성 화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.08.25   한성곤          최초 생성
  *
  *  @author 공통컴포넌트 개발팀 한성곤
  *  @since 2009.08.25
  *  @version 1.0
  *  @see
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
	function fn_egov_regist_brdMstr(){
		if (!validateBoardMaster(document.boardMaster)){
			return;
		}

		if (confirm('<spring:message code="common.regist.msg" />')) {
			form = document.boardMaster;
			form.action = "<c:url value='/cop/bbs/insertBoardMaster.do'/>";
			form.submit();
		}
	}

	function fn_egov_select_brdMstrList(){
		form = document.boardMaster;
		form.action = "<c:url value='/cop/bbs/selectBoardMasterList.do'/>";
		form.submit();
	}

	function fn_egov_inqire_tmplatInqire(){
		form = document.boardMaster;
		var retVal;
		var url = "<c:url value='/cop/com/openPopup.do?requestUrl=/cop/tpl/selectTemplateInfsPop.do&typeFlag=BBS&width=850&height=360'/>";
		var openParam = "dialogWidth: 900px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";

		retVal = window.showModalDialog(url,"p_tmplatInqire", openParam);
		if(retVal != null){
			var tmp = retVal.split("|");
			form.tmplatId.value = tmp[0];
			form.tmplatNm.value = tmp[1];
		}
	}

</script>

<title>게시판 생성</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

</head>
<body>
<form:form commandName="boardMaster" name="boardMaster" method="post">

<input type="hidden" name="pageIndex"  value="<c:out value='${searchVO.pageIndex}'/>"/>

<div id="border" style="width:730px">

	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="제목버튼이미지">&nbsp;게시판 생성</td>
	 </tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
	  <tr>
	    <th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.bbsNm" />
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="80%" nowrap colspan="3">
	    	<form:input path="bbsNm" size="60" cssStyle="width:100%" />
	    	<br/><form:errors path="bbsNm" />
	    </td>
	  </tr>
	  <tr>
	    <th height="23" class="required_text" ><spring:message code="cop.bbsIntrcn" />
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td colspan="3">
	       <form:textarea path="bbsIntrcn" cols="75" rows="4" cssStyle="width:100%" />
	       <br/><form:errors path="bbsIntrcn" />
	    </td>
	  </tr>
	  <tr>
	    <th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.bbsTyCode" />
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="30%" nowrap>
	        <form:select path="bbsTyCode">
    	  		<form:option value='' label="--선택하세요--" />
	      		<form:options items="${typeList}" itemValue="code" itemLabel="codeNm"/>
      		</form:select>
	  	   <br/><form:errors path="bbsTyCode" />
	    </td>
	    <th width="20%" height="23" class="required_text" nowrap ><spring:message code="cop.bbsAttrbCode" />
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
	    <th width="20%" height="23" class="required_text" ><spring:message code="cop.replyPosblAt" />
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="30%" nowrap>
	     	<spring:message code="button.possible" /> : <form:radiobutton path="replyPosblAt"  value="Y" />&nbsp;
	     	<spring:message code="button.impossible" /> : <form:radiobutton path="replyPosblAt"  value="N"  />
	     	 <br/><form:errors path="replyPosblAt" />
	    </td>
	    <th width="20%" height="23" class="required_text" ><spring:message code="cop.fileAtchPosblAt" />
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="30%" nowrap>
	     	<spring:message code="button.possible" /> : <form:radiobutton path="fileAtchPosblAt"  value="Y" />&nbsp;
	     	<spring:message code="button.impossible" /> : <form:radiobutton path="fileAtchPosblAt"  value="N"  />
	     	 <br/><form:errors path="fileAtchPosblAt" />
	    </td>
	  </tr>
	  <tr>
	    <th width="20%" height="23" class="required_text"  ><spring:message code="cop.posblAtchFileNumber" />
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="30%" nowrap colspan="3" >
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
	    <th width="20%" height="23" class="required_text" ><spring:message code="cop.tmplatId" />
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="30%" nowrap colspan="3">
	     <form:input path="tmplatNm" size="20" readonly="true"/>
	     <form:hidden path="tmplatId"  />
	     &nbsp;<a href="javascript:fn_egov_inqire_tmplatInqire()" style="selector-dummy: expression(this.hideFocus=false);"><img src="<c:url value='/images/egovframework/com/cmm/icon/search.gif' />"
	     			width="15" height="15" align="middle" alt="search" /></a>
		 <br/><form:errors path="tmplatId" />
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
	<!-- 
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_regist_brdMstr();"><spring:message code="button.create" /></a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:fn_egov_select_brdMstrList()"><spring:message code="button.list" /></a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
     -->
    	<td><span class="button"><input type="submit" value="<spring:message code="button.create" />" title="<spring:message code="button.create" />" onclick="javascript:fn_egov_regist_brdMstr();return false;"></span></td>
    	<td width="10"></td>
    	<td><span class="button"><input type="submit" value="<spring:message code="button.list" />" title="<spring:message code="button.list" />" onclick="javascript:fn_egov_select_brdMstrList();return false;"></span></td>     
	</tr>
	</table>
	</div>
</div>
</form:form>
</body>
</html>
