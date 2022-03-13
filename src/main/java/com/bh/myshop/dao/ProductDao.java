package com.bh.myshop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bh.myshop.dto.Category;
import com.bh.myshop.dto.Product;

@Mapper
public interface ProductDao {

	// interface에서는 public 필요없음!

	// 상품 수정
	void modify(Map<String, Object> param);

	// 상품 번호로 불러오기
	Product getForPrintproduct(@Param("id") Integer id);

	// 번호로 해당 제품 가져오기
	Product getproduct(@Param("id") Integer id);

	// 상품 삭제
	void delete(@Param("id") Integer id);

	// 상품 등록
	void add(Map<String, Object> param);

	// 기존의 상픔명 확인
	Product getProductByName(@Param("productName") String productName);

	List<Product> getproducts(@Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword);

	// 상품 리스트
	List<Product> getForPrintproducts(@Param("categoryId") int categoryId,
			@Param("searchKeywordType") String searchKeywordType, @Param("searchKeyword") String searchKeyword,
			@Param("limitStart") int limitStart, @Param("limitTake") int limitTake);

	// 상품의 총 갯수 보기
	int getproductsTotleCount(@Param("categoryId") int categoryId, @Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword);

	// 카테고리 가져오기
	Category getCategory(int categoryId);

	List<Product> getForPrintproductByMemberId(@Param("id") int id);

	int getproductsTotleCountByMyList(@Param("id") int id, @Param("categoryId") int categoryId,
			@Param("searchKeywordType") String searchKeywordType, @Param("searchKeyword") String searchKeyword);

	// 가장 최신 자유 상품 2개
	List<Product> getLatestproductByBoardNameFree();

	// 가장 최신 공지사항 상품 2개
	List<Product> getLatestproductByBoardNameNotice();

	Product getproductByReply(@Param("id") Integer id);

	// 주문할 상품 가져오기
	Product getOrderProduct(Map<String, Object> param);

	List<Category> getForPrintCategorys();

	// 가장 최근 업데이트 된 상품
	List<Product> getForPrintNewUpdatedProducts();

	// 오늘 업데이트 된 상품 보기
	List<Product> getForPrintTodayUpdatedProducts();

}
