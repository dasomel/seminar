<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.cmm.LoginVO" %>
<%@ page import="egovframework.com.cmm.util.EgovUserDetailsHelper" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%
 /**
  * @Class Name : EgovGroupManage.java
  * @Description : EgovGroupManage List 화면
  * @Modification Information
  * @
  * @  수정일                     수정자               수정내용
  * @ ----------    --------    ---------------------------
  * @ 2009.02.01    lee.m.j     최초 생성
  *
  *  @author lee.m.j
  *  @since 2009.03.11
  *  @version 1.0
  *  @see
  *
  */
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">
<title>그룹관리</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncCheckAll() {
    var checkField = document.listForm.delYn;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    var returnBoolean = false;
    var checkCount = 0;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkCount++;
                    checkField[i].value = checkId[i].value;

                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else
                        returnValue = returnValue + ";" + checkField[i].value;
                }
            }
            if(checkCount > 0)
                returnBoolean = true;
            else {
                alert("선택된  그룹이 없습니다.");
                returnBoolean = false;
            }
        } else {
        	 if(document.listForm.delYn.checked == false) {
                alert("선택된 그룹이 없습니다.");
                returnBoolean = false;
            }
            else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
        alert("조회된 결과가 없습니다.");
    }

    document.listForm.groupIds.value = returnValue;

    return returnBoolean;
}

function fncSelectGroupList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/gmt/EgovGroupList.do'/>";
    document.listForm.submit();
}

function fncSelectGroup(groupId) {
    document.listForm.groupId.value = groupId;
    document.listForm.action = "<c:url value='/sec/gmt/EgovGroup.do'/>";
    document.listForm.submit();
}

function fncAddGroupInsert() {
    location.replace("<c:url value='/sec/gmt/EgovGroupInsertView.do'/>");
}

function fncGroupListDelete() {
	if(fncManageChecked()) {
	    if(confirm("삭제하시겠습니까?")) {
            document.listForm.action = "<c:url value='/sec/gmt/EgovGroupListDelete.do'/>";
            document.listForm.submit();
	    }
	}
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/gmt/EgovGroupList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectGroupList('1');
    }
}
//-->
</script>

</head>

<body>
<DIV id="main">

<table border="0">
  <tr>
    <td width="700">

<form:form name="listForm" action="${pageContext.request.contextPath}/sec/gmt/EgovAuthorList.do" method="post">
<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="20%" class="title_left">
   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="제목아이콘이미지">&nbsp;그룹 관리</td>

  <td width="60%" >그룹 명 : <input name="searchKeyword" type="text" value="<c:out value='${groupManageVO.searchKeyword}'/>" size="25" title="검색" onkeypress="press();" /></td>
  <th width="20%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncSelectGroupList('1')" style="selector-dummy:expression(this.hideFocus=false);">조회</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncAddGroupInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncGroupListDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
    </tr>
   </table>
  </th>
 </tr>
</table>
<table width="100%" cellpadding="8" class="table-line" summary="그룹 관리에 관한 테이블입니다.그룹 ID,그룹 명,설명,등록일자의 정보를 담고 있습니다.">
 <thead>
  <tr>
    <th class="title" width="3%" scope="col" nowrap="nowrap"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()" title="전체선택"></th>
    <th class="title" width="15%" scope="col" nowrap="nowrap">그룹 ID</th>
    <th class="title" width="25%" scope="col" nowrap="nowrap">그룹 명</th>
    <th class="title" width="40%" scope="col" nowrap="nowrap">설명</th>
    <th class="title" width="15%" scope="col" nowrap="nowrap">등록일자</th>
    <th class="title" width="5%" scope="col" nowrap="nowrap"></th>
  </tr>
 </thead>
 <tbody>
 <c:forEach var="group" items="${groupList}" varStatus="status">
  <tr>
    <td class="lt_text3" nowrap="nowrap"><input type="checkbox" name="delYn" class="check2" title="선택"><input type="hidden" name="checkId" value="<c:out value="${group.groupId}"/>" /></td>
    <td class="lt_text" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncSelectGroup('<c:out value="${group.groupId}"/>')"><c:out value="${group.groupId}"/></a></td>
    <td class="lt_text" nowrap="nowrap"><c:out value="${group.groupNm}"/></td>
    <td class="lt_text3" nowrap="nowrap"><c:out value="${group.groupDc}"/></td>
    <td class="lt_text3" nowrap="nowrap"><c:out value="${group.groupCreatDe}"/></td>
    <td class="lt_text3" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncSelectGroup('<c:out value="${group.groupId}"/>')"><img src="<c:url value='/images/egovframework/com/cmm/icon/search.gif'/>" width="15" height="15" align="middle" alt="상세조회"></a></td>

  </tr>
 </c:forEach>
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

<c:if test="${!empty groupManageVO.pageIndex }">
<div align="center">
    <div>
        <ui:pagination paginationInfo = "${paginationInfo}"
            type="default"
            jsFunction="linkPage"
            />
    </div>
    <div align="right">
        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly="readonly" title="메시지"/>
    </div>
</div>
</c:if>
<input type="hidden" name="groupId"/>
<input type="hidden" name="groupIds"/>
<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
<input type="hidden" name="searchCondition"/>
</form:form>
</td>
</tr>
</table>
</DIV>
</body>
</html>
