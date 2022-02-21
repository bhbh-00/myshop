package com.bh.myshop.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bh.myshop.dao.DeliveryDao;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.util.Util;

@Service
public class DeliveryService {
	@Autowired
	private DeliveryDao deliveryDao;
	
	// 배송정보 등록
	public ResultData doAdd(Map<String, Object> param) {
		deliveryDao.add(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "배송정보가 등록 되었습니다.", "id", id);
	}

}
