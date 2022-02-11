package com.bh.myshop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bh.myshop.dto.Category;
import com.bh.myshop.dto.Order;

@Mapper
public interface OrderDao {

	// interface에서는 public 필요없음!

	// 주문 수정
	void modify(Map<String, Object> param);

	// 주문 삭제
	void delete(@Param("id") Integer id);

	Order getorder(@Param("id") Integer id);

	// 주문 등록
	void add(Map<String, Object> param);

	List<Order> getorders(@Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword);

	// 주문 상세페이지
	Order getForPrintorder(@Param("id") Integer id);

	List<Order> getForPrintorders(@Param("categoryId") int categoryId,
			@Param("searchKeywordType") String searchKeywordType, @Param("searchKeyword") String searchKeyword,
			@Param("limitStart") int limitStart, @Param("limitTake") int limitTake);

	int getordersTotleCount(@Param("categoryId") int categoryId, @Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword);

	List<Order> getForPrintorderByMemberId(@Param("id") int id);

	int getordersTotleCountByMyList(@Param("id") int id, @Param("categoryId") int categoryId,
			@Param("searchKeywordType") String searchKeywordType, @Param("searchKeyword") String searchKeyword);

	Order getorderByReply(@Param("id") Integer id);

	Category getCategory(int categoryId);
	
	// 기존의 상픔명 확인
	Order getorderByName(@Param("name") String name);

}
