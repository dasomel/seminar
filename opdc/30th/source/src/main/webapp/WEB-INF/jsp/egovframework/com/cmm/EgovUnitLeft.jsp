<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>▒▒▒ eGovFrame 공통 컴포넌트  ▒▒▒</title>
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">
</head>

<body>
<c:set var="isMai" value="false"/>
<c:set var="isUat" value="false"/>
<c:set var="isSec" value="false"/>
<c:set var="isSts" value="false"/>
<c:set var="isCop" value="false"/>
<c:set var="isUss" value="false"/>
<c:set var="isSym" value="false"/>
<c:set var="isSsi" value="false"/>
<c:set var="isDam" value="false"/>
<c:set var="isCom" value="false"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:if test="${isMai == 'false' && result.gid == '0'}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<h1>포털(예제) 메인화면</h1>
				</td>
			</tr>
			<c:set var="isMai" value="true"/>
		</c:if>
		<c:if test="${isUat == 'false' && result.gid == '10'}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>사용자디렉토리/통합인증</h1>
				</td>
			</tr>
			<c:set var="isUat" value="true"/>
		</c:if>
		<c:if test="${isSec == 'false' && result.gid == '20'}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>보안</h1>
				</td>
			</tr>
			<c:set var="isSec" value="true"/>
		</c:if>
		<c:if test="${isSts == 'false' && result.gid == '30'}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>통계/리포팅</h1>
				</td>
			</tr>
			<c:set var="isSts" value="true"/>
		</c:if>
		<c:if test="${isCop == 'false' && result.gid == '40'}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>협업</h1>
				</td>
			</tr>
			<c:set var="isCop" value="true"/>
		</c:if>
		<c:if test="${isUss == 'false' && result.gid == '50'}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>사용자지원</h1>
				</td>
			</tr>
			<c:set var="isUss" value="true"/>
		</c:if>
		<c:if test="${isSym == 'false' && result.gid == '60'}">
			<tr height = "16" >
			    <td align="left"  width="100%">
			    	<br><h1>시스템관리</h1>
				</td>
			</tr>
			<c:set var="isSym" value="true"/>
		</c:if>
		<c:if test="${isSsi == 'false' && result.gid == '70'}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>시스템/서비스연계</h1>
				</td>
			</tr>
			<c:set var="isSsi" value="true"/>
		</c:if>
		<c:if test="${isDam == 'false' && result.gid == '80'}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>디지털 자산 관리</h1>
				</td>
			</tr>
			<c:set var="isDam" value="true"/>
		</c:if>
		<c:if test="${isCom == 'false' && result.gid == '90'}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>요소기술</h1>
				</td>
			</tr>
			<c:set var="isCom" value="true"/>
		</c:if>
		<tr height = "16">
		    <td align="left" valign="center" width="100%">
		    	<a href="${pageContext.request.contextPath}<c:out value="${result.listUrl}"/>" target="_content" class="link"> <c:out value="${result.order}"/>. <c:out value="${result.name}"/></a>
			</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>
