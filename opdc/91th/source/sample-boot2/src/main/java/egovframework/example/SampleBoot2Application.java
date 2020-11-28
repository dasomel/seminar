package egovframework.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication(scanBasePackageClasses = SampleBoot2Application.class)
@ImportResource({"classpath:/egovframework/spring/context-*.xml"
				,"classpath:/egovframework/springmvc/dispatcher-servlet.xml"})
public class SampleBoot2Application extends SpringBootServletInitializer {
    public static void main(String[] args) throws Exception {
        SpringApplication.run(SampleBoot2Application.class, args);
    }
}
