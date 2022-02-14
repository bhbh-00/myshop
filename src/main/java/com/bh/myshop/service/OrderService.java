package com.bh.myshop.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bh.myshop.dao.OrderDao;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.util.Util;

@Service
public class OrderService {
	
	@Autowired
	private OrderDao orderDao;

	public ResultData doAdd(Map<String, Object> param) {
		orderDao.add(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "게시물이 추가되었습니다.", "id", id);
	}

}
