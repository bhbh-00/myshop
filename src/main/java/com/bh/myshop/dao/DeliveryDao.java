package com.bh.myshop.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.bh.myshop.dto.ResultData;

@Mapper
public interface DeliveryDao {

	ResultData doAdd(Map<String, Object> param);

}
