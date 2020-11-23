<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${loginVO != null}">
		${loginVO.name }님 환영합니다. <a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do">로그아웃</a>
	</c:if>
	<c:if test="${loginVO == null }">
		<jsp:forward page="/uat/uia/egovLoginUsr.do"/>
	</c:if>
	<c:if test="${loginVO.sexdstnCode == 'M'}"> <br/>당신의 성별은 남자 입니다.</c:if>
	<c:if test="${loginVO.sexdstnCode == 'F'}"> <br/>당신의 성별은 여자 입니다.</c:if>
	<c:if test="${loginVO.sexdstnCode == ' '}"> <br/>당신의 성별은 기업사용자 입니다. </c:if>
	
</body>
</html>