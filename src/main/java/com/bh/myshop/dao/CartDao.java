package com.bh.myshop.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.bh.myshop.dto.Cart;

@Mapper
public interface CartDao {

	void delete(Map<String, Object> param);

	void add(Map<String, Object> param);

	Cart getCart(String relTypeCode, Integer relId);

}
