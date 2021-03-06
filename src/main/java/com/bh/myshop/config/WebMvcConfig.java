package com.bh.myshop.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	@Value("${custom.genFileDirPath}")
	private String genFileDirPath;

	// CORS 허용
	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**");
	}

	// beforeActionInterceptor 인터셉터 불러오기
	@Autowired
	@Qualifier("beforeActionInterceptor")
	HandlerInterceptor beforeActionInterceptor;

	// needAdminInterceptor 인터셉터 불러오기
	@Autowired
	@Qualifier("needAdminInterceptor")
	HandlerInterceptor needAdminInterceptor;

	// needLoginInterceptor 인터셉터 불러오기
	@Autowired
	@Qualifier("needLoginInterceptor")
	HandlerInterceptor needLoginInterceptor;

	// needLogoutInterceptor 인터셉터 불러오기
	@Autowired
	@Qualifier("needLogoutInterceptor")
	HandlerInterceptor needLogoutInterceptor;

	// 이 함수는 인터셉터를 적용하는 역할을 합니다.
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// beforeActionInterceptor 인터셉터가 모든 액션 실행전에 실행되도록 처리
		registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**")
				.excludePathPatterns("/gen/**");

		// 어드민 필요
		registry.addInterceptor(needAdminInterceptor).addPathPatterns("/adm/**")
				.excludePathPatterns("/adm/member/login").excludePathPatterns("/adm/member/doLogin")
				.excludePathPatterns("/adm/member/join").excludePathPatterns("/adm/member/doJoin")
				.excludePathPatterns("/adm/member/getLoginIdDup").excludePathPatterns("/adm/member/findLoginId")
				.excludePathPatterns("/adm/member/doFindLoginId").excludePathPatterns("/adm/member/findLoginPw")
				.excludePathPatterns("/adm/member/doFindLoginPw");

		// 로그인 필요
		registry.addInterceptor(needLoginInterceptor).addPathPatterns("/**").addPathPatterns("/usr/article/add")
				.addPathPatterns("/usr/article/doAdd").addPathPatterns("/usr/article/doDelete")
				.addPathPatterns("/usr/article/modify").addPathPatterns("/usr/article/doModify")
				.addPathPatterns("/usr/member/modify").addPathPatterns("/usr/member/doModify")
				.addPathPatterns("/usr/member/checkPassword").addPathPatterns("/usr/member/doCheckPassword")
				.excludePathPatterns("/swagger-ui/**").excludePathPatterns("/swagger-resources/**")
				.excludePathPatterns("/v2/api-docs").excludePathPatterns("/webjars/**").excludePathPatterns("/")
				.excludePathPatterns("/adm/**").excludePathPatterns("/resource/**").excludePathPatterns("/gen/**")
				.excludePathPatterns("/usr/home/**").excludePathPatterns("/usr/member/authKey")
				.excludePathPatterns("/usr/member/login").excludePathPatterns("/usr/member/doLogin")
				.excludePathPatterns("/usr/member/join").excludePathPatterns("/usr/member/doJoin")
				.excludePathPatterns("/usr/member/getLoginIdDup").excludePathPatterns("/usr/article/list")
				.excludePathPatterns("/usr/article/detail").excludePathPatterns("/usr/member/findLoginId")
				.excludePathPatterns("/usr/member/doFindLoginId").excludePathPatterns("/usr/member/findLoginPw")
				.excludePathPatterns("/usr/member/doFindLoginPw").excludePathPatterns("/usr/member/doConfirmPassword")
				.excludePathPatterns("/usr/product/list").excludePathPatterns("/usr/product/detail")
				.excludePathPatterns("/usr/reply/reviewList").excludePathPatterns("/usr/file/test*")
				.excludePathPatterns("/usr/file/doTest*").excludePathPatterns("/test/**").excludePathPatterns("/error");

		// 로그인 상태에서 접속할 수 없는 URI 전부 기술
		registry.addInterceptor(needLogoutInterceptor).addPathPatterns("/adm/member/login")
				.addPathPatterns("/adm/member/doLogin").addPathPatterns("/adm/member/join")
				.addPathPatterns("/adm/member/doJoin").addPathPatterns("/adm/member/findLoginId")
				.addPathPatterns("/adm/member/doFindLoginId").addPathPatterns("/adm/member/findLoginPw")
				.addPathPatterns("/adm/member/doFindLoginPw").addPathPatterns("/usr/member/login")
				.addPathPatterns("/usr/member/doLogin").addPathPatterns("/usr/member/join")
				.addPathPatterns("/usr/member/doJoin").addPathPatterns("/usr/member/findLoginId")
				.addPathPatterns("/usr/member/doFindLoginId").addPathPatterns("/usr/member/findLoginPw")
				.addPathPatterns("/usr/member/doFindLoginPw");
	}

	@Override
	// gen을 통해서 들어오면
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/gen/**").addResourceLocations("file:///" + genFileDirPath + "/")
				.setCachePeriod(20);
	}
}
