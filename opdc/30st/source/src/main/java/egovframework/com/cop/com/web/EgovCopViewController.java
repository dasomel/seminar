package egovframework.com.cop.com.web;

import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 협업 비로그인 유저용 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.4.10  이삼섭          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovCopViewController {
	
	 
	 

    //@Resource(name = "EgovCommunityManageService")
    //private EgovCommunityManageService cmmntyService;

    //Logger log = Logger.getLogger(this.getClass());

    /**
     * 커뮤니티 홈으로 이동한다.
     * 
     * @param cmmntyVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
/*    @RequestMapping("/cop/cus/CmmntyViewPage.do")
    public String selectCmmntyViewPage(@ModelAttribute("searchVO") CommunityVO cmmntyVO, ModelMap model) throws Exception {

	@SuppressWarnings("unused")
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	@SuppressWarnings("unused")
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	
	 * List<CommunityVO> _result = cmmntyService.selectAllCmmnty(cmmntyVO);
	 * model.addAttribute("resultList", _result);
	 
	return "egovframework/com/cop/com/EgovCmmntynClubView";
    }*/

    /**
     * 팝업 페이지를 호출한다.
     * 
     * @param userVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/com/openPopup.do")
    public String openPopupWindow(Map<String, Object> commandMap, ModelMap model) throws Exception {

	String requestUrl = (String)commandMap.get("requestUrl");
	String trgetId = (String)commandMap.get("trgetId");
	String width = (String)commandMap.get("width");
	String height = (String)commandMap.get("height");
	String typeFlag = (String)commandMap.get("typeFlag");

	//log.debug(this.getClass().getName()+">>>>requestUrl  Before "+requestUrl);
	//log.debug(this.getClass().getName()+">>>>trgetId  Before "+trgetId);
	//log.debug(this.getClass().getName()+">>>>typeFlag  Before "+typeFlag);

	if (trgetId != null && trgetId != "") {
	    if (typeFlag != null && typeFlag != "") {
		model.addAttribute("requestUrl", requestUrl + "?trgetId=" + trgetId + "&PopFlag=Y&typeFlag=" + typeFlag);
	    } else {
		model.addAttribute("requestUrl", requestUrl + "?trgetId=" + trgetId + "&PopFlag=Y");
	    }
	} else {
	    if (typeFlag != null && typeFlag != "") {
		model.addAttribute("requestUrl", requestUrl + "?PopFlag=Y&typeFlag=" + typeFlag);
	    } else {
		model.addAttribute("requestUrl", requestUrl + "?PopFlag=Y");
	    }

	}

	model.addAttribute("width", width);
	model.addAttribute("height", height);
	
	return "egovframework/com/cop/com/EgovModalPopupFrame";
    }
}
