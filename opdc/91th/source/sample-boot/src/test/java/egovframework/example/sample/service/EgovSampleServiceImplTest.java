package egovframework.example.sample.service;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.hamcrest.CoreMatchers.nullValue;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.beans.SamePropertyValuesAs.samePropertyValuesAs;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RunWith(SpringJUnit4ClassRunner.class)
@DirtiesContext
@SpringBootTest
public class EgovSampleServiceImplTest extends AbstractTransactionalJUnit4SpringContextTests {
	@Resource EgovSampleService sampleService;
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;
	@InjectMocks SampleDefaultVO searchVO;
	@InjectMocks SampleVO sampleVO;
	@InjectMocks PaginationInfo paginationInfo;
	
    @Before
    public void setUp() {
    	MockitoAnnotations.initMocks(this);
    	/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    }
    
    @Test
    public void testInsertSample() throws Exception {
    	sampleVO.setName("카테고리");
    	sampleVO.setUseYn("Y");
    	sampleVO.setDescription("테스트설명");
    	sampleVO.setRegUser("테스트");
		String returnId = sampleService.insertSample(sampleVO);
		assertThat(returnId, is(notNullValue()));
//		assertThat(returnId, is("SAMPLE-00115"));
		
        sampleVO.setId(returnId);
        SampleVO returnVO = sampleService.selectSample(sampleVO);
        assertThat(returnVO, is(notNullValue()));
        assertThat(returnVO, samePropertyValuesAs(sampleVO));
    }
    
    @Test
    public void testUpdateSample() throws Exception {
    	sampleVO.setId("SAMPLE-00104");
    	sampleVO.setName("카테고리");
    	sampleVO.setUseYn("N");
    	sampleVO.setDescription("테스트설명");
    	sampleService.updateSample(sampleVO);
    	
    	SampleVO returnVO = sampleService.selectSample(sampleVO);
    	assertThat(returnVO, is(notNullValue()));
    	assertThat(returnVO.getName(), is(sampleVO.getName()));
    	assertThat(returnVO.getUseYn(), is(sampleVO.getUseYn()));
    	assertThat(returnVO.getDescription(), is(sampleVO.getDescription()));
    }
    
    @SuppressWarnings("unchecked")
	@Test
    public void testDeleteSample() throws Exception {
    	sampleVO.setId("SAMPLE-00114");
    	sampleService.deleteSample(sampleVO);
    	
    	List<?> resultList = sampleService.selectSampleList(searchVO);
    	assertThat(resultList, is(notNullValue()));
        assertThat(resultList.size(), is(10));
        assertThat(((List<EgovMap>)resultList).get(0).get("id"), is("SAMPLE-00113"));
    }
    
    @Test
    public void testSelectSample() throws Exception {
    	sampleVO.setId("SAMPLE-00114");
    	SampleVO returnVO = sampleService.selectSample(sampleVO);
    	assertThat(returnVO, is(notNullValue()));
    	assertThat(returnVO.getId(), is("SAMPLE-00114"));
    	assertThat(returnVO.getName(), is("Runtime Environment"));
    	assertThat(returnVO.getUseYn(), is("Y"));
    	assertThat(returnVO.getDescription(), is("Integration Layer"));
    	assertThat(returnVO.getRegUser(), is("eGov"));
    }
    
    @Test
    public void testSelectSample_processException() {
    	sampleVO.setId("SAMPLE-00115");
    	SampleVO returnVO = null;
		try {
			returnVO = sampleService.selectSample(sampleVO);
		} catch (Exception e) {
			assertThat(e.getMessage(), is("해당 데이터가 없습니다."));
			assertThat(e.toString(), is("egovframework.rte.fdl.cmmn.exception.EgovBizException: 해당 데이터가 없습니다."));
			assertThat(returnVO, is(nullValue()));
		}
    }
    
    @SuppressWarnings("unchecked")
	@Test
    public void testSelectSampleList() throws Exception {
		List<?> resultList = sampleService.selectSampleList(searchVO);

		assertThat(resultList, is(notNullValue()));
        assertThat(resultList.size(), is(10));
        assertThat(((List<EgovMap>)resultList).get(0).get("id"), is("SAMPLE-00114"));
    }
    
    @SuppressWarnings("unchecked")
    @Test
    public void testSelectSampleList_Paging() throws Exception {
    	paginationInfo.setCurrentPageNo(2);
		paginationInfo.setRecordCountPerPage(10);

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    	
    	List<?> resultList = sampleService.selectSampleList(searchVO);
    	
    	assertThat(resultList, is(notNullValue()));
    	assertThat(resultList.size(), is(10));
    	assertThat(((List<EgovMap>)resultList).get(0).get("id"), is("SAMPLE-00104"));
    }
    
    @SuppressWarnings("unchecked")
    @Test
    public void testSelectSampleList_SearchId() throws Exception {
    	searchVO.setSearchCondition("0");	// ID 검색
    	searchVO.setSearchKeyword("SAMPLE-0011");
    	List<?> resultList = sampleService.selectSampleList(searchVO);
    	
    	assertThat(resultList, is(notNullValue()));
    	assertThat(resultList.size(), is(5));
    	assertThat(((List<EgovMap>)resultList).get(0).get("id"), is("SAMPLE-00114"));
    }
    
    @Test
    public void testSelectSampleList_SearchWrongId() throws Exception {
    	searchVO.setSearchCondition("0");	// ID 검색
    	searchVO.setSearchKeyword("Test");
    	List<?> resultList = sampleService.selectSampleList(searchVO);
    	
    	assertThat(resultList, is(notNullValue()));
    	assertThat(resultList.size(), is(0));
    }
    
    @SuppressWarnings("unchecked")
    @Test
    public void testSelectSampleList_SearchName() throws Exception {
    	searchVO.setSearchCondition("1");	// Name 검색
    	searchVO.setSearchKeyword("Runtime");
    	List<?> resultList = sampleService.selectSampleList(searchVO);
    	
    	assertThat(resultList, is(notNullValue()));
    	assertThat(resultList.size(), is(10));
    	assertThat(((List<EgovMap>)resultList).get(0).get("id"), is("SAMPLE-00114"));
    }
    
    @Test
    public void testSelectSampleList_SearchWrongName() throws Exception {
    	searchVO.setSearchCondition("1");	// Name 검색
    	searchVO.setSearchKeyword("Test");
    	List<?> resultList = sampleService.selectSampleList(searchVO);
    	
    	assertThat(resultList, is(notNullValue()));
    	assertThat(resultList.size(), is(0));
    }
    
    @Test
    public void testSelectSampleListCnt() throws Exception {
		int resultCnt = sampleService.selectSampleListTotCnt(searchVO);
		assertThat(resultCnt, is(notNullValue()));
        assertThat(resultCnt, is(114));
    }
    
    @Test
    public void testSelectSampleListCnt_SearchId() throws Exception {
    	searchVO.setSearchCondition("0");	// ID 검색
    	searchVO.setSearchKeyword("SAMPLE-0011");
    	int resultCnt = sampleService.selectSampleListTotCnt(searchVO);
    	
    	assertThat(resultCnt, is(notNullValue()));
    	assertThat(resultCnt, is(5));
    }
    
    @Test
    public void testSelectSampleListCnt_SearchWrongId() throws Exception {
    	searchVO.setSearchCondition("0");	// ID 검색
    	searchVO.setSearchKeyword("Test");
    	int resultCnt = sampleService.selectSampleListTotCnt(searchVO);
    	
    	assertThat(resultCnt, is(notNullValue()));
    	assertThat(resultCnt, is(0));
    }
    
    @Test
    public void testSelectSampleListCnt_SearchName() throws Exception {
    	searchVO.setSearchCondition("1");	// Name 검색
    	searchVO.setSearchKeyword("Runtime");
    	int resultCnt = sampleService.selectSampleListTotCnt(searchVO);
    	
    	assertThat(resultCnt, is(notNullValue()));
    	assertThat(resultCnt, is(114));
    }
    
    @Test
    public void testSelectSampleListCnt_SearchWrongName() throws Exception {
    	searchVO.setSearchCondition("1");	// Name 검색
    	searchVO.setSearchKeyword("Test");
    	int resultCnt = sampleService.selectSampleListTotCnt(searchVO);
    	
    	assertThat(resultCnt, is(notNullValue()));
    	assertThat(resultCnt, is(0));
    }
}
