package com.bh.myshop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bh.myshop.dto.Cart;
import com.bh.myshop.dto.Product;

@Mapper
public interface CartDao {

	// 장바구니 취소
	void delete(Map<String, Object> param);

	// 장바구니 추가
	void add(Map<String, Object> param);

	// 장바구니 가져오기
	Cart getCart(String relTypeCode, Integer relId);

	// 내가 장바구니에 담은 제품 보여주기
	List<Product> getForPrintCartsByProduct(@Param("loginMemberId") int loginMemberId);

	// 내 번호로 장바구니 가져오기
	List<Cart> getForPrintCartsByMemberId(@Param("loginMemberId") int loginMemberId);

	// 내가 장바구니에 추가한 수
	int getCartsTotleCountByMyList(@Param("loginMemberId") int loginMemberId);

	// 내 장바구니 보여주기
	List<Cart> getForPrintCartsByMyList(@Param("loginMemberId") int loginMemberId, @Param("page") int page,
			@Param("itemsInAPage") int itemsInAPage, @Param("limitStart") int limitStart,
			@Param("limitTake") int limitTake);

}
