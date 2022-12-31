package egovframework.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication(scanBasePackageClasses = SampleBootApplication.class)
@ImportResource({"classpath:/egovframework/spring/context-*.xml"
        ,"classpath:/egovframework/springmvc/dispatcher-servlet.xml"})
public class SampleBootApplication extends SpringBootServletInitializer {
    public static void main(String[] args) throws Exception {
        SpringApplication.run(SampleBootApplication.class, args);
    }
}