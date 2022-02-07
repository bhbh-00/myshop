package com.bh.myshop.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bh.myshop.dao.CategoryDao;
import com.bh.myshop.dto.Category;
import com.bh.myshop.dto.Member;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.util.Util;

@Service
public class CategoryService {
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private MemberService memberService;

	// 카테고리 리스트
	public List<Category> getForPrintcategorys(String searchKeywordType, String searchKeyword, int page,
			int itemsInAPage) {
		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		List<Category> categorys = categoryDao.getForPrintcategorys(searchKeywordType, searchKeyword, limitStart,
				limitTake);

		return categorys;
	}

	// 카테고리의 총 갯수
	public int getcategorysTotleCount(String searchKeywordType, String searchKeyword) {
		return categoryDao.getcategorysTotleCount(searchKeywordType, searchKeyword);
	}

	public Category getForPrintcategory(int id) {
		return categoryDao.getForPrintcategory(id);
	}

	// 카테고리 생성
	public ResultData doAdd(Map<String, Object> param) {
		categoryDao.add(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "게시물이 추가되었습니다.", "id", id);
	}

	// 기존의 이름 확인
	public Category getcategoryByName(String name) {
		return categoryDao.getcategoryByName(name);
	}

	// 기존의 코드 확인
	public Category getcategoryByCode(String code) {
		return categoryDao.getcategoryByCode(code);
	}

	// 수정 권한 확인
	public ResultData getActorCanModifyRd(Category category, Member actor) {
		if (category.getMemberId() == actor.getId()) {
			return new ResultData("S-1", "가능합니다.");
		}

		if (memberService.isAdmin(actor)) {
			return new ResultData("S-2", "가능합니다.");
		}

		return new ResultData("F-1", "권한이 없습니다.");
	}

	// 카테고리 수정
	public ResultData modify(Map<String, Object> param) {
		categoryDao.modify(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "수정 완료되었습니다.", "id", id);
	}

	// 카테고리 삭제
	public ResultData delete(int id) {
		categoryDao.delete(id);

		return new ResultData("s-1", "삭제되었습니다.", "id", id);
	}

	// 삭제 권한 확인
	public ResultData getActorCanDeleteRd(Category category, Member actor) {
		return getActorCanModifyRd(category, actor);
	}

	// 카테고리 번호 확인
	public Category getcategory(int id) {
		return categoryDao.getcategory(id);
	}

}
