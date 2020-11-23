<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovIdPasswordSearch.jsp
  * @Description : 아이디/비밀번호 찾기 화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.09    박지욱          최초 생성
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.09
  *  @version 1.0
  *  @see
  *
  */
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/com.css' />" type="text/css">
<title>MOPAS 아이디/비밀번호 찾기</title>
<script>

function fnCheckUsrId(userSe) {
	// 일반회원
	if (userSe == "GNR") {
		document.idForm.rdoSlctUsr[0].checked = true;
		document.idForm.rdoSlctUsr[1].checked = false;
		document.idForm.rdoSlctUsr[2].checked = false;
		document.idForm.userSe.value = "GNR";
	// 기업회원
	} else if (userSe == "ENT") {
		document.idForm.rdoSlctUsr[0].checked = false;
		document.idForm.rdoSlctUsr[1].checked = true;
		document.idForm.rdoSlctUsr[2].checked = false;
		document.idForm.userSe.value = "ENT";
	// 업무사용자
	} else if (userSe == "USR") {
		document.idForm.rdoSlctUsr[0].checked = false;
		document.idForm.rdoSlctUsr[1].checked = false;
		document.idForm.rdoSlctUsr[2].checked = true;
		document.idForm.userSe.value = "USR";
	}
}

function fnCheckUsrPassword(userSe) {
	// 일반회원
	if (userSe == "GNR") {
		document.passwordForm.rdoSlctUsr[0].checked = true;
		document.passwordForm.rdoSlctUsr[1].checked = false;
		document.passwordForm.rdoSlctUsr[2].checked = false;
		document.passwordForm.userSe.value = "GNR";
	// 기업회원
	} else if (userSe == "ENT") {
		document.passwordForm.rdoSlctUsr[0].checked = false;
		document.passwordForm.rdoSlctUsr[1].checked = true;
		document.passwordForm.rdoSlctUsr[2].checked = false;
		document.passwordForm.userSe.value = "ENT";
	// 업무사용자
	} else if (userSe == "USR") {
		document.passwordForm.rdoSlctUsr[0].checked = false;
		document.passwordForm.rdoSlctUsr[1].checked = false;
		document.passwordForm.rdoSlctUsr[2].checked = true;
		document.passwordForm.userSe.value = "USR";
	}
}

function fnSearchId() {
	if (document.idForm.name.value =="") {
		alert("이름을 입력하세요");
	} else if (document.idForm.email.value =="") {
		alert("가입시 이메일주소를 입력하세요");
	} else {
		//window.open("<c:url value='/cmm/uat/uia/searchId.do' />?id=");
		document.idForm.target = "_blank";
		document.idForm.submit();
	}
}

function fnSearchPassword() {
	if (document.passwordForm.id.value =="") {
		alert("아이디를 입력하세요");
	} else if (document.passwordForm.name.value =="") {
		alert("이름을 입력하세요");
	} else if (document.passwordForm.email.value =="") {
		alert("가입시 이메일주소를 입력하세요");
	} else if (document.passwordForm.passwordHint.value =="") {
		alert("비밀번호 힌트를 선택하세요");
	} else if (document.passwordForm.passwordCnsr.value =="") {
		alert("비밀번호 정답을 입력하세요");
	} else {
		document.passwordForm.target = "_blank";
		document.passwordForm.submit();
	}
}

</script>
</head>
<body>
  <table width="700" border="1">
    <tr>
      <td width="350" height="250">

	      <!--아이디찾기 테이블 시작-->
	      <form name="idForm" action ="<c:url value='/uat/uia/searchId.do'/>" method="post">
			<table width="303" border="0" cellspacing="8" cellpadding="0">
		      <tr>
				<td width="40%"class="title_left"><img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle" alt="제목아이콘이미지">&nbsp;아이디 찾기</td>
		      </tr>
		      <tr>
				<td width="303" height="210" valign="top">
					<table width="303" border="0" align="center" cellpadding="0" cellspacing="0">
					  <tr>
					    <td height="5">&nbsp;</td>
					  </tr>
					  <tr>
					    <td>
					    	<table border="0" cellpadding="0" cellspacing="0" style="width:250px;margin-left:20px;">
				              <tr>
				                <td class="title" nowrap><input name="rdoSlctUsr" type=radio value=radio checked onClick="fnCheckUsrId('GNR');" tabindex="1">일반</td>
				                <td class="title" nowrap><input name="rdoSlctUsr" type=radio value=radio unchecked onClick="fnCheckUsrId('ENT');" tabindex="2">기업</td>
				                <td class="title" nowrap><input name="rdoSlctUsr" type=radio value=radio unchecked onClick="fnCheckUsrId('USR');" tabindex="3">업무</td>
				              </tr>
				              <tr>
							    <td height="1">&nbsp;</td>
							  </tr>
				            </table>
						    <table border="0" cellpadding="0" cellspacing="0" style="width:250px;margin-left:20px;">
						      <tr>
								<td>
									<table width="142" border="0" cellpadding="0" cellspacing="0">
									  <tr>
									    <td class="required_text" nowrap>이름&nbsp;&nbsp;</td>
									    <td><input type="text" name="name" style="height: 16px; width: 150px; border: 1px solid #CCCCCC; margin: 0px; padding: 0px;" tabindex="4" maxlength="20" title="이름입력"/></td>
									    <td/>
									  </tr>
									  <tr>
									    <td class="required_text" nowrap>이메일&nbsp;&nbsp;</td>
									    <td><input type="text" name="email" style="height: 16px; width: 150px; border: 1px solid #CCCCCC; margin: 0px; padding: 0px; ime-mode: disabled;" maxlength="30" tabindex="5" title="이메일입력"/></td>
									    <td/>
									  </tr>
									</table>
								</td>
					  		  </tr>
					  		  <tr>
					  		  	<td height="30">&nbsp;</td>
					  		  </tr>
					  		  <tr>
							    <td>
									<table border="0" cellspacing="0" cellpadding="0">
									  <tr>
									    <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" width="8" height="20" alt="버튼이미지"></td>
										<td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif' />" class="text_left" nowrap><center><a href="javascript:fnSearchId();">아이디찾기</a></center></td>
										<td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif' />" width="8" height="20" alt="버튼이미지"></td>
									  </tr>
									</table>
								</td>
							  </tr>
							</table>
			    		</td>
			  		  </tr>
			  		  <tr>
					    <td height="2">&nbsp;</td>
					  </tr>
					</table>
				</td>
		      </tr>
		    </table>
		    <input name="userSe" type="hidden" value="GNR">
	    </form>
	    <!--아이디찾기 테이블 끝-->
      </td>
      <td width="350" height="250">
      	<!--비밀번호찾기 테이블 시작-->
	    <form name="passwordForm" action ="<c:url value='/uat/uia/searchPassword.do'/>" method="post">
			<table width="303" border="0" cellspacing="8" cellpadding="0">
		      <tr>
				<td width="40%"class="title_left"><img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle" alt="제목아이콘이미지">&nbsp;비밀번호 찾기</td>
		      </tr>
		      <tr>
				<td width="303" height="210" valign="top">
					<table width="303" border="0" align="center" cellpadding="0" cellspacing="0">
					  <tr>
					    <td height="5">&nbsp;</td>
					  </tr>
					  <tr>
					    <td>
					    	<table border="0" cellpadding="0" cellspacing="0" style="width:250px;margin-left:20px;">
				              <tr>
				                <td class="title" nowrap><input name="rdoSlctUsr" type=radio value=radio checked onClick="fnCheckUsrPassword('GNR');" tabindex="6">일반</td>
				                <td class="title" nowrap><input name="rdoSlctUsr" type=radio value=radio unchecked onClick="fnCheckUsrPassword('ENT');" tabindex="7">기업</td>
				                <td class="title" nowrap><input name="rdoSlctUsr" type=radio value=radio unchecked onClick="fnCheckUsrPassword('USR');" tabindex="8">업무</td>
				              </tr>
				              <tr>
							    <td height="1">&nbsp;</td>
							  </tr>
				            </table>
						    <table border="0" cellpadding="0" cellspacing="0" style="width:250px;margin-left:20px;">
						      <tr>
								<td>
									<table width="142" border="0" cellpadding="0" cellspacing="0">
									  <tr>
									    <td class="required_text" nowrap>아이디&nbsp;&nbsp;</td>
									    <td><input type="text" name="id" style="height: 16px; width: 150px; border: 1px solid #CCCCCC; margin: 0px; padding: 0px; ime-mode: disabled;" tabindex="9" maxlength="15" title="아이디입력"/></td>
									    <td/>
									  </tr>
									  <tr>
									    <td class="required_text" nowrap>이름&nbsp;&nbsp;</td>
									    <td><input type="text" name="name" style="height: 16px; width: 150px; border: 1px solid #CCCCCC; margin: 0px; padding: 0px;" tabindex="10" maxlength="20" title="이름입력"/></td>
									    <td/>
									  </tr>
									  <tr>
									    <td class="required_text" nowrap>이메일&nbsp;&nbsp;</td>
									    <td><input type="text" name="email" style="height: 16px; width: 150px; border: 1px solid #CCCCCC; margin: 0px; padding: 0px; ime-mode: disabled;" maxlength="30" tabindex="11" title="이메일입력"/></td>
									    <td/>
									  </tr>
									  <tr>
									    <td class="required_text" nowrap>비밀번호 힌트&nbsp;&nbsp;</td>
									    <td>
									      <select name="passwordHint" style="height: 16px; width: 150px; border: 1px solid #CCCCCC; margin: 0px; padding: 0px;" class="select" tabindex="12" title="비밀번호힌트선택">
										    <option selected value=''>--선택하세요--</option>
										    <c:forEach var="result" items="${pwhtCdList}" varStatus="status">
											<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
											</c:forEach>
										  </select>
									    <td/>
									  </tr>
									  <tr>
									    <td class="required_text" nowrap>비밀번호 정답&nbsp;&nbsp;</td>
									    <td><input type="text" name="passwordCnsr" style="height: 16px; width: 150px; border: 1px solid #CCCCCC; margin: 0px; padding: 0px;" maxlength="50" tabindex="13" title="비밀번호정답입력"/></td>
									    <td/>
									  </tr>
									</table>
								</td>
					  		  </tr>
					  		  <tr>
					  		  	<td height="30">&nbsp;</td>
					  		  </tr>
					  		  <tr>
							    <td>
									<table border="0" cellspacing="0" cellpadding="0">
									  <tr>
									    <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif' />" width="8" height="20" alt="버튼이미지"></td>
										<td background="<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif' />" class="text_left" nowrap><center><a href="javascript:fnSearchPassword();">비밀번호찾기</a></center></td>
										<td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif' />" width="8" height="20" alt="버튼이미지"></td>
									  </tr>
									</table>
								</td>
							  </tr>
							</table>
			    		</td>
			  		  </tr>
			  		  <tr>
					    <td height="2">&nbsp;</td>
					  </tr>
					</table>
				</td>
		      </tr>
		    </table>
		    <input name="userSe" type="hidden" value="GNR">
	    </form>
	    <!--비밀번호찾기 테이블 끝-->
      </td>
    </tr>
  </table>
</body>
</html>

