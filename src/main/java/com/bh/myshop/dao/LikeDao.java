package com.bh.myshop.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bh.myshop.dto.Like;

@Mapper
public interface LikeDao {

	// 좋아요
	void doLike(Map<String, Object> param);

	// 좋아요 갯수
	Like getLikeTotleCount(@Param("id") Integer id);
	
	// 좋아요 해제
	void delete(@Param("id") Integer id);
	
	// 좋아요 불러오기
	Like getLike(@Param("relTypeCode") String relTypeCode, @Param("relId")int relId);

}
