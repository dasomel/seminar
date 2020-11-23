<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%--
/**
 * @Class Name  : EgovAuthorUpdate.java
 * @Description : EgovAuthorUpdate jsp
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

<c:set var="registerFlag" value="${empty groupManageVO.groupId ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty groupManageVO.groupId ? '그룹 등록' : '그룹 수정'}"/>

<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">
<title>그룹관리</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="groupManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectGroupList() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupList.do'/>";
    varFrom.submit();
}

function fncGroupInsert() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupInsert.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateGroupManage(varFrom)){
            return;
        }else{
            varFrom.submit();
        }
    }
}

function fncGroupUpdate() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupUpdate.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateGroupManage(varFrom)){
            return;
        }else{
            varFrom.submit();
        }
    }
}

function fncGroupDelete() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupDelete.do'/>";
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
<form:form commandName="groupManage" method="post" >

<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="40%" class="title_left">
   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="제목아이콘이미지">&nbsp;<c:out value="${registerFlagName}"/>
  </td>
  <th width="10%" align="right">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncSelectGroupList()" style="selector-dummy:expression(this.hideFocus=false);">목록</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td>&nbsp;&nbsp;</td>
      <c:if test="${registerFlag == 'INSERT'}">
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncGroupInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td>&nbsp;&nbsp;</td>
      </c:if>
      <c:if test="${registerFlag == 'UPDATE'}">
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncGroupUpdate()" style="selector-dummy:expression(this.hideFocus=false);">수정</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncGroupDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      </c:if>
    </tr>
   </table>
  </th>
 </tr>
</table>

<table width="100%" cellpadding="8" class="table-line" summary="그룹을 수정하는 테이블입니다.그룹 ID,그룹 명,설명,등록일자 정보를 담고 있습니다.">
  <tr>
    <th class="required_text" width="25%" scope="row"  nowrap="nowrap">그룹 ID<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
    <td nowrap="nowrap"><input name="groupId" id="groupId" type="text" readonly="readonly" value="<c:out value='${groupManage.groupId}'/>" size="40" title="그룹 ID" /></td>
  </tr>
  <tr>
    <th class="required_text" width="25%" scope="row"  nowrap="nowrap">그룹 명<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
    <td nowrap="nowrap"><input name="groupNm" id="groupNm" type="text" value="<c:out value='${groupManage.groupNm}'/>" maxLength="50" size="40" title="그룹명" />&nbsp;<form:errors path="groupNm" /></td>
  </tr>
  <tr>
    <th class="required_text" width="20%" scope="row"  nowrap="nowrap">설명</th>
    <td nowrap="nowrap"><input name="groupDc" id="groupDc" type="text" value="<c:out value='${groupManage.groupDc}'/>" maxLength="50" size="50" title="설명" /></td>
  </tr>
  <tr>
    <th class="required_text" width="20%" scope="row"  nowrap="nowrap">등록일자</th>
    <td nowrap="nowrap"><input name="groupCreatDe" id="groupCreatDe" type="text" value="<c:out value='${groupManage.groupCreatDe}'/>" maxLength="50" size="20" readonly="readonly" title="등록일자"/></td>
  </tr>
</table>

<!-- 검색조건 유지 -->
<c:if test="${registerFlag == 'UPDATE'}">
<input type="hidden" name="searchCondition" value="<c:out value='${groupManageVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${groupManageVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
</c:if>
</form:form>
    <div align="right">
        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly="readonly" title="메시지" />
    </div>

</td>
</tr>
</table>
</DIV>
</body>
</html>

