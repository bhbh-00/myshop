package com.bh.myshop.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bh.myshop.dao.CartDao;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.util.Util;

@Service
public class CartService {
	@Autowired
	private CartDao cartDao;

	public ResultData delete(Map<String, Object> param) {
		return cartDao.delete(param);
	}

	public ResultData doAdd(Map<String, Object> param) {
		cartDao.doAdd(param);
		
		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "장바구니에 추가합니다.", "id", id);
	}

}
