package com.bh.myshop.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.bh.myshop.dao.OrderDao;
import com.bh.myshop.dto.Delivery;
import com.bh.myshop.dto.Order;
import com.bh.myshop.dto.Product;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.util.Util;

@Service
public class OrderService {

	@Autowired
	private OrderDao orderDao;

	// 주문하기
	public ResultData doAdd(Map<String, Object> param) {
		orderDao.add(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "주문이 완료되었습니다.", "id", id);
	}

	// 제품번호로 주문한 제품 불러오기
	public Product getForPrintOrderProduct(Integer id) {
		return orderDao.getForPrintOrderProduct(id);
	}

	// 회원번호로 주문내역 불러오기
	public List<Order> getForPrintOrdersByMemberId(int loginMemberId) {
		return orderDao.getForPrintOrdersByMemberId(loginMemberId);
	}

	// 내 주문내역 불러오기
	public List<Order> getForPrintOrdersByMyList(int loginMemberId, int page, int itemsInAPage) {
		// 페이징 - 시작과 끝 범위
		int limitStart = (page - 1) * itemsInAPage;
		// controller에서 한 페이지에 포함 되는 게시물의 갯수의 값을(itemsInAPage) 설정했음.
		int limitTake = itemsInAPage;
		// 한 페이지에 포함 되는 게시물의 갯수의 값
		// LIMIT 20, 20 => 2page LIMIT 40, 20 => 3page

		List<Order> orders = orderDao.getForPrintOrdersByMyList(loginMemberId, limitStart, limitTake);

		return orders;
	}

	// 내 주문내역의 총 갯수
	public int getOrdersTotleCountByMyList(int loginMemberId) {
		return orderDao.getOrdersTotleCountByMyList(loginMemberId);
	}

	// 주문내역 불러오기
	public Order getForPrintOrderHistory(Integer id) {
		return orderDao.getForPrintOrderHistory(id);
	}

	// 상품 불러오기
	public Product getForPrintProduct(Integer productId) {
		return orderDao.getForPrintProduct(productId);
	}

	// 배송정보 불러오기
	public Delivery getForPrintOrderDelivery(Integer id) {
		return orderDao.getForPrintOrderDelivery(id);
	}
	
	// 주문내역 갯수 확인
	public int getOrderTotleCount(String searchKeywordType, String searchKeyword) {
		return orderDao.getOrderTotleCount(searchKeywordType, searchKeyword);
	}
	
	// 주문내역 리스트
	public List<Order> getForPrintOrders(String searchKeywordType, String searchKeyword, int page, 
			int itemsInAPage, @RequestParam Map<String, Object> param) {
		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		param.put("searchKeywordType", searchKeywordType);
		param.put("searchKeyword", searchKeyword);
		param.put("page", page);
		param.put("itemsInAPage", itemsInAPage);

		return orderDao.getForPrintOrders(param);
	}

}
