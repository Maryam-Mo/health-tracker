package com.example.health_trackerserver.config;

import ma.glasnost.orika.MapperFacade;
import ma.glasnost.orika.MapperFactory;
import ma.glasnost.orika.impl.DefaultMapperFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@ComponentScan(basePackages = "com.example.health_trackerserver.water")
public class AppConfig {

    @Bean
    public MapperFacade mapperFacade(MapperFactory mapperFactory) {
        return mapperFactory.getMapperFacade();
    }

    @Bean
    public MapperFactory mapperFactory() {
        return new DefaultMapperFactory.Builder().build();
    }

    @EnableSwagger2
    @Profile({"dev", "test"})
    @Controller
    public static class SwaggerConfig {

        @RequestMapping("/")
        public String redirectSwaggerMainPage() {
            return "redirect:/swagger-ui.html";
        }

        @Bean
        public Docket documentation() {
            return new Docket(DocumentationType.SWAGGER_2)
                    .select()
                    .apis(RequestHandlerSelectors.any())
                    .paths(PathSelectors.regex("/api/.*"))
                    .build().pathMapping("/")
                    .apiInfo(metadata());
        }

        private ApiInfo metadata() {
            return new ApiInfoBuilder()
                    .title("Health Tracker Service API")
                    .build();
        }
    }
}
