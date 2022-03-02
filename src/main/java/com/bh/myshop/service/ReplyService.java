package com.bh.myshop.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bh.myshop.dao.ReplyDao;
import com.bh.myshop.dto.GenFile;
import com.bh.myshop.dto.Member;
import com.bh.myshop.dto.Product;
import com.bh.myshop.dto.Reply;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.util.Util;

@Service
public class ReplyService {
	@Autowired
	private ReplyDao replyDao;
	@Autowired
	private MemberService memberService;
	@Autowired
	private GenFileService genFileService;

	// 댓글 작성
	public ResultData doAdd(Map<String, Object> param) {
		replyDao.doAdd(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "댓글이 추가되었습니다.", "id", id);
	}

	// 댓글 확인
	public Reply getReply(Integer id) {
		return replyDao.getReply(id);
	}

	// 댓글 수정
	public ResultData modify(Integer id, String body) {
		replyDao.modify(id, body);

		return new ResultData("s-1", "수정 완료되었습니다.", "id", id);
	}

	// 권한에 따른 수정 가능 여부
	public ResultData getActorCanModifyRd(Reply reply, Member actor) {
		if (reply.getMemberId() == actor.getId()) {
			return new ResultData("S-1", "가능합니다.");
		}

		if (memberService.isAdmin(actor)) {
			return new ResultData("S-2", "가능합니다.");
		}

		return new ResultData("F-1", "권한이 없습니다.");
	}

	// 권한에 따른 삭제 가능 여부
	public ResultData getActorCanDeleteRd(Reply reply, Member actor) {
		return getActorCanModifyRd(reply, actor);
	}

	// 댓글 삭제
	public ResultData delete(Integer id) {
		replyDao.delete(id);

		return new ResultData("S-1", "삭제하였습니다.", "id", id);
	}

	// 댓글 리스트
	public List<Reply> getForPrintReplies(String relTypeCode, int relId) {
		return replyDao.getForPrintReplies(relTypeCode, relId);
	}

	// 리뷰
	public ResultData doAddReview(Map<String, Object> param) {
		replyDao.addReview(param);

		int id = Util.getAsInt(param.get("id"), 0);

		// 파일 업로드 시 파일의 번호를 상품의 번호를 바꾼다.
		genFileService.changeInputFileRelIds(param, id);

		return new ResultData("s-1", "리뷰가 등록 되었습니다.", "id", id);
	}

	public int getReviewsTotleCount(String searchKeywordType, String searchKeyword) {
		return replyDao.getReviewsTotleCount(searchKeywordType, searchKeyword);
	}

	public Product getProductId(int relId) {
		return replyDao.getProductId(relId);
	}

	public List<Reply> getForPrintReviews(int productId, String searchKeywordType, String searchKeyword, int page,
			int itemsInAPage) {
		// 페이징 - 시작과 끝 범위
		int limitStart = (page - 1) * itemsInAPage;
		// controller에서 한 페이지에 포함 되는 상품의 갯수의 값을(itemsInAPage) 설정했음.
		int limitTake = itemsInAPage;
		// 한 페이지에 포함 되는 상품의 갯수의 값
		// LIMIT 20, 20 => 2page LIMIT 40, 20 => 3page

		List<Reply> reviews = replyDao.getForPrintReviews(productId, searchKeywordType, searchKeyword, limitStart, limitTake);
		List<Integer> reviewIds = reviews.stream().map(product -> product.getId()).collect(Collectors.toList());
		Map<Integer, Map<String, GenFile>> filesMap = genFileService.getFilesMapKeyRelIdAndFileNo("review", reviewIds,
				"common", "attachment");

		for (Reply review : reviews) {
			Map<String, GenFile> mapByFileNo = filesMap.get(review.getId());

			if (mapByFileNo != null) {
				review.getExtraNotNull().put("file__common__attachment", mapByFileNo);
			}
		}

		return reviews;
	}

}
