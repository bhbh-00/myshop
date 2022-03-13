package com.bh.myshop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bh.myshop.dto.Product;
import com.bh.myshop.dto.Reply;

@Mapper
public interface ReplyDao {

	// 댓글 작성
	void doAdd(Map<String, Object> param);

	// 댓글 리스트
	List<Reply> getForPrintReplies(@Param("relTypeCode") String relTypeCode, @Param("relId") int relId);

	// 댓글 확인
	Reply getReply(@Param("id") Integer id);

	// 상품 번호 확인
	Product getProductId(int relId);

	// 리뷰 수정
	void modify(@Param("id") Integer id, @Param("body") String body);
	
	// 리뷰 확인
	Reply getReview(@Param("id") Integer id);

	// 리뷰 삭제
	void delete(@Param("id") Integer id);

	// 리뷰 리스트
	List<Reply> getForPrintReviews(@Param("productId") int productId,
			@Param("searchKeywordType") String searchKeywordType, @Param("searchKeyword") String searchKeyword,
			@Param("limitStart") int limitStart, @Param("limitTake") int limitTake);

	// 리뷰 총 갯수
	int getReviewsTotleCount(@Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword);

	// 리뷰 보기
	Reply getForPrintReview(@Param("id") Integer id);

	// 리뷰 작성
	void addReview(Map<String, Object> param);

	// 상품 확인
	Product getProduct(int relId);

}
