package egovframework.com.cop.bbs.service;

import java.util.Map;


/**
 * 댓글관리를 위한 서비스 인터페이스 클래스
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
public interface EgovBBSCommentService {
    /**
     * 댓글 사용 가능 여부를 확인한다.
     * 
     * @param bbsId
     * @return
     * @throws Exception
     */
    public boolean canUseComment(String bbsId) throws Exception;
    
    /**
     * 댓글에 대한 목록을 조회 한다.
     * 
     * @param commentVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCommentList(CommentVO commentVO) throws Exception;
    
    /**
     * 댓글을 등록한다.
     * 
     * @param comment
     * @throws Exception
     */
    public void insertComment(Comment comment) throws Exception;
    
    /**
     * 댓글을 삭제한다.
     * 
     * @param commentVO
     * @throws Exception
     */
    public void deleteComment(CommentVO commentVO) throws Exception;
    
    /**
     * 댓글에 대한 내용을 조회한다.
     *      
     * @param commentVO
     * @return
     * @throws Exception
     */
    public Comment selectComment(CommentVO commentVO) throws Exception;
    
    /**
     * 댓글에 대한 내용을 수정한다.
     * 
     * @param comment
     * @throws Exception
     */
    public void updateComment(Comment comment) throws Exception;
   
    /**
     * 댓글 패스워드를 가져온다.
     * 
     * @param comment
     * @return
     * @throws Exception
     */
    public String getCommentPassword(Comment comment) throws Exception;
}
