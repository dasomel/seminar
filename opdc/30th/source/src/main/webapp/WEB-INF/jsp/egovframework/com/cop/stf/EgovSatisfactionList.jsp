<!-- import되는 jsp이므로 헤더 관련 내용은 제거되어야 함
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
-->
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
  * @Class Name : EgovSatisfactionList.jsp
  * @Description : 만족도
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
<validator:javascript formName="satisfaction" staticJavascript="false" xhtml="true" cdata="false"/>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
function fn_egov_insert_satisfactionList() {
	if (!validateSatisfaction(document.frm)){
		return;
	}

	if (confirm('<spring:message code="common.regist.msg" />')) {
		document.frm.action = "<c:url value='/cop/stf${prefix}/insertSatisfaction.do'/>";
		document.frm.submit();
	}
}

function fn_egov_updt_satisfactionList() {
	if (!validateSatisfaction(document.frm)){
		return;
	}

	if (confirm('<spring:message code="common.update.msg" />')) {
		document.frm.modified.value = "true";
		document.frm.action = "<c:url value='/cop/stf${prefix}/updateSatisfaction.do'/>";
		document.frm.submit();
	}
}

function fn_egov_selectSatisfactionForupdt(satisfactionNo, index) {
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
	document.frm.stsfdgNo.value = satisfactionNo;
	document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>";
	document.frm.submit();
}

function fn_egov_deleteSatisfactionList(satisfactionNo, index) {
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
		document.frm.stsfdgNo.value = satisfactionNo;
		document.frm.action = "<c:url value='/cop/stf${prefix}/deleteSatisfaction.do'/>";
		document.frm.submit();
	}
}

function fn_egov_select_satisfactionList(pageNo) {
	document.frm.subPageIndex.value = pageNo;
	document.frm.stsfdgNo.value = '';
	document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>";
	document.frm.submit();
}
</script>

</c:if>

<!-- import되는 jsp이므로 헤더 관련 tag는 제거되어야 함 
<title>만족도</title>
 -->
<c:if test="${type == 'body'}">
<input name="subPageIndex" type="hidden" value="<c:out value='${searchVO.subPageIndex}'/>">
<input name="stsfdgNo" type="hidden" value="<c:out value='${searchVO.stsfdgNo}'/>">
<input name="modified" type="hidden" value="false">

<input name="confirmPassword" type="hidden">

<c:if test="${anonymous != 'true'}">
<input type="hidden" name="stsfdgPassword" value="dummy">	<!-- validator 처리를 위해 지정 -->
</c:if>

<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%"class="title_left">
   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목아이콘이미지">
   &nbsp;만족도조사 - <c:out value="${resultCnt}"/>개
   &nbsp;&nbsp;&nbsp;(전체 :
   <c:choose>
	<c:when test="${summary > 4.0}"><span title="<c:out value='${summary}'/>">★★★★★</span></c:when>
	<c:when test="${summary > 3.0}"><span title="<c:out value='${summary}'/>">★★★★☆</span></c:when>
	<c:when test="${summary > 2.0}"><span title="<c:out value='${summary}'/>">★★★☆☆</span></c:when>
	<c:when test="${summary > 1.0}"><span title="<c:out value='${summary}'/>">★★☆☆☆</span></c:when>
	<c:when test="${summary > 0.0}"><span title="<c:out value='${summary}'/>">★☆☆☆☆</span></c:when>
	<c:otherwise></c:otherwise>
   </c:choose>)
   </td>
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
		     		<c:choose>
		     		<c:when test="${result.stsfdg == '5'}"><span title="매우만족">★★★★★</span></c:when>
		     		<c:when test="${result.stsfdg == '4'}"><span title="만족">★★★★☆</span></c:when>
		     		<c:when test="${result.stsfdg == '3'}"><span title="보통">★★★☆☆</span></c:when>
		     		<c:when test="${result.stsfdg == '2'}"><span title="불만족">★★☆☆☆</span></c:when>
		     		<c:when test="${result.stsfdg == '1'}"><span title="매우불만족">★☆☆☆☆</span></c:when>
		     		<c:otherwise><span title="해당없음">☆☆☆☆☆</span></c:otherwise>
		     		</c:choose>&nbsp;
		     		<c:out value="${result.stsfdgCn}" />
		    </td>
		    <td class="listLeft" style="padding-left:10px;" nowrap>

		    <c:if test="${anonymous == 'true' || result.wrterId == sessionUniqId}">
		     <a href="javascript:fn_egov_selectSatisfactionForupdt('<c:out value="${result.stsfdgNo}" />', '<c:out value="${status.index}" />');"><spring:message code="button.update" /></a>
		      | <a href="javascript:fn_egov_deleteSatisfactionList('<c:out value="${result.stsfdgNo}" />', '<c:out value="${status.index}" />');"><spring:message code="button.delete" /></a>
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
	  		<td class="listCenter" nowrap colspan="2">만족도가 없습니다.</td>
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
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_satisfactionList" />
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
	      <input name="wrterNm" type="text" size="20" value='<c:out value="${searchVO.wrterNm}" />' maxlength="20" title="작성자입력">
	      <br>
	      <form:errors path="wrterNm" />
	    </td>
	</tr>
	<tr>
		<th class="emphasisRight"height="23">만족도
		<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
	    <td>
	    	<table border="0" width="100%">
	    		<tr>
	       			<td width="20%" align="center">
	       				<input type="radio" name="stsfdg" value="5" <c:if test="${searchVO.stsfdg == '5'}"> checked="checked"</c:if>>
	       				<span title="매우만족">★★★★★</span>
	       			</td>
	       			<td width="20%" align="center">
	       				<input type="radio" name="stsfdg" value="4" <c:if test="${searchVO.stsfdg == '4'}"> checked="checked"</c:if>>
	       				<span title="만족">★★★★☆</span>
	       			</td>
	       			<td width="20%" align="center">
	       				<input type="radio" name="stsfdg" value="3" <c:if test="${searchVO.stsfdg == '3'}"> checked="checked"</c:if>>
	       				<span title="보통">★★★☆☆</span>
	       			</td>
	       			<td width="20%" align="center">
	       				<input type="radio" name="stsfdg" value="2" <c:if test="${searchVO.stsfdg == '2'}"> checked="checked"</c:if>>
	       				<span title="불만족">★★☆☆☆</span>
	       			</td>
	       			<td width="20%" align="center">
	       				<input type="radio" name="stsfdg" value="1" <c:if test="${searchVO.stsfdg == '1'}"> checked="checked"</c:if>>
	       				<span title="매우불만족">★☆☆☆☆</span>
	       			</td>
	      		</tr>
	      	</table>
	      <form:errors path="stsfdg" />
	    </td>
	  </tr>
	<tr>
		<th height="23">내용</th>
	    <td>
	      <textarea name="stsfdgCn" class="textarea"  cols="50" rows="2"  style="width:100%;" title="내용입력"><c:out value="${searchVO.stsfdgCn}" /></textarea>
	      <form:errors path="stsfdgCn" />
	    </td>
	  </tr>
	  <c:if test="${anonymous == 'true'}">
		  <tr>
		    <th height="23" class="emphasisRight">패스워드
		    <img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
		    <td colspan="3">
		      <input name="stsfdgPassword" type="password" size="20" value="" maxlength="20" title="비밀번호입력">
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
		<c:when test="${searchVO.stsfdgNo == ''}">
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	      <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap>
	      <a href="javascript:fn_egov_insert_satisfactionList()">만족도등록</a>
	      </td>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
		</c:when>
		<c:otherwise>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	      <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap>
	      <a href="javascript:fn_egov_updt_satisfactionList()">만족도수정</a>
	      </td>
	      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
		</c:otherwise>
	</c:choose>
      <td width="10"></td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap>
      <a href="javascript:fn_egov_select_satisfactionList('1')">만족도초기화</a>
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
