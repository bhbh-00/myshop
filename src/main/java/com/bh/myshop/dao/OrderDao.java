package com.bh.myshop.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderDao {

	// 주문
	void add(Map<String, Object> param);

}
