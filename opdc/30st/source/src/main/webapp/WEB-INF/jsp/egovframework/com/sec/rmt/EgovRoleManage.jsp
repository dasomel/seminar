<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%

/**
 * @Class Name : EgovRoleManage.java
 * @Description : EgovRoleManage jsp
 * @Modification Information
 * @
 * @  수정일                    수정자                수정내용
 * @ ---------     --------    ---------------------------
 * @ 2009.02.01    lee.m.j     최초 생성
 *
 *  @author lee.m.j
 *  @since 2009.03.21
 *  @version 1.0
 *  @see
 *
 */

%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">
<title>롤관리</title>

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
                alert("선택된  롤이 없습니다.");
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("선택된 롤이 없습니다.");
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

    document.listForm.roleCodes.value = returnValue;
    return returnBoolean;
}

function fncSelectRoleList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rmt/EgovRoleList.do'/>";
    document.listForm.submit();
}

function fncSelectRole(roleCode) {
    document.listForm.roleCode.value = roleCode;
    document.listForm.action = "<c:url value='/sec/rmt/EgovRole.do'/>";
    document.listForm.submit();
}

function fncAddRoleInsert() {
    location.replace("<c:url value='/sec/rmt/EgovRoleInsertView.do'/>");
}

function fncRoleListDelete() {
	if(fncManageChecked()) {
        if(confirm("삭제하시겠습니까?")) {
            document.listForm.action = "<c:url value='/sec/rmt/EgovRoleListDelete.do'/>";
            document.listForm.submit();
        }
    }
}

function fncAddRoleView() {
    document.listForm.action = "<c:url value='/sec/rmt/EgovRoleUpdate.do'/>";
    document.listForm.submit();
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rmt/EgovRoleList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectRoleList('1');
    }
}
-->
</script>

</head>

<body>
<DIV id="main" style="display:">

<table border="0">
  <tr>
    <td width="700">

<form:form name="listForm" action="${pageContext.request.contextPath}/sec/rmt/EgovRoleList.do" method="post">
<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="20%"class="title_left">
   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="제목아이콘이미지">&nbsp;롤 관리</td>

  <td width="60%">롤 명 : <input name="searchKeyword" type="text" value="<c:out value='${roleManageVO.searchKeyword}'/>" size="25" title="검색" onkeypress="press();" /></td>
  <th width="20%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncSelectRoleList('1')" style="selector-dummy:expression(this.hideFocus=false);">조회</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncAddRoleInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td>&nbsp;&nbsp;</td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td class="btnBackground" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncRoleListDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
    </tr>
   </table>
  </th>
 </tr>
</table>
<table width="100%" cellpadding="8" class="table-line" summary="롤 관리 테이블입니다.롤  ID,롤 명,롤 타입,롤 Sort,롤 설명,등록일자의 정보를 담고 있습니다.">
 <thead>
  <tr>
    <th class="title" width="3%" scope="col" nowrap="nowrap"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()" title="전체선택"></th>
    <th class="title" width="10%" scope="col" nowrap="nowrap">롤 ID</th>
    <th class="title" width="20%" scope="col" nowrap="nowrap">롤 명</th>
    <th class="title" width="10%" scope="col" nowrap="nowrap">롤 타입</th>
    <th class="title" width="10%" scope="col" nowrap="nowrap">롤 Sort</th>
    <th class="title" width="30%" scope="col" nowrap="nowrap">롤 설명</th>
    <th class="title" width="12%" scope="col" nowrap="nowrap">등록일자</th>
    <th class="title" width="5%" scope="col" nowrap="nowrap"></th>
  </tr>
 </thead>
 <tbody>
 <%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
<c:if test="${fn:length(roleList) == 0}">
<tr>
<td class="lt_text3" colspan="8">
	<spring:message code="common.nodata.msg" />
</td>
</tr>
</c:if>
 <c:forEach var="role" items="${roleList}" varStatus="status">
  <tr>
    <td class="lt_text3" nowrap="nowrap"><input type="checkbox" name="delYn" class="check2" title="선택"><input type="hidden" name="checkId" value="<c:out value="${role.roleCode}"/>" /></td>
    <td class="lt_text" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncSelectRole('<c:out value="${role.roleCode}"/>')"><c:out value="${role.roleCode}"/></a></td>
    <td class="lt_text" nowrap="nowrap"><c:out value="${role.roleNm}"/></td>
    <td class="lt_text3" nowrap="nowrap"><c:out value="${role.roleTyp}"/></td>
    <td class="lt_text3" nowrap="nowrap"><c:out value="${role.roleSort}"/></td>
    <td class="lt_text3" nowrap="nowrap"><c:out value="${role.roleDc}"/></td>
    <td class="lt_text3" nowrap="nowrap"><c:out value="${role.roleCreatDe}"/></td>
    <td class="lt_text3" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncSelectRole('<c:out value="${role.roleCode}"/>')"><img src="<c:url value='/images/egovframework/com/cmm/icon/search.gif'/>" width="15" height="15" align="middle"  alt="상세조회"></a></td>
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

<c:if test="${!empty roleManageVO.pageIndex }">
<div align="center">
    <div>
        <ui:pagination paginationInfo = "${paginationInfo}"
            type="default"
            jsFunction="linkPage"
            />
    </div>
    <div align="right">
        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly="readonly" title="메시지" />
    </div>
</div>
</c:if>
<input type="hidden" name="roleCode"/>
<input type="hidden" name="roleCodes"/>
<input type="hidden" name="pageIndex" value="<c:out value='${roleManageVO.pageIndex}'/>"/>
<input type="hidden" name="searchCondition"/>
</form:form>
</td>
</tr>
</table>
</DIV>
</body>
</html>
