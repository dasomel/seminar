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
  * @Class Name : EgovCommentList.jsp
  * @Description : 댓글
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.06.29   한성곤          최초 생성
  *
  *  @author 공통컴포넌트개발팀 한성곤
  *  @since 2009.06.29
  *  @version 1.0
  *  @see
  *
  */
%>

<c:if test="${type == 'head'}">
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="comment" staticJavascript="false" xhtml="true" cdata="false"/>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
function fn_egov_insert_commentList() {

	if (!validateComment(document.frm)){
		return;
	}
	if (confirm('<spring:message code="common.regist.msg" />')) {
		document.frm.action = "<c:url value='/cop/cmt${prefix}/insertComment.do'/>";
		document.frm.submit();
	}
}

function fn_egov_updt_commentList() {
	if (!validateComment(document.frm)){
		return;
	}

	if (confirm('<spring:message code="common.update.msg" />')) {
		document.frm.modified.value = "true";
		document.frm.action = "<c:url value='/cop/cmt${prefix}/updateComment.do'/>";
		document.frm.submit();
	}
}

function fn_egov_selectCommentForupdt(commentNo, index) {
	<c:if test="${anonymous == 'true'}">
	var passwordObject;

	if (typeof(document.frm.testPassword.length) == 'undefined') {
		password = document.frm.testPassword;
	} else {
		password = document.frm.testPassword[index];
	}

	if ("<c:out value='${anonymous}'/>" == "true" && password.value == '') {
		alert('등록시 사용한 패스워드를 입력해 주세요.');
		password.focus();
		return;
	}

	document.frm.confirmPassword.value = password.value;
	</c:if>
	document.frm.commentNo.value = commentNo;
	document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>";
	document.frm.submit();
}

function fn_egov_deleteCommentList(commentNo, index) {
	<c:if test="${anonymous == 'true'}">
	var passwordObject;

	if (typeof(document.frm.testPassword.length) == 'undefined') {
		password = document.frm.testPassword;
	} else {
		password = document.frm.testPassword[index];
	}

	if ("<c:out value='${anonymous}'/>" == "true" && password.value == '') {
		alert('등록시 사용한 패스워드를 입력해 주세요.');
		password.focus();
		return;
	}

	document.frm.confirmPassword.value = password.value;
	</c:if>

	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.modified.value = "true";
		document.frm.commentNo.value = commentNo;
		document.frm.action = "<c:url value='/cop/cmt${prefix}/deleteComment.do'/>";
		document.frm.submit();
	}
}

function fn_egov_select_commentList(pageNo) {
	document.frm.subPageIndex.value = pageNo;
	document.frm.commentNo.value = '';
	document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>";
	document.frm.submit();
}
</script>

</c:if>

<c:if test="${type == 'body'}">
<input name="subPageIndex" type="hidden" value="<c:out value='${searchVO.subPageIndex}'/>">
<input name="commentNo" type="hidden" value="<c:out value='${searchVO.commentNo}'/>">
<input name="modified" type="hidden" value="false">

<input name="confirmPassword" type="hidden">

<c:if test="${anonymous != 'true'}">
<input type="hidden" name="commentPassword" value="dummy">	<!-- validator 처리를 위해 지정 -->
</c:if>


<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%"class="title_left">
   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목아이콘이미지">
   &nbsp;댓글 - <c:out value="${resultCnt}"/>개</td>
 </tr>
</table>

<table width="100%" cellpadding="8" class="listTable">
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="listLeft" width="70%" style="padding-left:10px;" nowrap>
		    		<c:choose>
		    			<c:when test="${not empty result.wrterNm}">
		    			<b><c:out value="${result.wrterNm}" /></b>&nbsp;
		    			</c:when>
		    			<c:otherwise>
		    			<b><c:out value="${result.frstRegisterNm}" /></b>&nbsp;
		    			</c:otherwise>
		    		</c:choose>
		     		<c:out value="${result.frstRegisterPnttm}" /><br>
		     		<c:out value="${result.commentCn}" />
		    </td>
		    <td class="listLeft" style="padding-left:10px;" nowrap>

		    <c:if test="${anonymous == 'true' || result.wrterId == sessionUniqId}">
		     <a href="javascript:fn_egov_selectCommentForupdt('<c:out value="${result.commentNo}" />', '<c:out value="${status.index}" />');"><spring:message code="button.update" /></a>
		      | <a href="javascript:fn_egov_deleteCommentList('<c:out value="${result.commentNo}" />', '<c:out value="${status.index}" />');"><spring:message code="button.delete" /></a>
		    </c:if>
		    <c:if test="${anonymous == 'true'}">
		    <br>
		    	패스워드 : <input name="testPassword" type="password" size="20" value="" maxlength="20" title="비밀번호입력">
		    </c:if>
		    </td>
		  </tr>
 		</c:forEach>
		 <c:if test="${fn:length(resultList) == 0}">
		  <tr>
	  		<td class="listCenter" nowrap colspan="2">댓글이 없습니다.</td>
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
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_commentList" />
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="10"></td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="generalTable">
	<tr>
		<th width="20%" height="23" class="emphasisRight" nowrap>작성자
		<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td width="80%" nowrap>
	      <input name="wrterNm" type="text" size="20" value='<c:out value="${searchVO.wrterNm}" />' maxlength="20" title="작성자이름입력">
	      <br>
	      <form:errors path="wrterNm" />
	    </td>
	</tr>
	<tr>
		<th height="23" class="emphasisRight" >내용
	    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td>
	      <textarea name="commentCn" class="textarea"  cols="50" rows="4"  style="width:100%;" title="댓글내용입력"><c:out value="${searchVO.commentCn}" /></textarea>
	      <form:errors path="commentCn" />
	    </td>
	  </tr>
	  <c:if test="${anonymous == 'true'}">
		  <tr>
		    <th height="23" class="emphasisRight">패스워드
		    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
		    <td colspan="3">
		      <input name="commentPassword" type="password" size="20" value="" maxlength="20" title="비밀번호입력">
		    </td>
		  </tr>
	  	</c:if>
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
		<c:when test="${searchVO.commentNo == ''}">
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	      <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap>
	      <a href="javascript:fn_egov_insert_commentList()">댓글등록</a>
	      </td>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
		</c:when>
		<c:otherwise>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	      <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap>
	      <a href="javascript:fn_egov_updt_commentList()">댓글수정</a>
	      </td>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
		</c:otherwise>
	</c:choose>
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap>
      <a href="javascript:fn_egov_select_commentList('1')">댓글초기화</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	</tr>
	</table>
	</div>
<c:if test="${not empty subMsg}">
<script>
	alert("<c:out value='${subMsg}'/>");
</script>
</c:if>
</c:if>
