package egovframework.com.cop.scp.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cop.bbs.service.Scrap;
import egovframework.com.cop.bbs.service.ScrapVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * 스크랩관리를 위한 데이터 접근 클래스
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
 * </pre>
 */
@Repository("BBSScrapDAO")
public class BBSScrapDAO extends EgovComAbstractDAO {

    /**
     * 스크랩에 대한 목록을 조회 한다.
     * 
     * @param scrapVO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<ScrapVO> selectScrapList(ScrapVO scrapVO) throws Exception {
	return list("BBSScrapDAO.selectScrapList", scrapVO);
    }
    
    /**
     * 스크랩에 대한 목록 건수를 조회 한다.
     * 
     * @param scrapVO
     * @return
     * @throws Exception
     */
    public int selectScrapListCnt(ScrapVO scrapVO) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("BBSScrapDAO.selectScrapListCnt", scrapVO);
    }
    
    /**
     * 스크랩을 등록한다.
     * 
     * @param scrap
     * @throws Exception
     */
    public void insertScrap(Scrap scrap) throws Exception {	
	insert("BBSScrapDAO.insertScrap", scrap);
    }
    
    /**
     * 스크랩을 삭제한다.
     * 
     * @param scrapVO
     * @throws Exception
     */
    public void deleteScrap(ScrapVO scrapVO) throws Exception {
	update("BBSScrapDAO.deleteScrap", scrapVO);
    }
    
    /**
     * 스크랩에 대한 내용을 조회한다.
     * 
     * @param scrapVO
     * @return
     * @throws Exception
     */
    public Scrap selectScrap(ScrapVO scrapVO) throws Exception {
	return (Scrap)selectByPk("BBSScrapDAO.selectScrap", scrapVO);
    }
    
    /**
     * 스크랩에 대한 내용을 수정한다.
     * 
     * @param scrap
     * @throws Exception
     */
    public void updateScrap(Scrap scrap) throws Exception {	
	insert("BBSScrapDAO.updateScrap", scrap);
    }
}
