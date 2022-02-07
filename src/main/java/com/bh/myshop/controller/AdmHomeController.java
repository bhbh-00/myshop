package com.bh.myshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bh.myshop.dto.Article;
import com.bh.myshop.service.ArticleService;

@Controller
public class AdmHomeController extends BaseController {
	@Autowired
	private ArticleService articleService;

	@RequestMapping("/adm/home/main")
	public String showMain(HttpServletRequest req) {

		// 가장 최신 자유 게시물 1개
		List<Article> LatestArticleByBoardNameFree = articleService.getLatestArticleByBoardNameFree();

		// 가장 최신 공지사항 게시물 1개
		List<Article> LatestArticleByBoardNameNotice = articleService.getLatestArticleByBoardNameNotice();

		req.setAttribute("LatestArticleByBoardNameFree", LatestArticleByBoardNameFree);
		req.setAttribute("LatestArticleByBoardNameNotice", LatestArticleByBoardNameNotice);

		return "/adm/home/main";
	}
}
