package egovframework.com.cop.bbs.service;

import java.util.List;
import java.util.Map;


/**
 * 게시판 속성관리를 위한 서비스 인터페이스 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------     --------    ---------------------------
 *   2009.3.12  이삼섭          최초 생성
 *
 */
public interface EgovBBSAttributeManageService {

    /**
     * 등록된 게시판 속성정보를 삭제한다.
     * 
     * @param BoardMaster
     */
    public void deleteBBSMasterInf(BoardMaster boardMaster) throws Exception;

    /**
     * 신규 게시판 속성정보를 생성한다.
     * 
     * @param BoardMaster
     */
    public String insertBBSMastetInf(BoardMaster boardMaster) throws Exception;

    /**
     * 게시판 속성정보 한 건을 상세조회한다.
     * 
     * @param BoardMasterVO
     */
    public BoardMasterVO selectBBSMasterInf(BoardMaster searchVO) throws Exception;

    /**
     * 게시판 속성 정보의 목록을 조회 한다.
     * 
     * @param BoardMasterVO
     */
    public Map<String, Object> selectBBSMasterInfs(BoardMasterVO searchVO) throws Exception;

    /**
     * 게시판 속성정보를 수정한다.
     * 
     * @param BoardMaster
     */
    public void updateBBSMasterInf(BoardMaster boardMaster) throws Exception;

    /**
     * 템플릿의 유효여부를 점검한다.
     * 
     * @param BoardMasterVO
     */
    public void validateTemplate(BoardMasterVO searchVO) throws Exception;

    /**
     * 유효한 게시판 마스터 정보를 호출한다.
     * 
     * @param searchVO
     * @return
     * @throws Exception
     */
    public List<BoardMasterVO> selectAllBBSMasteInf(BoardMasterVO vo) throws Exception;

    /**
     * 사용중인 게시판 속성 정보의 목록을 조회 한다.
     * 
     * @param BoardMasterVO
     */
    public Map<String, Object> selectBdMstrListByTrget(BoardMasterVO vo) throws Exception;

    /**
     * 커뮤니티, 동호회에서 사용중인 게시판 속성 정보의 목록을 전체조회 한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public List<BoardMasterVO> selectAllBdMstrByTrget(BoardMasterVO vo) throws Exception;

    /**
     * 사용중이지 않은 게시판 속성 정보의 목록을 조회 한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectNotUsedBdMstrList(BoardMasterVO vo) throws Exception;
}
