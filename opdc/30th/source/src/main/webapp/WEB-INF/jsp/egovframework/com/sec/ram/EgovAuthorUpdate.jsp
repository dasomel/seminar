<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%--
/**
 * @Class Name  : egovAuthorUpdate.java
 * @Description : egovAuthorUpdate jsp
 * @Modification Information
 * @
 * @  수정일         수정자          수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.02.01    lee.m.j          최초 생성
 *
 *  @author lee.m.j
 *  @since 2009.03.11
 *  @version 1.0
 *  @see
 *
 */
--%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<c:set var="registerFlag" value="${empty authorManageVO.authorCode ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty authorManageVO.authorCode ? '권한 등록' : '권한 수정'}"/>

<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">
<title>권한관리</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="authorManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectAuthorList() {
	var varFrom = document.getElementById("authorManage");
	varFrom.action = "<c:url value='/sec/ram/EgovAuthorList.do'/>";
	varFrom.submit();
}

function fncAuthorInsert() {

    var varFrom = document.getElementById("authorManage");
    varFrom.action = "<c:url value='/sec/ram/EgovAuthorInsert.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateAuthorManage(varFrom)){
            return;
        }else{
            varFrom.submit();
        }
    }
}

function fncAuthorUpdate() {
	var varFrom = document.getElementById("authorManage");
	varFrom.action = "<c:url value='/sec/ram/EgovAuthorUpdate.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateAuthorManage(varFrom)){
            return;
        }else{
            varFrom.submit();
        }
    }
}

function fncAuthorDelete() {
	var varFrom = document.getElementById("authorManage");
	varFrom.action = "<c:url value='/sec/ram/EgovAuthorDelete.do'/>";
	if(confirm("삭제 하시겠습니까?")){
	    varFrom.submit();
	}
}

</script>
</head>

<body>
<DIV id="main">
<table border="0">
  <tr>
    <td width="700">
<form:form commandName="authorManage" method="post" >

<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%" class="title_left">
   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="제목아이콘이미지">&nbsp;<c:out value="${registerFlagName}"/>
  </td>
  <th width="10%" align="right">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncSelectAuthorList()" style="selector-dummy:expression(this.hideFocus=false);">목록</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td>&nbsp;&nbsp;</td>
      <c:if test="${registerFlag == 'INSERT'}">
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncAuthorInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td>&nbsp;&nbsp;</td>
      </c:if>
      <c:if test="${registerFlag == 'UPDATE'}">
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncAuthorUpdate()" style="selector-dummy:expression(this.hideFocus=false);">수정</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncAuthorDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      </c:if>
    </tr>
   </table>
  </th>
 </tr>
</table>

<table width="100%" cellpadding="8" class="table-line" summary="권한을 수정하는 테이블입니다.권한 코드,권한 명,설명,등록일자 정보를 담고 있습니다.">
  <tr>
    <th class="required_text" width="20%" scope="row"  nowrap="nowrap">권한  코드<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
    <td nowrap="nowrap"><input name="authorCode" id="authorCode" type="text" readonly="readonly" value="<c:out value='${authorManage.authorCode}'/>" size="40" title="권한코드"/>&nbsp;<form:errors path="authorCode" /></td>

  </tr>
  <tr>
    <th class="required_text" width="20%" scope="row"  nowrap="nowrap">권한 명<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
    <td nowrap="nowrap"><input name="authorNm" id="authorNm" type="text" value="<c:out value='${authorManage.authorNm}'/>" maxLength="50" size="40" title="권한명"/>&nbsp;<form:errors path="authorNm" /></td>

  </tr>
  <tr>
    <th class="required_text" width="20%" scope="row"  nowrap="nowrap">설명</th>
    <td nowrap="nowrap"><input name="authorDc" id="authorDc" type="text" value="<c:out value='${authorManage.authorDc}'/>" maxLength="50" size="50" title="설명"/></td>
  </tr>
  <tr>
    <th class="required_text" width="20%" scope="row"  nowrap="nowrap">등록일자</th>
    <td nowrap="nowrap"><input name="authorCreatDe" id="authorCreatDe" type="text" value="<c:out value='${authorManage.authorCreatDe}'/>" maxLength="50" size="20" readonly="readonly" title="등록일자"/></td>
  </tr>
</table>

<!--
    <button type="button" onclick="javascript:fncSelectAuthorList();">List</button>
    <input type="submit" value="<c:out value='${registerFlag}'/>"/>
 -->
<!-- 검색조건 유지 -->
<c:if test="${registerFlag == 'UPDATE'}">
<input type="hidden" name="searchCondition" value="<c:out value='${authorManageVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${authorManageVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${authorManageVO.pageIndex}'/>"/>
</c:if>
</form:form>
    <div align="right">
        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly="readonly" title="메시지"/>
    </div>

</td>
</tr>
</table>
</DIV>
</body>
</html>

