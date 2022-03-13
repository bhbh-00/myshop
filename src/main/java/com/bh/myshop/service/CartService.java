package com.bh.myshop.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bh.myshop.dao.CartDao;
import com.bh.myshop.dto.Cart;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.util.Util;

@Service
public class CartService {
	@Autowired
	private CartDao cartDao;
	
	// 장바구니 취소
	public ResultData delete(Map<String, Object> param) {
		cartDao.delete(param);

		return new ResultData("S-1", "장바구니를 취소합니다.");
	}
	
	// 장바구니 추가
	public ResultData doAdd(Map<String, Object> param) {
		cartDao.add(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "장바구니에 추가합니다.", "id", id);
	}
	
	// 장바구니 가져오기
	public Cart getCart(String relTypeCode, Integer relId) {
		return cartDao.getCart(relTypeCode,relId);
	}

}
