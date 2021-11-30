package com.task.config;

import com.task.interceptor.IdentityBookInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author: hbw
 **/
@Configuration
public class AddBookConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new IdentityBookInterceptor()).addPathPatterns("/book/addBook","/book/deleteBook");
    }
}
