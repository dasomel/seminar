package egovframework.com.cop.scp.web;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.cop.bbs.service.EgovBBSScrapService;
import egovframework.com.cop.bbs.service.Scrap;
import egovframework.com.cop.bbs.service.ScrapVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 스크랩관리 서비스 컨트롤러 클래스
 * @author 공통컴포넌트개발팀 한성곤
 * @since 2009.07.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.07.10  한성곤          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Controller
public class EgovBBSScrapController {





    @Resource(name="EgovBBSScrapService")
    protected EgovBBSScrapService bbsScrapService;

    @Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;

    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Autowired
    private DefaultBeanValidator beanValidator;

    //Logger log = Logger.getLogger(this.getClass());

    /**
     * 스크랩관리 목록 조회를 제공한다.
     *
     * @param scrapVO
     * @param model
     * @return
     * @throws Exception
     */
    @IncludedInfo(name="스크랩 목록", order = 250 ,gid = 40)
    @RequestMapping("/cop/scp/selectScrapList.do")
    public String selectScrapList(@ModelAttribute("searchVO") ScrapVO scrapVO, ModelMap model) throws Exception {
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	scrapVO.setUniqId(user.getUniqId());

	scrapVO.setPageUnit(propertyService.getInt("pageUnit"));
	scrapVO.setPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	paginationInfo.setCurrentPageNo(scrapVO.getPageIndex());
	paginationInfo.setRecordCountPerPage(scrapVO.getPageUnit());
	paginationInfo.setPageSize(scrapVO.getPageSize());

	scrapVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	scrapVO.setLastIndex(paginationInfo.getLastRecordIndex());
	scrapVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsScrapService.selectScrapList(scrapVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));

	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("paginationInfo", paginationInfo);

	return "egovframework/com/cop/scp/EgovScrapList";
    }

    /**
     * 스크랩에 대한 상세정보를 조회한다.
     *
     * @param scrapVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/scp/selectScrap.do")
    public String selectScrap(@ModelAttribute("searchVO") ScrapVO scrapVO, ModelMap model) throws Exception {
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	Scrap scrap = bbsScrapService.selectScrap(scrapVO);

	model.addAttribute("sessionUniqId", user.getUniqId());
	model.addAttribute("scrap", scrap);

	//-------------------------------------
	//게시판 내용 취득
	//-------------------------------------
	scrapVO.setNttId(scrap.getNttId());
	scrapVO.setBbsId(scrap.getBbsId());

	BoardVO vo = getBoardInfo(scrapVO);

	model.addAttribute("board", vo);
	////-----------------------------------

	return "egovframework/com/cop/scp/EgovScrapDetail";
    }

    /**
     * 스크랩 등록을 위한 등록 페이지로 이동한다.
     *
     * @param scrapVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/scp/addScrap.do")
    public String addScrap(@ModelAttribute("searchVO") ScrapVO scrapVO, ModelMap model) throws Exception {

	Scrap scrap = new Scrap();

	model.addAttribute("scrap", scrap);

	//-------------------------------------
	//게시판 내용 취득
	//-------------------------------------
	BoardVO vo = getBoardInfo(scrapVO);

	model.addAttribute("board", vo);
	////-----------------------------------

	return "egovframework/com/cop/scp/EgovScrapRegist";
    }

    /**
     * 스크랩된 원 게시판 내용을 조회한다.
     *
     * @param scrapVO
     * @return
     * @throws Exception
     */
    private BoardVO getBoardInfo(ScrapVO scrapVO) throws Exception {
	BoardVO boardVO = new BoardVO();

	boardVO.setBbsId(scrapVO.getBbsId());
	boardVO.setNttId(scrapVO.getNttId());

	// 조회수 증가 여부 지정
	boardVO.setPlusCount(false);

	BoardVO vo = bbsMngService.selectBoardArticle(boardVO);
	return vo;
    }

    /**
     * 스크랩을 등록한다.
     *
     * @param scrapVO
     * @param scrap
     * @param bindingResult
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/scp/insertScrap.do")
    public String insertScrap(@ModelAttribute("searchVO") ScrapVO scrapVO, @ModelAttribute("scrap") Scrap scrap,
	    BindingResult bindingResult, ModelMap model) throws Exception {

	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	beanValidator.validate(scrap, bindingResult);
	if (bindingResult.hasErrors()) {
	    //-------------------------------------
	    //게시판 내용 취득
	    //-------------------------------------
	    BoardVO vo = getBoardInfo(scrapVO);

	    model.addAttribute("board", vo);
	    ////-----------------------------------

	    return "egovframework/com/cop/scp/EgovScrapRegist";
	}

	if (isAuthenticated) {
	    scrap.setFrstRegisterId(user.getUniqId());

	    bbsScrapService.insertScrap(scrap);
	}

	return "forward:/cop/scp/selectScrapList.do";
    }

    /**
     * 스크랩을 삭제한다.
     *
     * @param ScrapVO
     * @param Scrap
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/scp/deleteScrap.do")
    public String deleteScrap(@ModelAttribute("searchVO") ScrapVO scrapVO, @ModelAttribute("Scrap") Scrap scrap, ModelMap model) throws Exception {
	@SuppressWarnings("unused")
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	if (isAuthenticated) {
	    bbsScrapService.deleteScrap(scrapVO);
	}

	return "forward:/cop/scp/selectScrapList.do";
    }

    /**
     * 스크랩 수정 페이지로 이동한다.
     *
     * @param scrapVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/scp/forUpdateScrap.do")
    public String forUpdateScrap(@ModelAttribute("searchVO") ScrapVO scrapVO, @ModelAttribute("scrap") Scrap scrap, ModelMap model) throws Exception {
	Scrap vo = bbsScrapService.selectScrap(scrapVO);

	model.addAttribute("scrap", vo);

	//-------------------------------------
	//게시판 내용 취득
	//-------------------------------------
	BoardVO board = getBoardInfo(scrapVO);

	model.addAttribute("board", board);
	////-----------------------------------

	return "egovframework/com/cop/scp/EgovScrapUpdt";
    }

    /**
     * 스크랩을 수정한다.
     *
     * @param ScrapVO
     * @param Scrap
     * @param bindingResult
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/scp/updateScrap.do")
    public String updateScrap(@ModelAttribute("searchVO") ScrapVO scrapVO, @ModelAttribute("Scrap") Scrap scrap,
	    BindingResult bindingResult, ModelMap model) throws Exception {

	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	beanValidator.validate(scrap, bindingResult);
	if (bindingResult.hasErrors()) {

	    Scrap vo = bbsScrapService.selectScrap(scrapVO);

	    model.addAttribute("result", vo);

	    return "egovframework/com/cop/scp/EgovScrapUpdt";
	}

	if (isAuthenticated) {
	    scrap.setLastUpdusrId(user.getUniqId());

	    bbsScrapService.updateScrap(scrap);
	}

	return "forward:/cop/scp/selectScrapList.do";
    }

    /**
     * 마이페이지용 스크랩관리 목록 조회를 제공한다.
     *
     * @param scrapVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/scp/selectScrapMainList.do")
    public String selectScrapMainList(@ModelAttribute("searchVO") ScrapVO scrapVO, ModelMap model) throws Exception {
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	scrapVO.setUniqId(user.getUniqId());

	scrapVO.setPageUnit(propertyService.getInt("pageUnit"));
	scrapVO.setPageSize(propertyService.getInt("pageSize"));

	scrapVO.setFirstIndex(0);
	scrapVO.setRecordCountPerPage(5);

	Map<String, Object> map = bbsScrapService.selectScrapList(scrapVO);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));

	return "egovframework/com/cop/scp/EgovScrapMainList";
    }
}
