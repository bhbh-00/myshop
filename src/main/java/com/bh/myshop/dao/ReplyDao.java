package com.bh.myshop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bh.myshop.dto.Reply;

@Mapper
public interface ReplyDao {

	// 댓글 작성
	void doAdd(Map<String, Object> param);

	// 댓글 확인
	Reply getReply(@Param("id") Integer id);

	// 댓글 수정
	void modify(@Param("id") Integer id, @Param("body") String body);

	// 댓글 삭제
	void delete(@Param("id") Integer id);
	
	// 댓글 리스트
	List<Reply> getForPrintReplies(@Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword, @Param("limitStart") int limitStart,
			@Param("limitTake") int limitTake);
	
	// 댓글 총 갯수
	int getReplysTotleCount(@Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword);

}
