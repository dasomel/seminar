package egovframework.example.sample.broswer.chrome;

import static org.junit.Assert.fail;

import java.io.File;
import java.util.concurrent.TimeUnit;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.NoAlertPresentException;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeDriverService;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Bean;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@SuppressWarnings("unused")
@RunWith(SpringJUnit4ClassRunner.class)
@DirtiesContext
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT
				, properties = "server.port = 8080")
public class ViewTest {
	public WebDriver driver;
	private String baseUrl = "http://localhost:8080/";
	private boolean acceptNextAlert = true;
	private StringBuffer verificationErrors = new StringBuffer();

	@Before
	public void setUp() throws Exception {
		ChromeOptions options = new ChromeOptions();
		options.setBinary(new File("C:\\eGovFrameDev-3.9.0-64bit\\browser\\chrome-80.0.3987.149\\chrome.exe"));
//		options.setHeadless(true);
		
		ChromeDriverService service = new ChromeDriverService
			.Builder()
	        .usingDriverExecutable(new File("C:\\eGovFrameDev-3.9.0-64bit\\SeleniumDriver\\chromedriver-80.0.3987.106.exe"))
	        .usingAnyFreePort()
	        .build();
		driver = new ChromeDriver(service, options);
	}
	
	@Test
	public void testModifyTestCase() throws Exception {
		driver.get(baseUrl + "/egovSampleList.do");
		driver.findElement(By.linkText("SAMPLE-00114")).click();
		driver.findElement(By.id("description")).click();
		driver.findElement(By.id("description")).clear();
		driver.findElement(By.id("description")).sendKeys("Integration Layer1111");
		driver.findElement(By.linkText("수정")).click();
	}

	@After
	public void tearDown() throws Exception {
//		driver.quit();
		String verificationErrorString = verificationErrors.toString();
		if (!"".equals(verificationErrorString)) {
			fail(verificationErrorString);
		}
	}

	private boolean isElementPresent(By by) {
		try {
			driver.findElement(by);
			return true;
		} catch (NoSuchElementException e) {
			return false;
		}
	}

	private boolean isAlertPresent() {
		try {
			driver.switchTo().alert();
			return true;
		} catch (NoAlertPresentException e) {
			return false;
		}
	}

	private String closeAlertAndGetItsText() {
		try {
			Alert alert = driver.switchTo().alert();
			String alertText = alert.getText();
			if (acceptNextAlert) {
				alert.accept();
			} else {
				alert.dismiss();
			}
			return alertText;
		} finally {
			acceptNextAlert = true;
		}
	}
}
