package com.bh.myshop.dao;

import java.util.Map;

import com.bh.myshop.dto.ResultData;

public interface CartDao {

	ResultData delete(Map<String, Object> param);

	ResultData doAdd(Map<String, Object> param);

}
