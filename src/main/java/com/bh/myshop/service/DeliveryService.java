package com.bh.myshop.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bh.myshop.dao.DeliveryDao;
import com.bh.myshop.dto.ResultData;

@Service
public class DeliveryService {
	@Autowired
	private DeliveryDao deliveryDao;

	public ResultData doAdd(Map<String, Object> param) {
		return deliveryDao.doAdd(param);
	}

}
