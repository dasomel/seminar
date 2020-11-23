package egovframework.com.cop.scp.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovComponentChecker;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cop.bbs.service.EgovBBSScrapService;
import egovframework.com.cop.bbs.service.Scrap;
import egovframework.com.cop.bbs.service.ScrapVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 스크랩관리를 위한 서비스 구현 클래스
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
@Service("EgovBBSScrapService")
public class EgovBBSScrapServiceImpl extends AbstractServiceImpl implements EgovBBSScrapService {
    
    @Resource(name = "BBSScrapDAO")
    private BBSScrapDAO bbsScrapDAO;
    
    @Resource(name="egovScrapIdGnrService")
    private EgovIdGnrService idgenService;

    /**
     * 스크랩 사용 가능 여부를 확인한다.
     */
    public boolean canUseScrap() throws Exception {
	//String flag = EgovProperties.getProperty("Globals.addedOptions");
	//if (flag != null && flag.trim().equalsIgnoreCase("true")) {//2011.09.15	
	    return true;
	//}
	//return false;
    }

    /**
     * 스크랩에 대한 목록을 조회 한다.
     */
    public Map<String, Object> selectScrapList(ScrapVO scrapVO) throws Exception {
	List<ScrapVO> result = bbsScrapDAO.selectScrapList(scrapVO);
	int cnt = bbsScrapDAO.selectScrapListCnt(scrapVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }
    
    /**
     * 스크랩을 등록한다.
     */
    public void insertScrap(Scrap scrap) throws Exception {
	String scrapId = idgenService.getNextStringId();
	
	scrap.setScrapId(scrapId);
	
	bbsScrapDAO.insertScrap(scrap);
    }
    
    /**
     * 스크랩을 삭제한다.
     */
    public void deleteScrap(ScrapVO scrapVO) throws Exception {
	bbsScrapDAO.deleteScrap(scrapVO);
    }
    
    /**
     * 스크랩에 대한 내용을 조회한다.
     */
    public Scrap selectScrap(ScrapVO scrapVO) throws Exception {
	return bbsScrapDAO.selectScrap(scrapVO);
    }
    
    /**
     * 스크랩에 대한 내용을 수정한다.
     */
    public void updateScrap(Scrap scrap) throws Exception {
	bbsScrapDAO.updateScrap(scrap);
    }
}
