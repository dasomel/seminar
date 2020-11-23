<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovBdListPortlet.jsp
  * @Description : 커뮤니티/동호회 사용 게시판 목록 조회 포틀릿화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.04.08   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.04.08
  *  @version 1.0
  *  @see
  *
  */
%>
<c:forEach var="result" items="${resultList}" varStatus="status">
	<li><a href="javascript:fn_egov_loadBdList('<c:out value="${result.bbsId}"/>',
		'<c:out value="${result.bbsAttrbCode}"/>','<c:out value="${result.bbsTyCode}"/>');">
		<c:out value="${result.bbsNm}" /></a></li>
</c:forEach>
