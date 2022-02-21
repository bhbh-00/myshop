package com.bh.myshop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bh.myshop.dto.Order;
import com.bh.myshop.dto.Product;

@Mapper
public interface OrderDao {

	// 주문하기
	void add(Map<String, Object> param);
	
	// 제품번호로 주문한 제품 불러오기
	Product getForPrintOrderProduct(@Param("id") Integer id);
	
	// 주문번호로 주문내역 불러오기
	Order getForPrintOrderHistory(@Param("id") Integer id);

	// 회원번호로 주문내역 불러오기
	List<Order> getForPrintOrdersByMemberId(@Param("id") int id);
	
	// 내 주문내역 불러오기
	List<Order> getForPrintOrdersByMyList(@Param("id") int id, @Param("limitStart") int limitStart,
			@Param("limitTake") int limitTake);
	
	// 내 주문내역의 총 갯수
	int getOrdersTotleCountByMyList(@Param("id")  int id);
	
	// 제품 보기
	Product getForPrintProduct(@Param("productId") Integer productId);

}

