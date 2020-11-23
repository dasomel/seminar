<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovUserLogInqire.jsp
  * @Description : 사용자 로그 정보 상세조회 화면
  * @Modification Information
  * @
  * @  수정일         수정자          수정내용
  * @ -------        --------       ---------------------------
  * @ 2009.03.11      이삼섭          최초 생성
  * @ 2011.07.08      이기하          패키지 분리로 경로 수정(sym.log -> sym.log.ulg)
  *
  *  @author 공통서비스 개발팀 이삼섭
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

<title>사용자 로그 상세보기</title>
</head>
<body>
	<table width="700" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle" alt="제목아이콘이미지">&nbsp;사용자 로그 정보</td>
	 </tr>
	</table>
	<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register">
	 <tr>
	    <th width="20%" height="23" align="center">발생일자</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.occrrncDe}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center">사용자</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.rqsterNm}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center">서비스명</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.srvcNm}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center">메소드명</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.methodNm}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center">생성</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.creatCo}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center">수정</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.updtCo}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center">조회</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.rdCnt}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center">삭제</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.deleteCo}"/>
	    </td>
	  </tr>
	</table>
	<table width="700" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="10"></td>
	  </tr>
	</table>
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
      <td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>" class="text_left" nowrap>
      <a href="javascript:window.close()">닫기</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	</tr>
	</table>
</body>
</html>
