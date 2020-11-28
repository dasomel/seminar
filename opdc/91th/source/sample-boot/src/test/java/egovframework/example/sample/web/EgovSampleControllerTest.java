package egovframework.example.sample.web;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasEntry;
import static org.hamcrest.Matchers.hasProperty;
import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.beans.SamePropertyValuesAs.samePropertyValuesAs;
import static org.junit.Assert.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.util.Map;

import javax.annotation.Resource;

import org.hamcrest.Matchers;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

@RunWith(SpringJUnit4ClassRunner.class)
@DirtiesContext
@SpringBootTest
public class EgovSampleControllerTest extends AbstractTransactionalJUnit4SpringContextTests {
	@Resource  WebApplicationContext wac;
	private MockMvc mockMvc;

	@InjectMocks SampleVO sampleVO;
	@Resource EgovSampleService sampleService;
	
	@Before
    public void setUp() throws Exception {
    	MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
    }

	@Test
    public void testSelectSampleList() throws Exception {
    	mockMvc.perform(get("/egovSampleList.do")
    			.accept(MediaType.TEXT_PLAIN)
			)
			.andDo(print())
			.andExpect(status().isOk())
			.andExpect(view().name("sample/egovSampleList"))
	        .andExpect(model().attributeExists("resultList"))
	        .andExpect(model().attribute("resultList", hasSize(10)))
	        .andExpect(model().attributeExists("paginationInfo"))
	        .andExpect(model().attribute("resultList", Matchers.<Map<String, Object>>hasItem(hasEntry("id","SAMPLE-00114"))))
	        .andExpect(model().attribute("resultList", Matchers.<Map<String, Object>>hasItem(hasEntry("name","Runtime Environment"))))
	        .andExpect(model().attribute("resultList", Matchers.<Map<String, Object>>hasItem(hasEntry("description","Integration Layer"))))
	        .andExpect(model().attribute("resultList", Matchers.<Map<String, Object>>hasItem(hasEntry("useYn","Y"))))
	        .andExpect(model().attribute("resultList", Matchers.<Map<String, Object>>hasItem(hasEntry("regUser","eGov"))))
			;
    }
    
    @Test
    public void testAddSampleView() throws Exception {
    	mockMvc.perform(get("/addSample.do")
    			.accept(MediaType.TEXT_PLAIN)
    			)
    	.andDo(print())
    	.andExpect(status().isOk())
    	.andExpect(view().name("sample/egovSampleRegister"))
    	.andExpect(model().attributeExists("sampleVO"))
    	.andExpect(model().attribute("sampleVO", hasProperty("id")))
    	.andExpect(model().attribute("sampleVO", hasProperty("name")))
    	.andExpect(model().attribute("sampleVO", hasProperty("description")))
    	.andExpect(model().attribute("sampleVO", hasProperty("useYn")))
    	.andExpect(model().attribute("sampleVO", hasProperty("regUser")))
    	;
    }
    
    @Test
    public void testAddSample_error() throws Exception {
    	mockMvc.perform(post("/addSample.do")
    			.accept(MediaType.TEXT_PLAIN)
    			)
    	.andDo(print())
    	.andExpect(status().isOk())
    	.andExpect(view().name("sample/egovSampleRegister"))
    	.andExpect(model().attributeExists("searchVO"))
    	.andExpect(model().attributeExists("sampleVO"))
    	.andExpect(model().attributeHasFieldErrors("sampleVO", "name"))
    	;
    }
    
    @Test
    public void testAddSample_insert() throws Exception {
    	sampleVO.setId("SAMPLE-00115");
    	sampleVO.setName("카테고리");
    	sampleVO.setUseYn("N");
    	sampleVO.setDescription("테스트설명");
    	sampleVO.setRegUser("eGov");
    	
    	mockMvc.perform(post("/addSample.do")
    			.accept(MediaType.TEXT_PLAIN)
    			.flashAttr("sampleVO", sampleVO)
    			)
    	.andDo(print())
    	.andExpect(status().isOk())
    	.andExpect(view().name("forward:/egovSampleList.do"))
    	.andExpect(model().attributeExists("searchVO"))
    	.andExpect(model().attributeExists("sampleVO"))
    	.andExpect(forwardedUrl("/egovSampleList.do"));
    	;
    	
        SampleVO returnVO = sampleService.selectSample(sampleVO);
        assertThat(returnVO, is(notNullValue()));
        assertThat(returnVO, samePropertyValuesAs(sampleVO));
    }
    
    @Test
    public void testUpdateSampleView() throws Exception {
    	mockMvc.perform(get("/updateSampleView.do")
    			.accept(MediaType.TEXT_PLAIN)
    			.param("selectedId", "SAMPLE-00114")
    			.flashAttr("searchVO", new SampleDefaultVO())
    			)
    	.andDo(print())
    	.andExpect(status().isOk())
    	.andExpect(view().name("sample/egovSampleRegister"))
    	;
    }
    
    @Test
    public void testUpdateSampleView_error() throws Exception {
    	mockMvc.perform(get("/updateSampleView.do")
    			.accept(MediaType.TEXT_PLAIN)
    			.param("selectedId", "SAMPLE-00000")
    			.flashAttr("searchVO", new SampleDefaultVO())
    			)
    	.andDo(print())
    	.andExpect(status().isOk())
    	.andExpect(view().name("cmmn/egovError"))
    	.andExpect(model().attributeExists("exception"))
    	.andExpect(result -> assertTrue(result.getResolvedException() instanceof EgovBizException))
    	;
    }
    
    @Test
    public void testUpdateSample() throws Exception {
    	sampleVO.setId("SAMPLE-00114");
    	sampleVO.setName("카테고리");
    	sampleVO.setUseYn("N");
    	sampleVO.setDescription("테스트설명");
    	sampleVO.setRegUser("eGov");
    	mockMvc.perform(get("/updateSample.do")
    			.accept(MediaType.TEXT_PLAIN)
    			.flashAttr("sampleVO", sampleVO)
    			)
    	.andDo(print())
    	.andExpect(status().isOk())
    	.andExpect(view().name("forward:/egovSampleList.do"))
    	.andExpect(forwardedUrl("/egovSampleList.do"));
    	
    	SampleVO returnVO = sampleService.selectSample(sampleVO);
        assertThat(returnVO, is(notNullValue()));
        assertThat(returnVO, samePropertyValuesAs(sampleVO));
    }
    
    @Test
    public void testUpdateSample_error() throws Exception {
    	mockMvc.perform(get("/updateSample.do")
    			.accept(MediaType.TEXT_PLAIN)
    			)
    	.andDo(print())
    	.andExpect(status().isOk())
    	.andExpect(view().name("sample/egovSampleRegister"))
    	.andExpect(model().attributeExists("sampleVO"))
    	;
    }
    
    @Test
    public void testDeleteSample() throws Exception {
    	sampleVO.setId("SAMPLE-00114");
    	mockMvc.perform(get("/deleteSample.do")
    			.accept(MediaType.TEXT_PLAIN)
    			.flashAttr("sampleVO", sampleVO)
    			)
    	.andDo(print())
    	.andExpect(status().isOk())
    	.andExpect(view().name("forward:/egovSampleList.do"))
    	.andExpect(model().attributeExists("sampleVO"))
    	.andExpect(forwardedUrl("/egovSampleList.do"))
    	;
    }
	
}
