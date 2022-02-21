package com.bh.myshop.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DeliveryDao {
	
	// 배송정보 등록
	void add(Map<String, Object> param);

}
