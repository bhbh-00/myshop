package com.bh.myshop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bh.myshop.dto.Category;

@Mapper
public interface CategoryDao {

	// 카테고리 수정
	void modify(Map<String, Object> param);

	// 카테고리 리스트
	List<Category> getForPrintCategorys(@Param("searchKeywordType") String searchKeywordType, @Param("searchKeyword") String searchKeyword,
			@Param("limitStart") int limitStart, @Param("limitTake") int limitTake);

	// 카테고리의 총 갯수
	int getCategorysTotleCount(@Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword);

	// 카테고리 번호로 정보 불러오기
	Category getForPrintCategory(@Param("id") int id);

	// 카테고리 생성
	void add(Map<String, Object> param);

	// 기존의 이름 확인
	Category getCategoryByName(@Param("categoryName") String categoryName);

	// 기존의 코드 확인
	Category getCategoryByCode(@Param("code") String code);

	// 카테고리 삭제
	void delete(@Param("id") int id);

	// 카테고리 번호 확인
	Category getCategory(@Param("id") int id);

}
