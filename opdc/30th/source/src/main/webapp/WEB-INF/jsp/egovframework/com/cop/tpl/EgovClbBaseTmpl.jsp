<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
/**
 * @Class Name : EgovClbBaseTmpl.jsp
 * @Description : 동호회 기본 템플릿
 * @Modification Information
 * @
 * @  수정일     		 수정자           	 수정내용
 * @ -------        --------    ---------------------------
 * @ 2009.04.07   	이삼섭      		최초 생성
 	 2011.9.7		정진오		익명게시판 화면이 표출되도록 수정
 *
 *  @author 공통서비스 개발팀 이삼섭
 *  @since 2009.04.07
 *  @version 1.0
 *  @see
 *
 */
%>

<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><c:out value='${clubVO.clbNm}' /></title>
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">
<style type="text/css">

A.comun:link 	{	font-size:9pt;	font-family:"gulim";	color:#ffffff;	font-weight: bold;	text-decoration:none;}
A.comun:visited	{ font-size:9pt; 	font-family:"gulim";	color:#ffffff;		font-weight: bold; text-decoration:none; 	}
A.comun:active  	{ font-size:9pt; 	font-family:"gulim";	color:#ffffff;	font-weight: bold; text-decoration:none; 	}
A.comun:hover	{	font-size:9pt;	font-family:"gulim";	color:#ffcb2c;	font-weight: bold;	text-decoration:none;}

.f_step {
	font-size: 9pt;
	font-weight: bold;
	font-family: "gulim";
	color:#ffffff;
}

.board_title {
	font-size: 12pt;
	font-weight: bold;
	font-family: "gulim";
	color:#3a5870;
}

.comun_board_title {
	font-size: 12pt;
	font-weight: bold;
	font-family: "gulim";
	color:#5e5e5e;
}

.big_title {
	font-size: 11pt;
	font-weight: bold;
	font-family: "dotum";
	color:#000000;
}

.cal {
	font-size: 9pt;
	font-weight: bold;
	font-family: "dotum";
	color:#ffffff;
}
</style>
<script type="text/javascript">
	function calcHeight(){
		var the_height = document.getElementById('contentFrame').contentWindow.document.body.scrollHeight;
		document.getElementById('contentFrame').height = the_height + 60;
	}
</script>
<c:choose>
<c:when test="${preview == 'true'}">
<script type="text/javascript">
<!--
	function fn_egov_goCmmntyHome() {
	}

	function fn_egov_loadMngrMenu(url) {
	}

	function fn_egov_loadBdList(bbsId, bbsAttrbCode, bbsTyCode) {
	}

	function fn_egov_registUser(clbId, cmmntyId) {
	}

	function fn_egov_deleteUser(clbId, cmmntyId) {
	}
//-->
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
<!--
	function fn_egov_goCmmntyHome() {
		var url = "<c:url value='/cop/cus/ClubMainContents.do'/>";
		url += "?clbId=" + document.frm.clbId.value;
		document.getElementById("contentFrame").src = url;
	}

	function fn_egov_loadMngrMenu(url) {
		url = url+"?trgetType=CLUB&trgetId="+document.frm.clbId.value;
		document.getElementById("contentFrame").src = url;
	}

	function fn_egov_loadBdList(bbsId, bbsAttrbCode, bbsTyCode) {
		var url;
		if(bbsTyCode == 'BBST04'){
			url = "<c:url value='/cop/bbs/selectGuestList.do' />?bbsId="+bbsId+"&bbsAttrbCode="+bbsAttrbCode;
		}else if(bbsTyCode == 'BBST02'){ // 익명게시판의 경우 (2011.9.7 수정분)
			url = "<c:url value='/cop/bbs/anonymous/selectBoardList.do' />?bbsId="+bbsId+"&bbsAttrbCode="+bbsAttrbCode;
		}else{
			url = "<c:url value='/cop/bbs/selectBoardList.do' />?bbsId="+bbsId+"&bbsAttrbCode="+bbsAttrbCode;
		}
		document.getElementById("contentFrame").src = url;
	}

	function fn_egov_registUser(clbId, cmmntyId) {
		window.open("<c:url value='/cop/clb/insertClubUserBySelf.do' />?clbId="+clbId+"&cmmntyId="+cmmntyId, "userRegist", "width=320px, height=200px;");
	}

	function fn_egov_deleteUser(clbId, cmmntyId) {
		//window.open("<c:url value='/cop/com/deleteClubUserBySelf.do' />?clbId="+clbId+"&cmmntyId="+cmmntyId, "userDelete", "width=320px, height=200px;");
		window.open("<c:url value='/cop/com/selectClubOprtrList.do' />?trgetId="+clbId+"&PopFlag=S", "userDelete", "width=640px, height=400px;");
	}
//-->
</script>
</c:otherwise>
</c:choose>
</head>
<body>

<form action="<c:url value='/cop/cus/ClubMainContents.do' />" name="frm" method="post" >
	<input type="hidden" name="cmmntyId" value="<c:out value='${clubVO.cmmntyId}' />" />
	<input type="hidden" name="clbId" value="<c:out value='${clubVO.clbId}' />" />
	<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
</form>

<table width="960" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="16"><img src="<c:url value='/images/egovframework/com/cop/tpl/gray_white.gif' />" width="16" height="23" alt="spacer" /></td>
        <td height="45"><img src="<c:url value='/images/egovframework/com/cop/tpl/logo_com.gif' />" width="105" height="35" alt="logo" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="16"><img src="<c:url value='/images/egovframework/com/cop/tpl/gray_white.gif' />" width="16" height="23" alt="spacer" /></td>
        <td><table width="917" border="0" cellpadding="0" cellspacing="0" bgcolor="d9dde1">
          <tr>
            <td align="center"><table width="100%" border="0" cellspacing="1" cellpadding="0">
              <tr>
                <td height="74" align="left" background="<c:url value='/images/egovframework/com/cop/tpl/temple_top01.jpg' />" bgcolor="#FFFFFF"><table width="200" border="0" cellspacing="2" cellpadding="3">
                  <tr>
                    <td><span class="board_title"><c:out value='${clubVO.clbNm}' /></span></td>
                  </tr>
                  <tr>
                    <td><span class="right_board_content"><c:out value='${clubVO.clbIntrcn}' /></span></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><img src="<c:url value='/images/egovframework/com/cop/tpl/gray_white.gif' />" width="18" height="23" alt="spacer" /></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="16"><img src="<c:url value='/images/egovframework/com/cop/tpl/gray_white.gif' />" width="16" height="23" alt="spacer" /></td>
        <td align="left"><table width="917" border="0" cellpadding="0" cellspacing="0" background="<c:url value='/images/egovframework/com/cop/tpl/top_menu_bg.gif' />">
          <tr>
            <td width="13"><img src="<c:url value='/images/egovframework/com/cop/tpl/top_menu_left.gif' />" width="13" height="41" alt="menu left" /></td>
            <td align="left"><table border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center" style="padding-right:10px; padding-left:10px;"><a href="#LINK" onclick="javascript:fn_egov_goCmmntyHome();return false;" class="comun">처음으로</a></td>

                <!-- 관리자 메뉴 부분 Start -->
                <c:if test="${clubUser.oprtrAt == 'Y'}">
                <td align="center"><img src="<c:url value='/images/egovframework/com/cop/tpl/top_menu_gap.gif' />" width="8" height="41" alt="menu gap" /></td>
                <td align="center" style="padding-right:10px; padding-left:10px;">
                <a href="javascript:fn_egov_loadMngrMenu('<c:url value="/cop/bbs/selectBdMstrListByTrget.do"/>');" class="comun">게시판관리</a></td>
                <td align="center"><img src="<c:url value='/images/egovframework/com/cop/tpl/top_menu_gap.gif' />" width="8" height="41" alt="menu gap" /></td>
                <td align="center" style="padding-right:10px; padding-left:10px;">
                <a href="javascript:fn_egov_loadMngrMenu('<c:url value="/cop/com/selectClubUserList.do"/>');" class="comun">사용자관리</a></td>
                <td align="center"><img src="<c:url value='/images/egovframework/com/cop/tpl/top_menu_gap.gif' />" width="8" height="41" alt="menu gap" /></td>
                <td align="center" style="padding-right:10px; padding-left:10px;">
                <a href="javascript:fn_egov_loadMngrMenu('<c:url value="/cop/com/selectConfirmRequestByTrget.do"/>');" class="comun">승인관리</a></td>
                <td align="center"><img src="<c:url value='/images/egovframework/com/cop/tpl/top_menu_gap.gif' />" width="8" height="41" alt="menu gap" /></td>
                <td align="center" style="padding-right:10px; padding-left:10px;">
                <a href="javascript:fn_egov_loadMngrMenu('<c:url value="/cop/com/selectCmyBBSUseInfsByTrget.do"/>');" class="comun">게시판 사용정보 관리</a></td>
                </c:if>
                <!-- 관리자 메뉴 부분 End -->
              </tr>
            </table></td>
            <td width="13" align="right"><img src="<c:url value='/images/egovframework/com/cop/tpl/top_menu_right.gif' />" width="13" height="41" alt="menu right" /></td>
            </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><img src="<c:url value='/images/egovframework/com/cop/tpl/gray_white.gif' />" width="16" height="18" alt="spacer" /></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="16"><img src="<c:url value='/images/egovframework/com/cop/tpl/gray_white.gif' />" width="16" height="23" alt="menu gap" /></td>
        <td width="169" valign="top"><table width="169" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="13"><img src="<c:url value='/images/egovframework/com/cop/tpl/left_menu_top.gif' />" width="169" height="13" alt="left menu" /></td>
          </tr>
          <tr>
            <td align="center" background="<c:url value='/images/egovframework/com/cmm/left_menu_bg.gif' />"><table width="145" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="left"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="21"><img src="<c:url value='/images/egovframework/com/cop/tpl/1_step_left.gif' />" width="21" height="23" alt="left menu" /></td>
                    <td align="left" background="<c:url value='/images/egovframework/com/cop/tpl/1_step_bg.gif' />" class="f_step">게시판 목록</td>
                    <td width="6"><img src="<c:url value='/images/egovframework/com/cop/tpl/1_step_right.gif' />" width="6" height="23" alt="left menu" /></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td align="left"><img src="<c:url value='/images/egovframework/com/cop/tpl/gray_white.gif' />" width="18" height="7" alt="spacer" /></td>
              </tr>

			<!-- 게시판 목록 부분 : Start -->
			<c:forEach var="bbs" items="${bbsList}" varStatus="status">
              <tr>
                <td align="left"><table width="100%" border="0" cellspacing="2" cellpadding="0">
                  <tr>
                    <td width="21" height="13" style="padding-left:10px; padding-right:3px;"><img src="<c:url value='/images/egovframework/com/cop/tpl/bull.gif' />" width="21" height="11" alt="bull" /></td>
                    <td><a href="#LINK" onclick="javascript:fn_egov_loadBdList('<c:out value="${bbs.bbsId}"/>','<c:out value="${bbs.bbsAttrbCode}"/>','<c:out value="${bbs.bbsTyCode}"/>');">
						<c:out value="${bbs.bbsNm}" /></a>
					</td>
                  </tr>
                </table></td>
              </tr>
			</c:forEach>
			<!-- 게시판 목록 부분 : End -->

			<!-- 회원관련 부분 : Start -->
			<c:if test="${isAuthenticated=='Y'}">
              <tr>
                <td align="left"><img src="<c:url value='/images/egovframework/com/cop/tpl/gray_white.gif' />" width="18" height="7" alt="spacer" /></td>
              </tr>
              <tr>
                <td align="left"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="21"><img src="<c:url value='/images/egovframework/com/cop/tpl/1_step_left.gif' />" width="21" height="23" alt="left menu" /></td>
                    <td align="left" background="<c:url value='/images/egovframework/com/cop/tpl/1_step_bg.gif' />" class="f_step">
					<c:choose>
						<c:when test="${clubUser.useAt=='Y'}">
							<a href="javascript:fn_egov_deleteUser('<c:out value="${clubVO.clbId}" />','<c:out value='${clubVO.cmmntyId}' />')"><span class="f_step">탈퇴신청</span></a>
						</c:when>
						<c:otherwise>
							<a href="#LINK" onclick="javascript:fn_egov_registUser('<c:out value="${clubVO.clbId}" />','<c:out value='${clubVO.cmmntyId}' />')"><span class="f_step">가입신청</span></a>
						</c:otherwise>
					</c:choose>
                    </td>
                    <td width="6"><img src="<c:url value='/images/egovframework/com/cop/tpl/1_step_right.gif' />" width="6" height="23" alt="left menu" /></td>
                  </tr>
                </table></td>
              </tr>
			</c:if>
			<!-- 회원관련 부분 : End -->

              <tr>
                <td align="left"><img src="<c:url value='/images/egovframework/com/cop/tpl/gray_white.gif' />" width="18" height="7" alt="spacer" /></td>
              </tr>
              <tr>
                <td align="left">&nbsp;</td>
              </tr>
            </table>
              <br /></td>
          </tr>
          <tr>
            <td height="13"><img src="<c:url value='/images/egovframework/com/cop/tpl/left_menu_bottom.gif' />" width="169" height="13" alt="left menu" /></td>
          </tr>
        </table></td>
        <!-- td width="15" valign="top"><img src="<c:url value='/images/egovframework/com/cop/tpl/gray_white.gif' />" width="15" height="23" /></td-->
        <td valign="top">
        <c:choose>
		<c:when test="${preview == 'true'}">
        	<!--  컨텐츠 영역 : Start -->
			<iframe id="contentFrame" title="컨텐츠" src="<c:url value='/cop/cus/previewClubMainContents.do'/>" frameborder="0" width="758" height="480"></iframe>
        	<!--  컨텐츠 영역 : End -->
        </c:when>
        <c:otherwise>
        	<!--  컨텐츠 영역 : Start -->
			<iframe id="contentFrame" title="컨텐츠" src="<c:url value='/cop/cus/ClubMainContents.do'/>?clbId=<c:out value='${clubVO.clbId}' />" frameborder="0" width="758" height="480"></iframe>
        	<!--  컨텐츠 영역 : End -->
        </c:otherwise>
        </c:choose>
          <br />
          <br /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
