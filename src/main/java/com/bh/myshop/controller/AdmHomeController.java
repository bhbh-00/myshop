package com.bh.myshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bh.myshop.dto.Article;
import com.bh.myshop.dto.Product;
import com.bh.myshop.service.ArticleService;
import com.bh.myshop.service.ProductService;

@Controller
public class AdmHomeController extends BaseController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ProductService productService;

	@RequestMapping("/adm/home/main")
	public String showMain(HttpServletRequest req) {

		// 오늘 업데이트된 상품보기
		List<Product> getForPrintTodayUpdatedProducts = productService.getForPrintTodayUpdatedProducts();
		req.setAttribute("getForPrintTodayUpdatedProducts", getForPrintTodayUpdatedProducts);

		// 가장 최근 업데이트된 상품보기 3개
		List<Product> getForPrintNewUpdatedProducts = productService.getForPrintNewUpdatedProducts();
		req.setAttribute("getForPrintNewUpdatedProducts", getForPrintNewUpdatedProducts);

		// 베스트 상품 3개

		// 가장 최근 공지사항 게시물 3개
		List<Article> LatestArticleByBoardNameNotice = articleService.getLatestArticleByBoardNameNotice();
		req.setAttribute("LatestArticleByBoardNameNotice", LatestArticleByBoardNameNotice);

		return "/adm/home/main";
	}
}
