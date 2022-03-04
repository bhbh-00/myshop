package com.bh.myshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bh.myshop.dto.Article;
import com.bh.myshop.dto.Board;
import com.bh.myshop.dto.GenFile;
import com.bh.myshop.dto.Like;
import com.bh.myshop.dto.Member;
import com.bh.myshop.dto.Reply;
import com.bh.myshop.service.ArticleService;
import com.bh.myshop.service.GenFileService;
import com.bh.myshop.service.LikeService;
import com.bh.myshop.service.ReplyService;

@Controller
public class UsrArticleController extends BaseController {
	@Autowired
	private ArticleService articleService;

	@Autowired
	private GenFileService genFileService;

	@Autowired
	private LikeService likeService;

	@Autowired
	private ReplyService replyService;
		
	// 게시물 상세 페이지
	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, Integer id) {

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		if (id == null) {
			return msgAndBack(req, "게시물 번호를 입력해주세요.");
		}

		Article article = articleService.getForPrintArticle(id);

		if (article == null) {
			return msgAndBack(req, "해당 게시물은 존재하지 않습니다.");
		}

		List<GenFile> files = genFileService.getGenFiles("article", article.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}
		
		// 좋아요
		Like like = likeService.getLike("article", article.getId());
		
		// 좋아요 갯수
		int totleItemsCountByLike = likeService.getLikeTotleCount("article", article.getId());
		
		// 댓글 리스트
		List<Reply> replys = replyService.getForPrintReplies("article", article.getId());

		article.getExtraNotNull().put("file__common__attachment", filesMap);
		req.setAttribute("article", article);
		req.setAttribute("replys", replys);
		req.setAttribute("like", like);
		req.setAttribute("totleItemsCountByLike", totleItemsCountByLike);
		req.setAttribute("loginedMember", loginedMember);

		return "/usr/article/detail";
	}

	// 내 게시물 보기
	@RequestMapping("/usr/article/myList")
	public String showMyList(HttpServletRequest req, @RequestParam(defaultValue = "1") int boardId,
			String searchKeywordType, String searchKeyword, @RequestParam(defaultValue = "1") int page) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		Board board = articleService.getBoard(boardId);

		req.setAttribute("board", board);

		if (board == null) {
			return msgAndBack(req, "해당 게시물은 존재하지 않습니다.");
		}

		List<Article> articles = articleService.getForPrintArticleByMemberId(loginMemberId);

		// 한 페이지에 포함 되는 게시물의 갯수
		int itemsInAPage = 20;

		// 총 게시물의 갯수를 구하는
		int totleItemsCount = articleService.getArticlesTotleCountByMyList(loginMemberId, boardId, searchKeywordType,
				searchKeyword);

		articles = articleService.getForPrintArticlesByMyList(loginMemberId, boardId, searchKeywordType, searchKeyword,
				page, itemsInAPage);

		// 총 페이지 갯수 (총 게시물 수 / 한 페이지 안의 게시물 갯수)
		int totlePage = (int) Math.ceil(totleItemsCount / (double) itemsInAPage);

		int pageMenuArmSize = 5;

		// 시작 페이지 번호
		int pageMenuStrat = page - pageMenuArmSize;

		// 시작 페이지가 1보다 작다면 시작 페이지는 1
		if (pageMenuStrat < 1) {
			pageMenuStrat = 1;
		}

		// 끝 페이지 페이지 번호
		int pageMenuEnd = page + pageMenuArmSize;

		if (pageMenuEnd > totlePage) {
			pageMenuEnd = totlePage;
		}

		// req.setAttribute( "" , ) -> 이게 있어야지 jsp에서 뜸!
		req.setAttribute("totleItemsCount", totleItemsCount);
		req.setAttribute("totlePage", totlePage);
		req.setAttribute("pageMenuArmSize", pageMenuArmSize);
		req.setAttribute("pageMenuStrat", pageMenuStrat);
		req.setAttribute("pageMenuEnd", pageMenuEnd);
		req.setAttribute("page", page);
		req.setAttribute("articles", articles);

		return "/usr/article/myList";
	}

	// 게시물 리스트
	@RequestMapping("/usr/article/list")
	public String showList(HttpServletRequest req, @RequestParam(defaultValue = "1") int boardId,
			String searchKeywordType, String searchKeyword, @RequestParam(defaultValue = "1") int page) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		Board board = articleService.getBoard(boardId);

		req.setAttribute("board", board);

		if (board == null) {
			return msgAndBack(req, "해당 게시물은 존재하지 않습니다.");
		}

		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "titleAndBody";
		}

		if (searchKeyword != null && searchKeyword.length() == 0) {
			searchKeyword = null;
		}

		if (searchKeyword != null) {
			searchKeyword = searchKeyword.trim();
		}

		if (searchKeyword == null) {
			searchKeywordType = null;
		}

		// 한 페이지에 포함 되는 게시물의 갯수
		int itemsInAPage = 20;

		// 총 게시물의 갯수를 구하는
		int totleItemsCount = articleService.getArticlesTotleCount(boardId, searchKeywordType, searchKeyword);

		List<Article> articles = articleService.getForPrintArticles(boardId, searchKeywordType, searchKeyword, page,
				itemsInAPage);

		// 총 페이지 갯수 (총 게시물 수 / 한 페이지 안의 게시물 갯수)
		int totlePage = (int) Math.ceil(totleItemsCount / (double) itemsInAPage);
		int pageMenuArmSize = 5;

		// 시작 페이지 번호
		int pageMenuStrat = page - pageMenuArmSize;

		// 시작 페이지가 1보다 작다면 시작 페이지는 1
		if (pageMenuStrat < 1) {
			pageMenuStrat = 1;
		}

		// 끝 페이지 페이지 번호
		int pageMenuEnd = page + pageMenuArmSize;

		if (pageMenuEnd > totlePage) {
			pageMenuEnd = totlePage;
		}

		req.setAttribute("totleItemsCount", totleItemsCount);
		req.setAttribute("totlePage", totlePage);
		req.setAttribute("pageMenuArmSize", pageMenuArmSize);
		req.setAttribute("pageMenuStrat", pageMenuStrat);
		req.setAttribute("pageMenuEnd", pageMenuEnd);
		req.setAttribute("page", page);
		req.setAttribute("articles", articles);
		req.setAttribute("loginMemberId", loginMemberId);

		return "/usr/article/list";
	}

}
