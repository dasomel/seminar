package egovframework.com.cop.cmt.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cop.bbs.service.Comment;
import egovframework.com.cop.bbs.service.CommentVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 댓글관리를 위한 데이터 접근 클래스
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
 *
 * </pre>
 */
@Repository("BBSCommentDAO")
public class BBSCommentDAO extends EgovComAbstractDAO {

    /**
     * 댓글에 대한 목록을 조회 한다.
     * 
     * @param commentVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<CommentVO> selectCommentList(CommentVO commentVO) throws Exception {
	return list("BBSCommentDAO.selectCommentList", commentVO);
    }
    
    /**
     * 댓글에 대한 목록 건수를 조회 한다.
     * 
     * @param commentVO
     * @return
     * @throws Exception
     */
    public int selectCommentListCnt(CommentVO commentVO) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("BBSCommentDAO.selectCommentListCnt", commentVO);
    }
    
    /**
     * 댓글을 등록한다.
     * 
     * @param comment
     * @throws Exception
     */
    public void insertComment(Comment comment) throws Exception {	
	insert("BBSCommentDAO.insertComment", comment);
    }
    
    /**
     * 댓글을 삭제한다.
     * 
     * @param commentVO
     * @throws Exception
     */
    public void deleteComment(CommentVO commentVO) throws Exception {
	update("BBSCommentDAO.deleteComment", commentVO);
    }
    
    /**
     * 댓글에 대한 내용을 조회한다.
     * 
     * @param commentVO
     * @return
     * @throws Exception
     */
    public Comment selectComment(CommentVO commentVO) throws Exception {
	return (Comment)selectByPk("BBSCommentDAO.selectComment", commentVO);
    }
    
    /**
     * 댓글에 대한 내용을 수정한다.
     * 
     * @param comment
     * @throws Exception
     */
    public void updateComment(Comment comment) throws Exception {	
	insert("BBSCommentDAO.updateComment", comment);
    }
    
    /**
     * 댓글에 대한 패스워드를 조회 한다.
     * 
     * @param comment
     * @return
     * @throws Exception
     */
    public String getCommentPassword(Comment comment) throws Exception {
	return (String)getSqlMapClientTemplate().queryForObject("BBSCommentDAO.getCommentPassword", comment);
    }
}
