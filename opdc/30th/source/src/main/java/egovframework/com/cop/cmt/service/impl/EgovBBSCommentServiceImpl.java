package egovframework.com.cop.cmt.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovComponentChecker;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cop.bbs.service.BoardMaster;
import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.Comment;
import egovframework.com.cop.bbs.service.CommentVO;
import egovframework.com.cop.bbs.service.EgovBBSCommentService;
import egovframework.com.cop.bbs.service.impl.BBSAddedOptionsDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 댓글관리를 위한 서비스 구현 클래스
 * @author 공통컴포넌트개발팀 한성곤
 * @since 2009.06.29
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.06.29  한성곤          최초 생성
 *   2011.09.15  서준식          addedOptions 적용 방법 수정
 *   2011.10.18  서준식          AnswerNo 자동 생성 방식으로 변경
 * </pre>
 */
@Service("EgovBBSCommentService")
public class EgovBBSCommentServiceImpl extends AbstractServiceImpl implements EgovBBSCommentService {

    @Resource(name = "BBSAddedOptionsDAO")
    private BBSAddedOptionsDAO addedOptionsDAO;
    
    @Resource(name = "BBSCommentDAO")
    private BBSCommentDAO bbsCommentDAO;
    
    @Resource(name = "egovAnswerNoGnrService")
    private EgovIdGnrService egovAnswerNoGnrService;

    /**
     * 댓글 사용 가능 여부를 확인한다.
     */
    public boolean canUseComment(String bbsId) throws Exception {
	//String flag = EgovProperties.getProperty("Globals.addedOptions");
	//if (flag != null && flag.trim().equalsIgnoreCase("true")) {//2011.09.15
	    BoardMaster vo = new BoardMaster();
	    
	    vo.setBbsId(bbsId);
	    
	    BoardMasterVO options = addedOptionsDAO.selectAddedOptionsInf(vo);
	    
	    if (options == null) {
		return false;
	    }
	    
	    if (options.getCommentAt().equals("Y")) {
		return true;
	    }
	//}
	
	return false;
    }

    /**
     * 댓글에 대한 목록을 조회 한다.
     */
    public Map<String, Object> selectCommentList(CommentVO commentVO) throws Exception {
	List<CommentVO> result = bbsCommentDAO.selectCommentList(commentVO);
	int cnt = bbsCommentDAO.selectCommentListCnt(commentVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }
    
    /**
     * 댓글을 등록한다.
     */
    public void insertComment(Comment comment) throws Exception {
    comment.setCommentNo(egovAnswerNoGnrService.getNextLongId() + "");//2011.10.18
	bbsCommentDAO.insertComment(comment);
    }
    
    /**
     * 댓글을 삭제한다.
     */
    public void deleteComment(CommentVO commentVO) throws Exception {
	bbsCommentDAO.deleteComment(commentVO);
    }
    
    /**
     * 댓글에 대한 내용을 조회한다.
     */
    public Comment selectComment(CommentVO commentVO) throws Exception {
	return bbsCommentDAO.selectComment(commentVO);
    }
    
    /**
     * 댓글에 대한 내용을 수정한다.
     */
    public void updateComment(Comment comment) throws Exception {
	bbsCommentDAO.updateComment(comment);
    }
    
    /**
     * 댓글 패스워드를 가져온다.
     */
    public String getCommentPassword(Comment comment) throws Exception {
	return bbsCommentDAO.getCommentPassword(comment);
    }
}
