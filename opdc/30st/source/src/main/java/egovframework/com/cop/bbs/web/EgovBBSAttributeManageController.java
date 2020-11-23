package egovframework.com.cop.bbs.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovComponentChecker;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 게시판 속성관리를 위한 컨트롤러  클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2009.3.12  이삼섭          최초 생성
 *   2009.06.26	한성곤		    2단계 기능 추가 (댓글관리, 만족도조사)
 *	 2011.07.21 안민정          커뮤니티 관련 메소드 분리 (->EgovBBSAttributeManageController)
 *	 2011.8.26	정진오			IncludedInfo annotation 추가
 *   2011.09.15 서준식           2단계 기능 추가 (댓글관리, 만족도조사) 적용방법 변경
 * </pre>
 */

@Controller
public class EgovBBSAttributeManageController {
	
	 
	 

    @Resource(name = "EgovBBSAttributeManageService")
    private EgovBBSAttributeManageService bbsAttrbService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    


    @Autowired
    private DefaultBeanValidator beanValidator;

    //Logger log = Logger.getLogger(this.getClass());
    
    /**
     * 신규 게시판 마스터 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/cop/bbs/addBBSMaster.do")
    public String addBBSMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
	BoardMaster boardMaster = new BoardMaster();

	ComDefaultCodeVO vo = new ComDefaultCodeVO();
	
	vo.setCodeId("COM004");
	
	List codeResult = cmmUseService.selectCmmCodeDetail(vo);
	
	model.addAttribute("typeList", codeResult);

	vo.setCodeId("COM009");
	
	codeResult = cmmUseService.selectCmmCodeDetail(vo);
	
	model.addAttribute("attrbList", codeResult);
	model.addAttribute("boardMaster", boardMaster);

	//---------------------------------
	// 2009.06.26 : 2단계 기능 추가
	//---------------------------------
	//String flag = EgovProperties.getProperty("Globals.addedOptions");
	//if (flag != null && flag.trim().equalsIgnoreCase("true")) {
	//    model.addAttribute("addedOptions", "true");
	//}
	////-------------------------------
	
	
	//---------------------------------
	// 2011.09.15 : 2단계 기능 추가 반영 방법 변경
	//---------------------------------

	
	if(EgovComponentChecker.hasComponent("EgovBBSCommentService")){
		model.addAttribute("useComment", "true");
	}
	if(EgovComponentChecker.hasComponent("EgovBBSSatisfactionService")){
		model.addAttribute("useSatisfaction", "true");
	}
	
	////-------------------------------

	return "egovframework/com/cop/bbs/EgovBoardMstrRegist";
    }

    /**
     * 신규 게시판 마스터 정보를 등록한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param status
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/cop/bbs/insertBBSMasterInf.do")
    public String insertBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
	    BindingResult bindingResult, SessionStatus status, ModelMap model) throws Exception {
	
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	beanValidator.validate(boardMaster, bindingResult);
	if (bindingResult.hasErrors()) {

	    ComDefaultCodeVO vo = new ComDefaultCodeVO();
	    
	    vo.setCodeId("COM004");
	    
	    List codeResult = cmmUseService.selectCmmCodeDetail(vo);
	    
	    model.addAttribute("typeList", codeResult);

	    vo.setCodeId("COM009");
	   
	    codeResult = cmmUseService.selectCmmCodeDetail(vo);
	    
	    model.addAttribute("attrbList", codeResult);

	    return "egovframework/com/cop/bbs/EgovBoardMstrRegist";
	}
	
	if (isAuthenticated) {
	    boardMaster.setFrstRegisterId(user.getUniqId());
	    boardMaster.setUseAt("Y");
	    boardMaster.setTrgetId("SYSTEMDEFAULT_REGIST");

	    bbsAttrbService.insertBBSMastetInf(boardMaster);
	}

	return "forward:/cop/bbs/SelectBBSMasterInfs.do";
    }

    /**
     * 게시판 마스터 목록을 조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @IncludedInfo(name="게시판속성관리",order = 180 ,gid = 40)
    @RequestMapping("/cop/bbs/SelectBBSMasterInfs.do")
    public String selectBBSMasterInfs(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
	boardMasterVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardMasterVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardMasterVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardMasterVO.getPageUnit());
	paginationInfo.setPageSize(boardMasterVO.getPageSize());

	boardMasterVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardMasterVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardMasterVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsAttrbService.selectBBSMasterInfs(boardMasterVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));	
	model.addAttribute("paginationInfo", paginationInfo);

	return "egovframework/com/cop/bbs/EgovBoardMstrList";
    }

    /**
     * 게시판 마스터 상세내용을 조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/SelectBBSMasterInf.do")
    public String selectBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO searchVO, ModelMap model) throws Exception {
	BoardMasterVO vo = bbsAttrbService.selectBBSMasterInf(searchVO);

	model.addAttribute("result", vo);
	
	//---------------------------------
	// 2009.06.26 : 2단계 기능 추가
	//---------------------------------
	//String flag = EgovProperties.getProperty("Globals.addedOptions");
	//if (flag != null && flag.trim().equalsIgnoreCase("true")) {
	//    model.addAttribute("addedOptions", "true");
	//}
	////-------------------------------
	
	//---------------------------------
	// 2011.09.15 : 2단계 기능 추가 반영 방법 변경
	//---------------------------------
	
	if(EgovComponentChecker.hasComponent("EgovBBSCommentService")){
		model.addAttribute("useComment", "true");
	}
	if(EgovComponentChecker.hasComponent("EgovBBSSatisfactionService")){
		model.addAttribute("useSatisfaction", "true");
	}
	
	////-------------------------------
	
	
	return "egovframework/com/cop/bbs/EgovBoardMstrUpdt";
    }

    /**
     * 게시판 마스터 정보를 수정한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/UpdateBBSMasterInf.do")
    public String updateBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
	    BindingResult bindingResult, ModelMap model) throws Exception {

	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	beanValidator.validate(boardMaster, bindingResult);
	if (bindingResult.hasErrors()) {
	    BoardMasterVO vo = bbsAttrbService.selectBBSMasterInf(boardMasterVO);

	    model.addAttribute("result", vo);
	    
	    return "egovframework/com/cop/bbs/EgovBoardMstrUpdt";
	}

	if (isAuthenticated) {
	    boardMaster.setLastUpdusrId(user.getUniqId());
	    bbsAttrbService.updateBBSMasterInf(boardMaster);
	}

	return "forward:/cop/bbs/SelectBBSMasterInfs.do";
    }

    /**
     * 게시판 마스터 정보를 삭제한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param status
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/DeleteBBSMasterInf.do")
    public String deleteBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
	    SessionStatus status) throws Exception {

	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	if (isAuthenticated) {
	    boardMaster.setLastUpdusrId(user.getUniqId());
	    bbsAttrbService.deleteBBSMasterInf(boardMaster);
	}
	// status.setComplete();
	return "forward:/cop/bbs/SelectBBSMasterInfs.do";
    }

    /**
     * 게시판 마스터 선택 팝업을 위한 목록을 조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/SelectBBSMasterInfsPop.do")
    public String selectBBSMasterInfsPop(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
	boardMasterVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardMasterVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	
	paginationInfo.setCurrentPageNo(boardMasterVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardMasterVO.getPageUnit());
	paginationInfo.setPageSize(boardMasterVO.getPageSize());

	boardMasterVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardMasterVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardMasterVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	boardMasterVO.setUseAt("Y");
	
	Map<String, Object> map = bbsAttrbService.selectNotUsedBdMstrList(boardMasterVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));	
	model.addAttribute("paginationInfo", paginationInfo);

	return "egovframework/com/cop/bbs/EgovBoardMstrListPop";
    }
}
