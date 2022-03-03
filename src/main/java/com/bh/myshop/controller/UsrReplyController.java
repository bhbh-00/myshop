package com.bh.myshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bh.myshop.dto.Article;
import com.bh.myshop.dto.GenFile;
import com.bh.myshop.dto.Like;
import com.bh.myshop.dto.Member;
import com.bh.myshop.dto.Product;
import com.bh.myshop.dto.Reply;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.service.ArticleService;
import com.bh.myshop.service.GenFileService;
import com.bh.myshop.service.LikeService;
import com.bh.myshop.service.ProductService;
import com.bh.myshop.service.ReplyService;
import com.bh.myshop.util.Util;

@Controller
public class UsrReplyController extends BaseController {
	@Autowired
	private ReplyService replyService;
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ProductService productService;
	@Autowired
	private LikeService likeService;
	@Autowired
	private GenFileService genFileService;
	
	// 댓글 삭제
		@RequestMapping("/usr/reply/doDeleteReview")
		@ResponseBody
		public String doDeleteReview(Integer id, HttpServletRequest req, String redirectUrl) {

			Member loginedMember = (Member) req.getAttribute("loginedMember");

			Reply review = replyService.getReview(id);

			if (review == null) {
				return msgAndBack(req, "해당 리뷰은 존재하지 않습니다.");
			}

			ResultData actorCanDeleteRd = replyService.getActorCanDeleteRd(review, loginedMember);

			if (actorCanDeleteRd.isFail()) {
				return msgAndBack(req, actorCanDeleteRd.getMsg());
			}

			ResultData deleteReplyRd = replyService.delete(id);

			return Util.msgAndReplace(deleteReplyRd.getMsg(), "../reply/reviewList?productId=" + review.getRelId());
		}


	// 댓글 수정
	@RequestMapping("/usr/reply/modifyReview")
	public String ShowModifyReview(Integer id, int productId, HttpServletRequest req) {

		Product product = replyService.getProductId(productId);

		if (id == null) {
			return msgAndBack(req, "리뷰 번호를 입력해주세요.");
		}

		Reply review = replyService.getReview(id);

		if (review == null) {
			return msgAndBack(req, "해당 리뷰은 존재하지 않습니다.");
		}
		
		List<GenFile> files = genFileService.getGenFiles("review", review.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		review.getExtraNotNull().put("file__common__attachment", filesMap);
		req.setAttribute("review", review);
		req.setAttribute("product", product);

		return "/usr/reply/modifyReview";
	}

	// 댓글 수정
	@RequestMapping("/usr/reply/doModifyReview")
	@ResponseBody
	public String doModifyReview(Integer id, String body, HttpServletRequest req, String redirectUrl) {

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		Reply review = replyService.getReview(id);

		if (review == null) {
			return msgAndBack(req, "해당 댓글은 존재하지 않습니다.");
		}

		ResultData actorCanDeleteRd = replyService.getActorCanModifyRd(review, loginedMember);

		if (actorCanDeleteRd.isFail()) {
			return msgAndBack(req, actorCanDeleteRd.getMsg());
		}

		ResultData modifyReplyRd = replyService.modify(id, body);

		return Util.msgAndReplace(modifyReplyRd.getMsg(), redirectUrl);
	}

	// 리뷰 상세보기
	@RequestMapping("/usr/reply/review")
	public String showReview(HttpServletRequest req, Integer id) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (id == null) {
			return msgAndBack(req, "게시물 번호를 입력해주세요.");
		}

		Reply review = replyService.getForPrintReview(id);

		if (review == null) {
			return msgAndBack(req, "해당 게시물은 존재하지 않습니다.");
		}

		List<GenFile> files = genFileService.getGenFiles("review", review.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		Like like = likeService.getLike("review", review.getId());

		int totleItemsCountByLike = likeService.getLikeTotleCount("review", review.getId());

		review.getExtraNotNull().put("file__common__attachment", filesMap);
		req.setAttribute("review", review);
		req.setAttribute("like", like);
		req.setAttribute("totleItemsCountByLike", totleItemsCountByLike);
		req.setAttribute("loginMemberId", loginMemberId);

		return "/usr/reply/review";
	}

	// 리뷰 리스트
	@RequestMapping("/usr/reply/reviewList")
	public String showReviewList(HttpServletRequest req, @RequestParam int productId, String searchKeywordType,
			String searchKeyword, @RequestParam(defaultValue = "1") int page) {
		
		Product product = replyService.getProductId(productId);

		req.setAttribute("product", product);

		if (product == null) {
			return msgAndBack(req, "해당 상품은 존재하지 않습니다.");
		}

		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "productNameAndBodyAndColor";
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

		// 한 페이지에 포함 되는 상품의 갯수
		int itemsInAPage = 30;

		// 총 상품의 갯수를 구하는
		int totleItemsCount = replyService.getReviewsTotleCount(searchKeywordType, searchKeyword);

		List<Reply> reviews = replyService.getForPrintReviews(product.getId(), searchKeywordType, searchKeyword, page,
				itemsInAPage);

		// 총 페이지 갯수 (총 상품 수 / 한 페이지 안의 상품 갯수)
		int totlePage = (int) Math.ceil(totleItemsCount / (double) itemsInAPage);

		/*
		 * 반지름이라고 생각하면 됌. 현재 페이지가 10일 때 pageMenuArmSize가 5이면 10을 기준으로 왼쪽은 4 5 6 7 8 9 10
		 * 오른쪽은 10 11 12 13 14 15 16 페이지네이션의 총 갯수는 11 (기준인 10도 포함 해야함)
		 */
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
		req.setAttribute("reviews", reviews);
		req.setAttribute("product", product);

		return "/usr/reply/reviewList";
	}

	@RequestMapping("/usr/reply/addReview")
	public String ShowAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		return "/usr/reply/addReview";

	}

	// 리뷰 작성
	@RequestMapping("/usr/reply/doAddReview")
	@ResponseBody
	public String doAddReview(@RequestParam Map<String, Object> param, HttpServletRequest req, String redirectUrl) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("relTypeCode") == "product") {
			Product product = productService.getproduct((int) param.get("relId"));

			if (product == null) {
				return msgAndBack(req, "해당 상품은 존재하지 않습니다.");
			}

			if (param.get("relTypeCode") == null) {
				return msgAndBack(req, "relTypeCode를 입력해주세요.");
			}

		}

		if (param.get("body") == null) {
			return msgAndBack(req, "리뷰를 입력해주세요.");
		}

		param.put("memberId", loginMemberId);

		ResultData doAddReviewRd = replyService.doAddReview(param);

		return Util.msgAndReplace(doAddReviewRd.getMsg(), redirectUrl);
	}

	// ================================================================= 댓글
	// 댓글 삭제
	@RequestMapping("/usr/reply/doDelete")
	@ResponseBody
	public String doDelete(Integer id, HttpServletRequest req, String redirectUrl) {

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		Reply reply = replyService.getReply(id);

		if (reply == null) {
			return msgAndBack(req, "해당 댓글은 존재하지 않습니다.");
		}

		ResultData actorCanDeleteRd = replyService.getActorCanDeleteRd(reply, loginedMember);
		// articleService 말고 이제는 reply서비스에게!

		if (actorCanDeleteRd.isFail()) {
			return msgAndBack(req, actorCanDeleteRd.getMsg());
		}

		ResultData deleteReplyRd = replyService.delete(id);

		return Util.msgAndReplace(deleteReplyRd.getMsg(), "../article/detail?id=" + reply.getRelId());
	}

	// 댓글 수정
	@RequestMapping("/usr/reply/modify")
	public String ShowModify(Integer id, HttpServletRequest req) {

		Article article = articleService.getArticleByReply(id);

		if (id == null) {
			return msgAndBack(req, "댓글 번호를 입력해주세요.");
		}

		Reply reply = replyService.getReply(id);

		if (reply == null) {
			return msgAndBack(req, "해당 댓글은 존재하지 않습니다.");
		}

		req.setAttribute("reply", reply);
		req.setAttribute("article", article);

		return "/usr/reply/modify";
	}

	// 댓글 수정
	@RequestMapping("/usr/reply/doModify")
	@ResponseBody
	public String doModify(Integer id, String body, HttpServletRequest req, String redirectUrl) {

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		Reply reply = replyService.getReply(id);

		if (reply == null) {
			return msgAndBack(req, "해당 댓글은 존재하지 않습니다.");
		}

		ResultData actorCanDeleteRd = replyService.getActorCanModifyRd(reply, loginedMember);

		if (actorCanDeleteRd.isFail()) {
			return msgAndBack(req, actorCanDeleteRd.getMsg());
		}

		ResultData modifyReplyRd = replyService.modify(id, body);

		return Util.msgAndReplace(modifyReplyRd.getMsg(), redirectUrl);
	}

	// 댓글 작성
	@RequestMapping("/usr/reply/doAdd")
	@ResponseBody
	public String doReply(@RequestParam Map<String, Object> param, HttpServletRequest req, String redirectUrl) {

		if (param.get("relTypeCode") == "article") {
			Article article = articleService.getArticle((int) param.get("relId"));

			if (article == null) {
				return msgAndBack(req, "해당 게시물은 존재하지 않습니다.");
			}

			if (param.get("relTypeCode") == null) {
				return msgAndBack(req, "relTypeCode를 입력해주세요.");
			}

		}

		if (param.get("body") == null) {
			return msgAndBack(req, "댓글을 입력해주세요.");
		}

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		req.setAttribute("loginedMember", loginedMember);

		ResultData doAddRd = replyService.doAdd(param);

		return Util.msgAndReplace(doAddRd.getMsg(), redirectUrl);
	}
}
