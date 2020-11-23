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
  * @Class Name : EgovBoardMstrUpdt.jsp
  * @Description : 게시판 속성정보 변경화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.12   이삼섭          최초 생성
  * @ 2009.06.26   한성곤          2단계 기능 추가 (댓글관리, 만족도조사)
  *   2011.09.15   서준식          2단계 기능 추가 (댓글관리, 만족도조사) 적용 방법 변경
  *   2011.11.11   이기하		   첨부파일선택 여부에 따른 첨부가능파일 숫자에 대한 체크추가
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.12
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
<script type="text/javascript" src="<c:url value="/js/egovframework/com/cop/bbs/EgovBBSMng.js" />" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_validateForm(obj){
		return true;
	}

	function fn_egov_update_brdMstr(){
		if (!validateBoardMaster(document.boardMaster)){
			return;
		}

		//----------------------------
		// 2009.06.26 : 2단계 기능 추가
		//----------------------------
		var theForm = document.boardMaster;
		if ('<c:out value="${result.bbsTyCode}"/>' == 'BBST04' &&
				(theForm.option.options[theForm.option.selectedIndex].value == 'comment' ||
				 theForm.option.options[theForm.option.selectedIndex].value == 'stsfdg')) {
			alert('방명록의 경우는 추가 선택사항을 지원하지 않습니다.');
			theForm.option.focus();
			return;
		}
		////--------------------------
		
		// 2011.11.11 : 첨부파일가능 선택 시 파일숫자를 선택하도록 함, 첨부파일가능 미선택시 파일 숫자를 없음으로 변경
		var list = document.getElementsByName('fileAtchPosblAt');
		var fileAtchPosblAt_value;
		for (var i=0; i < list.length; i++) {
			if(list[i].checked == true) {
				fileAtchPosblAt_value = list[i].value;
			}
		}
		
		if (fileAtchPosblAt_value == "Y" && document.boardMaster.posblAtchFileNumber.value == 0 ) {
			alert("첨부가능파일 숫자를 1개이상 선택하세요.");
			return;
		}
		
		if (fileAtchPosblAt_value == "N" && document.boardMaster.posblAtchFileNumber.value != 0 ) {
			document.boardMaster.posblAtchFileNumber.value = 0;
		}
		////--------------------------


		if(confirm('<spring:message code="common.update.msg" />')){
			document.boardMaster.action = "<c:url value='/cop/bbs/UpdateBBSMasterInf.do'/>";
			document.boardMaster.submit();
		}
	}

	function fn_egov_select_brdMstrList(){
		document.boardMaster.action = "<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>";
		document.boardMaster.submit();
	}

	function fn_egov_delete_brdMstr(){
		if(confirm('<spring:message code="common.delete.msg" />')){
			document.boardMaster.action = "<c:url value='/cop/bbs/DeleteBBSMasterInf.do'/>";
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
</script>
<title>게시판 정보수정</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
<form:form commandName="boardMaster" name="boardMaster" action="${pageContext.request.contextPath}/cop/bbs/SelectBBSMasterInfs.do" method="post" >
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input name="bbsId" type="hidden" value="<c:out value='${result.bbsId}'/>" />
<input name="bbsTyCode" type="hidden" value="<c:out value='${result.bbsTyCode}'/>" />
<input name="bbsAttrbCode" type="hidden" value="<c:out value='${result.bbsAttrbCode}'/>" />
<input name="replyPosblAt" type="hidden" value="<c:out value='${result.replyPosblAt}'/>" />

<div id="border" style="width:730px">

	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	  	<h1>
	  		<img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="제목아이콘이미지">&nbsp;게시판 정보수정
	  	</h1>
	  </td>
	 </tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="게시판명,게시판 소개,게시판 유형,게시판 속성,답장가능여부, ..   입니다">
	  <tr>
	    <th width="20%" height="23" class="required_text" nowrap >
	    	<label for="bbsNm">
	    		게시판명
	    	</label>
	    	<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시">
	    </th>
	    <td width="80%" nowrap colspan="3">
	      <input title="게시판명입력" name="bbsNm" type="text" size="60" value='<c:out value="${result.bbsNm}"/>' maxlength="60" style="width:100%" >
	      <br/><form:errors path="bbsNm" />
	    </td>
	  </tr>

	  <tr>
	    <th height="23" class="required_text" >
	    	<label for="bbsIntrcn">
	    		게시판 소개
	    	</label>
	    	<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시">
	    </th>
	    <td colspan="3">
	      <textarea title="게시판소개입력" name="bbsIntrcn" class="textarea"  cols="75" rows="4"  style="width:100%"><c:out value="${result.bbsIntrcn}" escapeXml="true" /></textarea>
	      <form:errors path="bbsIntrcn" />
	    </td>
	  </tr>

	  <tr>
	    <th width="20%" height="23" class="" nowrap >게시판 유형</th>
	    <td width="30%" nowrap><c:out value="${result.bbsTyCodeNm}"/>
	    </td>
	    <th width="20%" height="23" class="" nowrap >게시판 속성</th>
	    <td width="30%" nowrap><c:out value="${result.bbsAttrbCodeNm}"/>
	    </td>
	  </tr>
	  <tr>
	    <th width="20%" height="23" class="" nowrap >답장가능여부</th>
	    <td>
	    	<c:choose>
	    		<c:when test="${result.replyPosblAt == 'Y'}">
	    			<spring:message code="button.possible" />
	    		</c:when>
	    		<c:otherwise>
	    			<spring:message code="button.impossible" />
	    		</c:otherwise>
	    	</c:choose>
	    </td>
	    <th width="20%" height="23" class="required_text" nowrap >
	    	<label for="fileAtchPosblAt">
	    		파일첨부가능여부
	    	</label>
	    	<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시">
	    </th>
	    <td width="30%" nowrap>
	     	<spring:message code="button.possible" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" value="Y" <c:if test="${result.fileAtchPosblAt == 'Y'}"> checked="checked"</c:if>>&nbsp;
	     	<spring:message code="button.impossible" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" value="N" <c:if test="${result.fileAtchPosblAt == 'N'}"> checked="checked"</c:if>>
	     	<br/><form:errors path="fileAtchPosblAt" />
	    </td>
	  </tr>

	  <tr>
	    <th width="20%" height="23" class="required_text" nowrap >
	    	<label for="posblAtchFileNumber">
	    		첨부가능파일 숫자
	    	</label>
	    	<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="새창">
	    </th>
	    <td width="30%" nowrap colspan="2">
	     	<select title="첨부가능파일 숫자선택" name="posblAtchFileNumber" class="select">
	  		   <option selected value="0">없음</option>
	  		   <option value='1' <c:if test="${result.posblAtchFileNumber == '1'}">selected="selected"</c:if>>1개</option>
	  		   <option value='2' <c:if test="${result.posblAtchFileNumber == '2'}">selected="selected"</c:if>>2개</option>
	  		   <option value='3' <c:if test="${result.posblAtchFileNumber == '3'}">selected="selected"</c:if>>3개</option>
	  	   </select>
	  	   <br/><form:errors path="posblAtchFileNumber" />
	    </td>
	  </tr>

	  <tr>
	    <th width="20%" height="23" class="required_text" nowrap >
	    	<label for="tmplatNm">
	    		템플릿 정보
	    	</label>
	    	<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시">
	    </th>
	    <td width="30%" nowrap colspan="3">
	     <input title="템플릿정보입력" name="tmplatNm" type="text" size="20" value="<c:out value="${result.tmplatNm}"/>"  maxlength="20" readonly >
	     <input name="tmplatId" type="hidden" size="20" value='<c:out value="${result.tmplatId}"/>' >
	     &nbsp;<a href="#LINK" onclick="fn_egov_inqire_tmplatInqire(); return false;"><img src="<c:url value='/images/egovframework/com/cmm/icon/search.gif' />"
	     			width="15" height="15" align="middle" alt="새창"></a>
         <br/><form:errors path="tmplatId" />
	    </td>
	  </tr>
		<!-- 2011.09.15 : 2단계 기능 추가 방법 변경  -->
		<c:if test="${useComment == 'true' || useSatisfaction == 'true'}">
		  <tr>
		    <th width="20%" height="23" class=""><label for="option">추가 선택사항</label></th>
		    <td width="30%" nowrap colspan="3" >
		     	<select name="option" class="select" <c:if test="${result.option != 'na'}">disabled="disabled"</c:if> title="추가선택사항">
						<option value='na' <c:if test="${result.option == 'na'}">selected="selected"</c:if>>---선택하세요--</option>
						<option value='' <c:if test="${result.option == ''}">selected="selected"</c:if>>미선택</option>
					<c:if test="${useComment == 'true' }">
						<option value='comment' <c:if test="${result.option == 'comment'}">selected="selected"</c:if>>댓글</option>
					</c:if>
					<c:if test="${useSatisfaction == 'true' }">
						<option value='stsfdg' <c:if test="${result.option == 'stsfdg'}">selected="selected"</c:if>>만족도조사</option>
					</c:if>
		  	   </select>
		  	   ※ 추가 선택사항은 수정 불가 (미설정된 기존 게시판의 경우 처음 설정은 가능함)
		    </td>
		  </tr>
		</c:if>
		<!-- 2009.06.26 : 2단계 기능 추가 방법 변경 -->
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="10"></td>
	  </tr>
	</table>
	<div align="center">
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
      <td><span class="button"><input type="button" value="<spring:message code="button.update" />" onclick="javascript:fn_egov_update_brdMstr(); return false;"></span></td>
      <td>&nbsp;&nbsp;</td>
      <td><span class="button"><a href="<c:url value='/cop/bbs/DeleteBBSMasterInf.do'/>" onclick="fn_egov_delete_brdMstr(); return false;"><spring:message code="button.delete" /></a></span></td>
      <td>&nbsp;&nbsp;</td>
      <td><span class="button"><input type="submit" value="<spring:message code="button.list" />" onclick="fn_egov_select_brdMstrList(); return false;"></span></td>
	</tr>
	</table>
	</div>
</div>
</form:form>
</body>
</html>
