<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovGpkiIssu.jsp
  * @Description : 인증서 안내화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.25    박지욱          최초 생성
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.25
  *  @version 1.0
  *  @see
  *
  */
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/com.css' />" type="text/css">
<title>MOPAS GPKI 인증서 안내</title>
<script>
</script>
</head>
<body>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="20">&nbsp;</td>
    </tr>
    <tr>
	  <td align="left" valign="top">

	    <!-- 인증서소개 시작 -->
		<table cellpadding="0" cellspacing="0" border="0" width="572" style="margin:27 0 0 21;">
    	<!--하나씩-->
        <tr>
          <td>
          <img src="<c:url value='/images/egovframework/com/uat/uia/01_t01.gif' />" width="131" height="13"><br>
          <div style="margin-top:15px;" align="justify">“행정전자서명 인증서”라 함은 행정전자서명이 진정한 것임을 확인ㆍ증명할 수 있도록 하기 위하여 행정기관, 보조기관, 보좌기관, 전자문서유통 및 행정정보 공공이용, 공공기반, 은행 또는 사용자에게   발급하는 전자적 정보를 말한다.<br />
            <br />
            전자거래시 인증서를 사용하면 신원확인, 문서의 위·변조, 거래사실의 부인 방지 등의 효과를 얻을 수   있습니다. 인증서에는 인증서 버전, 인증서 일련번호, 인증서의 유효기간, 발급기관명 및 전자서명 알고리즘 정보, 가입자 이름 및 신원확인정보 등이 포함되어 있다.</div>          </td>
        </tr>
        <!--//하나씩-->
        <tr>
          <td height="30"></td>
        </tr>
        <tr>
          <td height="1" bgcolor="#ECECEC"></td>
        </tr>
        <tr>
          <td height="30"></td>
        </tr>
        <!--하나씩-->
        <tr>
          <td>
            <table cellpadding="0" cellspacing="0" border="0" width="572">
              <tr>
                <td>
            <img src="<c:url value='/images/egovframework/com/uat/uia/01_t02.gif' />" width="97" height="13"><br>
            <div style="margin-top:15px;" align="justify">행정전자서명 인증서 발급대상은 다음의 2가지로 분류된다.<br />
              <strong>첫째</strong>는 인증관리체계상 인증업무수행 인증기관, 등록기관, 원격등록기관에 해당하는 행정기관이 대상이며<br />
              <strong>둘째</strong>는 정보화시스템에 적용하기 위한 행정기관,   보조기관, 보좌기관, 공무원 그리고 해당 공무원과 행정기관, 보조기관, 보좌기관에서 관리하는 정보통신 장비가 일반 인증서 발급 대상이다.<br />
              <strong>셋째</strong>는 전자문서 유통 및 행정정보 공동이용 공공기관, 은행법으로 지정된 기관과 사용자가 발급대상이다. </div>               </td>
            </tr>
            </table>          </td>
        </tr>
        <!--//하나씩-->
        <tr>
          <td height="30"></td>
        </tr>
        <tr>
          <td height="1" bgcolor="#ECECEC"></td>
        </tr>
        <tr>
          <td height="30"><a name="wire01" id="wire01"></a></td>
        </tr>
        <!--하나씩-->
        <tr>
          <td>
          <img src="<c:url value='/images/egovframework/com/uat/uia/01_t03.gif' />" width="72" height="13"><br>
            <table width="572" border="0" cellpadding="0" cellspacing="0" style="margin-top:15;">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
				      <td height="10">&nbsp;</td>
				    </tr>
                    <tr>
                    <td width="15" align="left"><img src="<c:url value='/images/egovframework/com/uat/uia/icon01.gif' />" width="9" height="13" alt="개요모양아이콘이미지"/></td>
                    <td><b><font color="#649E0E">인증/등록기관 인증서</font></b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td colspan="5" bgcolor="#DFF0C7" height="1"></td>
                    </tr>
                     <tr>
                    <td bgcolor="#DFF0C7" width="1"></td>
                    <td width="117" align="center" bgcolor="#F3F9EA"><b><font color="#74AA23">최상위 인증기관</font></b></td>
                    <td bgcolor="#DFF0C7" width="1"></td>
                    <td width="452" align="left"><div style="margin:6px;">인증관리센터는 행정전자서명 인증업무 수행 등에 활용하도록 최상위인증기관에 인증서를 발급합니다.</div></td>
                    <td bgcolor="#DFF0C7" width="1"></td>
                    </tr>
                    <tr>
                    <td colspan="5" bgcolor="#DFF0C7" height="1"></td>
                    </tr>
                     <tr>
                    <td bgcolor="#DFF0C7" width="1"></td>
                    <td width="117" align="center" bgcolor="#F3F9EA"><b><font color="#74AA23">인증기관용</font></b></td>
                    <td bgcolor="#DFF0C7" width="1"></td>
                    <td width="452" align="left"><div style="margin:6px;">인증관리센터는 행정안전부 장관이 지정ㆍ고시하는 정부인증기관을 대상으로 인증업무 수행등에 활용하도록 인증서를 발급합니다.</div></td>
                    <td bgcolor="#DFF0C7" width="1"></td>
                    </tr>
                    <tr>
                    <td colspan="5" bgcolor="#DFF0C7" height="1"></td>
                    </tr>
                     <tr>
                    <td bgcolor="#DFF0C7" width="1"></td>
                    <td width="117" align="center" bgcolor="#F3F9EA"><b><font color="#74AA23">등록기관용</font></b></td>
                    <td bgcolor="#DFF0C7" width="1"></td>
                    <td width="452" align="left"><div style="margin:6px;">인증관리센터는 등록기관 등록업무 수행 등에 활용하도록 등록기관 지정 행정기관에 인증서를 발급합니다.</div></td>
                    <td bgcolor="#DFF0C7" width="1"></td>
                    </tr>
                    <tr>
                    <td colspan="5" bgcolor="#DFF0C7" height="1"></td>
                    </tr>
                  </table>                </td>
              </tr>
            </table>          </td>
        </tr>
        <!--//하나씩-->
        <tr>
          <td height="30"></td>
        </tr>
        <!--하나씩-->
        <tr>
          <td>
            <table width="572" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td width="15" align="left"><img src="<c:url value='/images/egovframework/com/uat/uia/icon01.gif' />" width="9" height="13" alt="개요모양아이콘이미지"/></td>
                    <td><b><font color="#649E0E">기관/개인 인증서</font></b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#DFF0C7">
                    <tr>
                    <td align="center" width="100" bgcolor="#F3F9EA" rowspan="3"><b><font color="#74AA23">기관 </font></b></td>
                    <td width="100" height="25" align="center" bgcolor="#FFFFFF"><strong>기관용</strong></td>
                    <td bgcolor="#ffffff"><div style="margin:6px;">인증관리센터는 사무관리규정에 따라 관인을 가질수 있는 행정기관, 보조기관, 보좌기관등의 과단위까지의 1개의 기관용   인증서를 발급합니다.</div> </td>
                    </tr>
                    <tr>
                    <td height="45" align="center" bgcolor="#FFFFFF"><strong>특수목적용</strong></td>
                    <td bgcolor="#ffffff" height="45"><div style="margin:6px;">인증관리센터는 사무관리규정에 따라 행정기관의 업무를 관인과 같이 처리할 수 없도록 규정한   특수관인을 관리하는 경우에 특수목적용 인증서를 발급합니다.</div></td>
                    </tr>
                    <tr>
                    <td align="center" bgcolor="#FFFFFF" height="45"><strong>서버용</strong></td>
                    <td bgcolor="#ffffff"><div style="margin:6px;">인증관리센터는 행정기관에서 관리해야할 책임이 있는 정보통신 장비가 일정 규칙에 의해 정보통신 장비가 지속적으로   행정업무를 처리하고자 하는 경우에 서버 단위로 인증서를 발급합니다.</div> </td>
                    </tr>
                    <tr>
                    <td align="center" bgcolor="#F3F9EA"><b><font color="#74AA23">개인</font></b></td>
                    <td bgcolor="#ffffff" colspan="2" height="45"><div style="margin:6px;">인증관리센터는 행정기관 소속 공무원이 사용자인증 및 전자결재, 보안메일 등의   행정업무 또는 전자상거래 등에서 활용하도록 하기 위해 부처별 개인단위로 인증서를 발급합니다.</div></td>
                    </tr>
                  </table>               </td>
              </tr>
              <tr>
                <td><div style="margin-top:10px;">※ 기타 : 행정업무 처리에서 필요하다고 판단되는 경우 인증협의회 또는 관련 기관과 협의하여 업무에 맞는 인증서를 발급할 수 있습니다.</div> </td>
              </tr>
            </table>          </td>
        </tr>
        <!--//하나씩-->
        <tr>
          <td height="30"></td>
        </tr>
        <tr>
          <td height="1" bgcolor="#ECECEC"></td>
        </tr>
        <tr>
          <td height="30"></td>
        </tr>
        <!--하나씩-->
        <tr>
          <td>
            <table width="572" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="<c:url value='/images/egovframework/com/uat/uia/01_t04.gif' />" width="111" height="13"><br>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:15px;">
                    <tr>
                    <td width="15" align="left"><img src="<c:url value='/images/egovframework/com/uat/uia/icon01.gif' />" width="9" height="13" alt="개요모양아이콘이미지"/></td>
                    <td><b><font color="#649E0E">인증/등록기관 </font></b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#DFF0C7">
                    <tr bgcolor="#e8f9f4">
                    <td align="center" bgcolor="#F3F9EA" height="30"><b><font color="#74AA23">구분</font></b></td>
                    <td align="center" bgcolor="#F3F9EA"><b><font color="#74AA23">ou명</font></b></td>
                    <td align="center" bgcolor="#F3F9EA"><b><font color="#74AA23">cn명</font></b></td>
                    <td align="center" bgcolor="#F3F9EA"><b><font color="#74AA23">DN명(예)</font></b></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                    <td width="100" height="25"><div style="margin:6px;">최상위 인증기관</div></td>
                    <td width="100"><div style="margin:6px;">ou=GPKI</div></td>
                    <td><div style="margin:6px;">cn=Root   CA</div></td>
                    <td><div style="margin:6px;">cn=Root   CA, ou=GPKI, o=Government of Korea,c=KR</div></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                    <td><div style="margin:6px;">인증기관</div></td>
                    <td><div style="margin:6px;">ou=GPKI</div></td>
                    <td><div style="margin:6px;">cn=CA   + 기관코드(7) + 일련번호(2)</div></td>
                    <td><div style="margin:6px;">cn=CA131000001,   ou=GPKI, o=Government of Korea,c=KR</div></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                    <td><div style="margin:6px;">등록기관</div></td>
                    <td><div style="margin:6px;">cn=해당인증기관,<br />
                      ou=GPKI<br /></div></td>
                    <td><div style="margin:6px;">cn=RA   + 기관코드(7) + 일련번호(2)</div></td>
                    <td><div style="margin:6px;">cn=RA131000001,cn=CA131000001,   ou=GPKI, o=Government of Korea,c=KR</div></td>
                    </tr>
                    </table>               </td>
              </tr>
            </table>          </td>
        </tr>
        <!--//하나씩-->
        <tr>
          <td height="30"></td>
        </tr>
        <!--하나씩-->
        <tr>
          <td>
            <table width="572" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td width="15" align="left"><img src="<c:url value='/images/egovframework/com/uat/uia/icon01.gif' />" width="9" height="13" alt="개요모양아이콘이미지"/></td>
                    <td><b><font color="#649E0E">기관/개인 </font></b></td>
                    </tr>
                  </table>                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#DFF0C7">
                    <tr bgColor="#F3F9EA">
                    <td align="center" bgColor="#F3F9EA" colSpan="2" height="30"><b><font color="#74AA23">구분</font></b></td>
                    <td align="center" bgcolor="#F3F9EA"><b><font color="#74AA23">ou명</font></b></td>
                    <td align="center" bgcolor="#F3F9EA"><b><font color="#74AA23">cn명</font></b></td>
                    <td align="center" bgcolor="#F3F9EA">
                      <table cellSpacing="0" cellPadding="0" border="0">
                        <tr>
                          <td><b><font color="#74AA23">DN명</font></b></td>
                        </tr>
                      </table>
                      </td>
                    </tr>
                    <tr bgColor="#ffffff">
                    <td width="50" rowSpan="2" align="center" bgcolor="#ffffff">기관 </td>
                    <td width="80" height="25" align="center" bgcolor="#ffffff">기관용</td>
                    <td width="100"><div style="margin:6px;">ou=최하위기관명, ou=상위기관명, ou=최상위기관명</div></td>
                    <td align="middle"><div style="margin:6px;">-</div></td>
                    <td><div style="margin:6px;">ou=보안관리팀,   ou=전자정부본부, ou=행정안전부, o=Government of Korea, c=KR</div></td>
                    </tr>
                    <tr bgColor="#ffffff">
                    <td align="center" bgcolor="#ffffff">서버용</td>
                    <td><div style="margin:6px;">ou=Group   of Server</div></td>
                    <td><div style="margin:6px;">cn=SVR   + 기관코드(7) + 일련번호(3)</div></td>
                    <td><div style="margin:6px;">cn=SVR131000001,   ou=Group of Server, o=Government of Korea, c=KR</div></td>
                    </tr>
                    <tr bgColor="#ffffff">
                    <td align="center" bgcolor="#ffffff">개인 </td>
                    <td align="center" bgcolor="#ffffff">&nbsp;</td>
                    <td><div style="margin:6px;">ou=people,   ou=최상위기관명</div></td>
                    <td><div style="margin:6px;">cn=기관구분자(3)   + 이름 + 일련번호(3)<BR>
                      *일련번호:동명이인 </div></td>
                    <td><div style="margin:6px;">cn=001홍길동001,   ou=people, ou=행정안전부, o=Government of Korea, c=KR</div></td>
                    </tr>
                  </table>               </td>
             </tr>
            </table>          </td>
        </tr>
        <!--//하나씩-->
      </table>
      <!-- 인증서소개 끝 -->

	  </td>
    </tr>
  </table>
</body>
</html>

