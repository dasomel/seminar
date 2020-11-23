<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovMailDtls.jsp
  * @Description : 발송메일 내역 조회 화면
  * @Modification Information
  * @
  * @  수정일       수정자                   수정내용
  * @ -------      ---------    ---------------------------
  * @ 2009.03.11    박지욱          최초 생성
  * @ 2011.09.30    이기하          데이터 없을시 메시지 추가
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.11
  *  @version 1.0
  *  @see
  *
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/com.css' />" type="text/css">
<link href="<c:url value='/css/egovframework/com/cmm/button.css' />" rel="stylesheet" type="text/css">
<title>MOPAS 발송메일 내역 조회</title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/cop/ems/selectSndngMailList.do' />";
   	document.listForm.submit();
}
/* ********************************************************
 * 조회 처리
 ******************************************************** */
function fnSearch(){
	document.listForm.pageIndex.value = 1;
	document.listForm.action = "<c:url value='/cop/ems/selectSndngMailList.do' />";
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fnRegist(){
	document.listForm.action = "<c:url value='/cop/ems/insertSndngMailView.do' />";
   	document.listForm.submit();
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fnDetail(mid){
	document.detailForm.action = "<c:url value='/cop/ems/selectSndngMailDetail.do' />";
	document.detailForm.mssageId.value = mid;
   	document.detailForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
	var checkField = document.listForm.checkField;
    var id = document.listForm.checkId;
    var fileId = document.listForm.checkFileId;
    var checkedIds = "";
    var checkedFildIds = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedIds += ((checkedCount==0? "" : ",") + id[i].value);
                    checkedFildIds += ((checkedCount==0? "" : ",") + fileId[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkedIds = id.value;
                checkedFildIds = fileId.value;
            }
        }
    }
    if(checkedIds.length > 0) {
    	var ret = confirm("삭제하시겠습니까?");
    	if (ret == true) {
    		document.deleteForm.mssageId.value=checkedIds;
    		document.deleteForm.atchFileIdList.value=checkedFildIds;
    		document.deleteForm.action = "<c:url value='/cop/ems/deleteSndngMailList.do' />";
    	    document.deleteForm.submit();
    	}
    }
}
/* ********************************************************
 * 모두선택 처리 함수
 ******************************************************** */
function fnCheckAll(){
	var checkField = document.listForm.checkField;
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
-->
</script>
</head>

<body onload="document.listForm.searchCondition.focus();">

<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

	<DIV id="content" style="display">
		<form name="listForm" action="<c:url value='/cop/ems/selectSndngMailList.do'/>" method="post">
		    <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<table width="700" cellpadding="8" class="table-search" border="0">
			  <tr>
			    <td width="250"class="title_left"><h1 class="title_left">
			    <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목아이콘이미지">&nbsp;발송내역 조회</h1></td>
			    <th></th>
			    <td width="100">
			   	  <select name="searchCondition" class="select" tabindex="1" title="검색부문" id = "searchCondition">
				    <option selected value=''>--선택하세요--</option>
				    <option value='1'>제목</option>
				    <option value='2'>내용</option>
				    <option value='3'>보낸이</option>
			      </select>
			    </td>
			    <td width="200">
			      <input name="searchKeyword" type="text" size="35" value=""  maxlength="35" tabindex="2" title="제목" id = "searchKeyword">
			    </td>
			    <th width="150">
			      <table border="0" cellspacing="0" cellpadding="0">
			        <tr>
				      <td>&nbsp;&nbsp;</td>
				      <td><span class="button"><input type="submit" value="조회" onclick="fnSearch(); return false;" ></span></td>
				      <td>&nbsp;&nbsp;</td>
				      <td>&nbsp;&nbsp;</td>
				      <td><span class="button"><input type="submit" value="등록" onclick="fnRegist(); return false;"></span></td>
				      <td>&nbsp;&nbsp;</td>
				      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" width="8" height="20" alt="버튼이미지"></td>
				      <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap><a href="#noscript" onclick="fnDelete(); return false;">삭제</a>
				      </td>
				      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif' />" width="8" height="20" alt=""></td>
				      <td>&nbsp;&nbsp;</td>
			        </tr>
			      </table>
			    </th>
			  </tr>
			</table>
			<table width="700" cellspacing="0" cellpadding="0" border="0">
			  <tr>
				<td height="3px"></td>
			  </tr>
			</table>
			<table width="700" cellpadding="0" class="table-line" border="0" summary="상태, 발신자, 수신자, 제목, 날짜의 정보를 가진 발송메일내역을 조회한다.">
			<CAPTION style="display: none;">발송메일 내역 조회</CAPTION>
			<thead>
			  <tr>
				<th scope="col" class="title" width="5%" nowrap><input type="checkbox" name="checkAll" class="check2" onClick="javascript:fnCheckAll();" title="전체선택" id="checkAll" /></th>
				<th scope="col" class="title" width="5%" nowrap>상태</th>
				<th scope="col" class="title" width="15%" nowrap>발신자</th>
				<th scope="col" class="title" width="20%" nowrap>수신자</th>
				<th scope="col" class="title" width="35%" nowrap>제목</th>
				<th scope="col" class="title" width="20%" nowrap>날짜</th>
			  </tr>
			</thead>
			<!-- 목록 조회 시작-->
			<tbody>
			<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
			<c:if test="${fn:length(resultList) == 0}">
			<tr>
			<td class="lt_text3" colspan="6">
				<spring:message code="common.nodata.msg" />
			</td>
			</tr>
			</c:if>
			  <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
			  <tr style="cursor:hand;">
			    <td class="lt_text3" nowrap>
                  <input type="checkbox" name="checkField" class="check2" title="선택">
                  <input name="checkId" type="hidden" value="<c:out value='${resultInfo.mssageId}'/>" title=""/>
                  <input name="checkFileId" type="hidden" value="<c:out value='${resultInfo.atchFileId}'/>" title=""/>
                </td>
			    <td class="lt_text3" nowrap>${resultInfo.sndngResultCode}</td>
			    <td class="lt_text3" nowrap>${resultInfo.dsptchPerson}</td>
			    <td class="lt_text6" nowrap>${resultInfo.recptnPerson}</td>
			    <td class="lt_text6" nowrap><a href="<c:url value='/cop/ems/selectSndngMailDetail.do' />" onclick="fnDetail('${resultInfo.mssageId}'); return false;">${resultInfo.sj}</a></td>
			    <td class="lt_text3" nowrap>${resultInfo.sndngDe}</td>
			  </tr>
			  </c:forEach>
			<!-- 목록 조회 끝-->
			</tbody>
			</table>
			<table width="700" cellspacing="0" cellpadding="0" border="0">
			  <tr>
				<td height="3px"></td>
			  </tr>
			</table>
			<!-- 페이징 시작 -->
			<table width="700" cellspacing="0" cellpadding="0" border="0">
			<tr>
			<td>
			<div align="center">
			  <div>
				<ui:pagination paginationInfo = "${paginationInfo}"	type="image" jsFunction="linkPage"/>
			  </div>
		    </div>
			</td>
		    </tr>
		    </table>
			<!-- 페이징 끝 -->
		</form>
		<!-- 상세조회할 발송메일ID를 담는 폼 -->
		<form name="detailForm" action="<c:url value='/cop/ems/selectSndngMailDetail.do'/>" method="post">
			<input name="mssageId" type="hidden" value=""/>
			<input type="submit" id="invisible" class="invisible"/>
		</form>
		<!-- 삭제할 발송메일ID(여러 ID를 ,로 묶어 만들어진 데이터)를 담는 폼 -->
		<form name="deleteForm" action="<c:url value='/cop/ems/deleteSndngMailList.do'/>" method="post">
			<input name="mssageId" type="hidden" value=""/>
			<input name="atchFileIdList" type="hidden" value=""/>
			<input type="submit" class="invisible"/>
		</form>
	</DIV>
</body>
</html>

