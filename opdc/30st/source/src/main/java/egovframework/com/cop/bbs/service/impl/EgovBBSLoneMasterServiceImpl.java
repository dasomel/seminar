package egovframework.com.cop.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardUseInf;
import egovframework.com.cop.bbs.service.EgovBBSLoneMasterService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 게시판 속성관리를 위한 서비스 구현 클래스
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
 *
 * </pre>
 */
@Service("EgovBBSLoneMasterService")
public class EgovBBSLoneMasterServiceImpl extends AbstractServiceImpl implements EgovBBSLoneMasterService {

    @Resource(name = "BBSLoneMasterDAO")
    private BBSLoneMasterDAO masterDAO;

    @Resource(name = "BBSUseInfoManageDAO")
    private BBSUseInfoManageDAO bbsUseDAO;

    @Resource(name = "egovBBSMstrIdGnrService")
    private EgovIdGnrService idgenService;
		
    /**
     * 등록된 게시판 속성정보를 삭제한다.
     */
    public void deleteMaster(BoardMaster boardMaster) throws Exception {
	masterDAO.deleteMaster(boardMaster);
	
	BoardUseInf bdUseInf = new BoardUseInf();
	
	bdUseInf.setBbsId(boardMaster.getBbsId());
	bdUseInf.setLastUpdusrId(boardMaster.getLastUpdusrId());
	
	bbsUseDAO.deleteBBSUseInfByBoardId(bdUseInf);
    }

    /**
     * 신규 게시판 속성정보를 생성한다.
     */
    public String insertMaster(BoardMaster boardMaster) throws Exception {
	String bbsId = idgenService.getNextStringId();
	
	boardMaster.setBbsId(bbsId);
	
	masterDAO.insertMaster(boardMaster);

	//----------------------------------------------
	// 게시판 사용 등록 (시스템)
	//----------------------------------------------
	BoardUseInf bdUseInf = new BoardUseInf();

	bdUseInf.setBbsId(bbsId);
	bdUseInf.setTrgetId("SYSTEM_DEFAULT_BOARD");
	bdUseInf.setRegistSeCode("REGC01");
	bdUseInf.setFrstRegisterId(boardMaster.getFrstRegisterId());
	bdUseInf.setUseAt("Y");

	bbsUseDAO.insertBBSUseInf(bdUseInf);
	    
	return bbsId;
    }

    /**
     * 게시판 속성정보 한 건을 상세조회한다.
     */
    public BoardMasterVO selectMaster(BoardMaster searchVO) throws Exception {
	return masterDAO.selectMaster(searchVO);
    }

    /**
     * 게시판 속성 정보의 목록을 조회 한다.
     */
    public Map<String, Object> selectMasterList(BoardMasterVO searchVO) throws Exception {
	List<BoardMasterVO> result = masterDAO.selectMasterList(searchVO);
	int cnt = masterDAO.selectMasterListCnt(searchVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 게시판 속성정보를 수정한다.
     */
    public void updateMaster(BoardMaster boardMaster) throws Exception {
	masterDAO.updateMaster(boardMaster);
    }
}
