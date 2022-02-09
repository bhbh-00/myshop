package com.bh.myshop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bh.myshop.dto.Board;
import com.bh.myshop.dto.Category;
import com.bh.myshop.dto.Product;

@Mapper
public interface ProductDao {

	// interface에서는 public 필요없음!

	// 제품 수정
	void modify(Map<String, Object> param);

	// 제품 삭제
	void delete(@Param("id") Integer id);

	Product getproduct(@Param("id") Integer id);

	// 제품 등록
	void add(Map<String, Object> param);

	List<Product> getproducts(@Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword);

	// 제품 상세페이지
	Product getForPrintproduct(@Param("id") Integer id);

	List<Product> getForPrintproducts(@Param("boardId") int boardId,
			@Param("searchKeywordType") String searchKeywordType, @Param("searchKeyword") String searchKeyword,
			@Param("limitStart") int limitStart, @Param("limitTake") int limitTake);

	int getproductsTotleCount(@Param("boardId") int boardId, @Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword);

	List<Product> getForPrintproductByMemberId(@Param("id") int id);

	List<Product> getForPrintproductsByMyList(@Param("id") int id, @Param("boardId") int boardId,
			@Param("searchKeywordType") String searchKeywordType, @Param("searchKeyword") String searchKeyword,
			@Param("limitStart") int limitStart, @Param("limitTake") int limitTake);

	int getproductsTotleCountByMyList(@Param("id") int id, @Param("boardId") int boardId,
			@Param("searchKeywordType") String searchKeywordType, @Param("searchKeyword") String searchKeyword);

	// 가장 최신 자유 제품 2개
	List<Product> getLatestproductByBoardNameFree();

	// 가장 최신 공지사항 제품 2개
	List<Product> getLatestproductByBoardNameNotice();

	Product getproductByReply(@Param("id") Integer id);

	Category getCategory(int categoryId);

}
