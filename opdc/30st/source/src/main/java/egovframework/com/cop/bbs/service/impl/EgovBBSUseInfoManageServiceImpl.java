package egovframework.com.cop.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cop.bbs.service.BoardUseInf;
import egovframework.com.cop.bbs.service.BoardUseInfVO;
import egovframework.com.cop.bbs.service.EgovBBSUseInfoManageService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 게시판 이용정보를 관리하기 위한 서비스 구현 클래스
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
 *   2009.4.2   이삼섭          최초 생성
 *   2011.7.27  안민정			동호회, 커뮤니티 로직 분리 (EgovBBSUseInfoManageServiceImpl -> EgovCmyBBSUseInfoManageServiceImpl)
 *
 * </pre>
 */
@Service("EgovBBSUseInfoManageService")
public class EgovBBSUseInfoManageServiceImpl extends AbstractServiceImpl implements EgovBBSUseInfoManageService {
	
    @Resource(name = "BBSUseInfoManageDAO")
    private BBSUseInfoManageDAO bbsUseDAO;

    /**
     * 게시판 사용 정보를 삭제한다.
     * 
     * @see egovframework.com.cop.bbs.service.com.service.EgovBBSUseInfoManageService#deleteBBSUseInf(egovframework.com.cop.bbs.service.com.service.BoardUseInf)
     */
    public void deleteBBSUseInf(BoardUseInf bdUseInf) throws Exception {
	bbsUseDAO.deleteBBSUseInf(bdUseInf);
    }

    /**
     * 게시판 사용정보를 등록한다.
     * 
     * @see egovframework.com.cop.bbs.service.com.service.EgovBBSUseInfoManageService#insertBBSUseInf(egovframework.com.cop.bbs.service.com.service.BoardUseInf)
     */
    public void insertBBSUseInf(BoardUseInf bdUseInf) throws Exception {
	bbsUseDAO.insertBBSUseInf(bdUseInf);
    }

    /**
     * 게시판 사용정보 목록을 조회한다.
     * 
     * @see egovframework.com.cop.bbs.service.com.service.EgovBBSUseInfoManageService#selectBBSUseInfs(egovframework.com.cop.bbs.service.com.service.BoardUseInfVO)
     */
    public Map<String, Object> selectBBSUseInfs(BoardUseInfVO bdUseVO) throws Exception {

	List<BoardUseInfVO> result = bbsUseDAO.selectBBSUseInfs(bdUseVO);
	int cnt = bbsUseDAO.selectBBSUseInfsCnt(bdUseVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 게시판 사용정보를 수정한다.
     * 
     * @see egovframework.com.cop.bbs.service.com.service.EgovBBSUseInfoManageService#updateBBSUseInf(egovframework.com.cop.bbs.service.com.service.BoardUseInf)
     */
    public void updateBBSUseInf(BoardUseInf bdUseInf) throws Exception {
	bbsUseDAO.updateBBSUseInf(bdUseInf);
    }

    /**
     * 게시판 사용정보에 대한 상세정보를 조회한다.
     * 
     * @see egovframework.com.cop.bbs.service.com.service.EgovBBSUseInfoManageService#selectBBSUseInf(egovframework.com.cop.bbs.service.com.service.BoardUseInfVO)
     */
    public BoardUseInfVO selectBBSUseInf(BoardUseInfVO bdUseVO) throws Exception {
	return bbsUseDAO.selectBBSUseInf(bdUseVO);
    }

    /**
     * 게시판에 대한 사용정보를 삭제한다.
     * 
     * @see egovframework.com.cop.bbs.service.EgovBBSUseInfoManageService#deleteBBSUseInfByBoardId(egovframework.com.cop.bbs.service.BoardUseInf)
     */
    public void deleteBBSUseInfByBoardId(BoardUseInf bdUseInf) throws Exception {
	bbsUseDAO.deleteBBSUseInfByBoardId(bdUseInf);
    }

    /**
     * 커뮤니티, 동호회에 사용되는 게시판 사용정보에 대한 목록을 조회한다.
     * 
     * @see egovframework.com.cop.bbs.service.EgovBBSUseInfoManageService#selectBBSUseInfsByTrget(egovframework.com.cop.bbs.service.BoardUseInfVO)
     */
    public Map<String, Object> selectBBSUseInfsByTrget(BoardUseInfVO bdUseVO) throws Exception {
	List<BoardUseInfVO> result = bbsUseDAO.selectBBSUseInfsByTrget(bdUseVO);
	int cnt = bbsUseDAO.selectBBSUseInfsCntByTrget(bdUseVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 커뮤니티, 동호회에 사용되는 게시판 사용정보를 수정한다.
     */
    public void updateBBSUseInfByTrget(BoardUseInf bdUseInf) throws Exception {
	bbsUseDAO.updateBBSUseInfByTrget(bdUseInf);
    }
}
