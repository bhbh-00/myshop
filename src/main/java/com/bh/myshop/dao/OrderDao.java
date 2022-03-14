package com.bh.myshop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bh.myshop.dto.Delivery;
import com.bh.myshop.dto.Order;
import com.bh.myshop.dto.Product;

@Mapper
public interface OrderDao {

	// 주문하기
	void add(Map<String, Object> param);

	// 주문내역 불러오기
	Order getForPrintOrderHistory(@Param("id") Integer id);

	// 상품 불러오기
	Product getForPrintOrderProduct(@Param("id") Integer id);

	// 배송내역 불러오기
	Delivery getForPrintOrderDelivery(@Param("id") Integer id);

	// 회원번호로 주문내역 불러오기
	List<Order> getForPrintOrdersByMemberId(@Param("loginMemberId") int loginMemberId);

	// 내 주문내역 불러오기
	List<Order> getForPrintOrdersByMyList(@Param("loginMemberId") int loginMemberId, @Param("limitStart") int limitStart,
			@Param("limitTake") int limitTake);

	// 내 주문내역의 총 갯수
	int getOrdersTotleCountByMyList(@Param("id") int id);

	// 상품 보기
	Product getForPrintProduct(@Param("productId") Integer productId);

	// 주문내역 갯수 확인
	int getOrderTotleCount(@Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword);

	// 주문내역 리스트
	List<Order> getForPrintOrders(Map<String, Object> param);

}
