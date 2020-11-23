package egovframework.com.cop.bbs.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.EgovBBSLoneMasterService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 게시판 속성관리를 위한 컨트롤러 클래스
 * @author 공통컴포넌트개발팀 한성곤
 * @since 2009.08.25
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2009.08.25  한성곤          최초 생성
 *   2011.8.26	정진오			IncludedInfo annotation 추가
 *   2011.9.7	정진오			익명 게시판의 경우 provdUrl이 관련된 사항으로 표출되도록 수정
 *
 * </pre>
 */

@Controller
public class EgovBBSLoneMasterController {




    @Resource(name = "EgovBBSLoneMasterService")
    private EgovBBSLoneMasterService bbsLoneService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Autowired
    private DefaultBeanValidator beanValidator;

    //protected Logger log = Logger.getLogger(this.getClass());

    /**
     * 신규 게시판 마스터 등록을 위한 등록페이지로 이동한다.
     *
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/cop/bbs/addBoardMaster.do")
    public String addBoardMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
	BoardMaster boardMaster = new BoardMaster();

	ComDefaultCodeVO vo = new ComDefaultCodeVO();

	vo.setCodeId("COM004");

	List codeResult = cmmUseService.selectCmmCodeDetail(vo);

	model.addAttribute("typeList", codeResult);

	vo.setCodeId("COM009");

	codeResult = cmmUseService.selectCmmCodeDetail(vo);

	model.addAttribute("attrbList", codeResult);
	model.addAttribute("boardMaster", boardMaster);


	return "egovframework/com/cop/bbs/EgovBBSLoneMstrRegist";
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
    @RequestMapping("/cop/bbs/insertBoardMaster.do")
    public String insertBoardMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
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

	    return "egovframework/com/cop/bbs/EgovBBSLoneMstrRegist";
	}

	if (isAuthenticated) {
	    boardMaster.setFrstRegisterId(user.getUniqId());
	    boardMaster.setUseAt("Y");
	    boardMaster.setTrgetId("SYSTEMDEFAULT_REGIST");

	    bbsLoneService.insertMaster(boardMaster);
	}

	return "forward:/cop/bbs/selectBoardMasterList.do";
    }

    /**
     * 게시판 마스터 목록을 조회한다.
     *
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
//    @IncludedInfo(name="게시판관리", order = 170 ,gid = 40)
    @RequestMapping("/cop/bbs/selectBoardMasterList.do")
    public String selectBoardMasterList(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
	boardMasterVO.setPageUnit(propertyService.getInt("pageUnit"));
	boardMasterVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();

	paginationInfo.setCurrentPageNo(boardMasterVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(boardMasterVO.getPageUnit());
	paginationInfo.setPageSize(boardMasterVO.getPageSize());

	boardMasterVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	boardMasterVO.setLastIndex(paginationInfo.getLastRecordIndex());
	boardMasterVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsLoneService.selectMasterList(boardMasterVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));

	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("paginationInfo", paginationInfo);

	return "egovframework/com/cop/bbs/EgovBBSLoneMstrList";
    }

    /**
     * 게시판 마스터 상세내용을 조회한다.
     *
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/selectBoardMaster.do")
    public String selectBoardMaster(@ModelAttribute("searchVO") BoardMasterVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {
	BoardMasterVO vo = bbsLoneService.selectMaster(searchVO);

	/*2011.9.7 수정부분 시작*/
	String provideUrl;
	if (vo.getBbsTyCode().equals("BBST02")){ // 익명게시판인 경우
		provideUrl = "/cop/bbs/anonymous/selectBoardList.do?bbsId=" + vo.getBbsId();
	}
	else {
	    provideUrl = "/cop/bbs/selectBoardList.do?bbsId=" + vo.getBbsId();
	}
	/*2011.9.7 수정부분 종료*/

	model.addAttribute("result", vo);

	model.addAttribute("provdUrl", provideUrl);

	return "egovframework/com/cop/bbs/EgovBBSLoneMstrUpdt";
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
    @RequestMapping("/cop/bbs/updateBoardMaster.do")
    public String updateBoardMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
	    BindingResult bindingResult, ModelMap model) throws Exception {

	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	beanValidator.validate(boardMaster, bindingResult);
	if (bindingResult.hasErrors()) {
	    BoardMasterVO vo = bbsLoneService.selectMaster(boardMasterVO);

	    model.addAttribute("result", vo);

	    return "egovframework/com/cop/bbs/EgovBBSLoneMstrUpdt";
	}

	if (isAuthenticated) {
	    boardMaster.setLastUpdusrId(user.getUniqId());
	    bbsLoneService.updateMaster(boardMaster);
	}

	return "forward:/cop/bbs/selectBoardMasterList.do";
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
    @RequestMapping("/cop/bbs/deleteBoardMaster.do")
    public String deleteBoardMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
	    SessionStatus status) throws Exception {

	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	if (isAuthenticated) {
	    boardMaster.setLastUpdusrId(user.getUniqId());
	    bbsLoneService.deleteMaster(boardMaster);
	}
	// status.setComplete();
	return "forward:/cop/bbs/selectBoardMasterList.do";
    }
}
