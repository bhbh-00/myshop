package com.bh.myshop.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.bh.myshop.dao.LikeDao;
import com.bh.myshop.dto.Like;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.util.Util;

@Service
public class LikeService {
	@Autowired
	private LikeDao likeDao;

	// 좋아요
	public ResultData doLike(@RequestParam Map<String, Object> param) {
		likeDao.doLike(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "좋아요", "id", id);
	}

	// 좋아요 갯수
	public Like getLikeTotleCount(int id) {
		return likeDao.getLikeTotleCount(id);
	}

	// 해당 게시물의 좋아요
	public Like getLikeByArticle(Integer id) {
		return likeDao.getLikeByArticle(id);
	}

	// 해당 게시물의 좋아요 갯수
	public int getLikeTotleCountByArticle(Integer id) {
		return likeDao.getLikeTotleCountByArticle(id);
	}

	public Like getLike(Integer id) {
		return likeDao.getLike(id);
	}

	public Like getLikeByMemberId(int id) {
		return likeDao.getLikeByMemberId(id);
	}

	public Like totleCountLikeByArticle() {
		return likeDao.totleCountLikeByArticle();
	}

	// 좋아요 해제
	public ResultData delete(Integer id) {
		likeDao.delete(id);

		return new ResultData("S-1", "좋아요를 해제합니다.", "id", id);
	}

	public Like getLikeByproduct(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

}
