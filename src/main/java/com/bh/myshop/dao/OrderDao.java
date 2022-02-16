package com.bh.myshop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.bh.myshop.dto.Product;

@Mapper
public interface OrderDao {

	// 주문
	void add(Map<String, Object> param);

	Product getForPrintOrderProduct(Integer productId);

}
