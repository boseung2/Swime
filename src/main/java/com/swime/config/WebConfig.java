package com.swime.config;

import com.swime.util.CustomCorsFilter;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{RootConfig.class, SecurityConfig.class, WebSocketConfig.class};
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{ServletConfig.class};
    }

    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }


    //첨부파일
    @Override
    public void customizeRegistration(ServletRegistration.Dynamic registration) {
        registration.setInitParameter("throwExceptionIfNoHandlerFound", "true");

        MultipartConfigElement multipartConfig = new MultipartConfigElement
                ("C://upload//temp", 20971520,
                        41943040, 20971520);
        registration.setMultipartConfig(multipartConfig);

    }

    @Override
    protected Filter[] getServletFilters() {
        CharacterEncodingFilter characterEncodingFilter =
                new CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("UTF-8");
        characterEncodingFilter.setForceEncoding(true);

        CustomCorsFilter customCorsFilter = new CustomCorsFilter();

        return new Filter[]{characterEncodingFilter};
    }

}


