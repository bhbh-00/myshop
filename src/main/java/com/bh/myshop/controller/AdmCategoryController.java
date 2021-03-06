package com.bh.myshop.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bh.myshop.dto.Category;
import com.bh.myshop.dto.Member;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.service.CategoryService;
import com.bh.myshop.util.Util;

@Controller
public class AdmCategoryController extends BaseController {
	@Autowired
	private CategoryService categoryService;

	// 카테고리 삭제
	@RequestMapping("/adm/category/doDelete")
	@ResponseBody
	public String doDelete(int id, HttpServletRequest req) {

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		if (id == 0) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		Category category = categoryService.getCategory(id);

		if (category == null) {
			return msgAndBack(req, "해당 카테고리는 존재하지 않습니다.");
		}

		ResultData actorCanDeleteRd = categoryService.getActorCanDeleteRd(category, loginedMember);

		if (actorCanDeleteRd.isFail()) {
			return Util.msgAndBack(actorCanDeleteRd.getMsg());
		}

		ResultData deleteCategoryRd = categoryService.delete(id);

		String redirectUrl = "../category/list";

		return Util.msgAndReplace(deleteCategoryRd.getMsg(), redirectUrl);
	}

	// 카테고리 이름 중복 확인
	@RequestMapping("/adm/category/getNameDup")
	@ResponseBody
	public ResultData getNameDup(String categoryName) {

		if (categoryName == null) {
			return new ResultData("F-1", "이름을 입력해주세요.");
		}

		Category existingCategory = categoryService.getCategoryByName(categoryName);

		if (existingCategory != null) {
			return new ResultData("F-2", String.format("%s(은)는 이미 사용중인 이름 입니다.", categoryName));
		}

		return new ResultData("S-1", String.format("%s(은)는 사용가능한 이름 입니다.", categoryName), "categoryName", categoryName);
	}

	// 카테고리 코드 중복 확인
	@RequestMapping("/adm/category/getCodeDup")
	@ResponseBody
	public ResultData getCodeDup(String code) {

		if (code == null) {
			return new ResultData("F-1", "코드를 입력해주세요.");
		}

		// 기존의 코드 확인
		Category existingcategory = categoryService.getCategoryByCode(code);

		if (existingcategory != null) {
			return new ResultData("F-2", String.format("%s(은)는 이미 사용중인 코드 입니다.", code));
		}

		if (Util.isStandardCategoryCodeString(code) == false) {
			return new ResultData("F-1", "숫자로 구성되어야 합니다.");
		}

		return new ResultData("S-1", String.format("%s(은)는 사용가능한 코드 입니다.", code), "code", code);
	}

	// 카테고리 수정
	@RequestMapping("/adm/category/modify")
	public String ShowModify(Integer id, HttpServletRequest req) {

		if (id == null) {
			return msgAndBack(req, "카테고리 번호를 입력해주세요.");
		}

		Category category = categoryService.getForPrintCategory(id);

		if (category == null) {
			return msgAndBack(req, "해당 카테고리은 존재하지 않습니다.");
		}

		req.setAttribute("category", category);

		return "/adm/category/modify";
	}

	// 카테고리 수정
	@RequestMapping("/adm/category/doModify")
	@ResponseBody
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req) {

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		int id = Util.getAsInt(param.get("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "번호를 입력해주세요.");
		}

		if (Util.isEmpty(param.get("categoryName"))) {
			return msgAndBack(req, "이름을 입력해주세요.");
		}

		Category category = categoryService.getCategory(id);

		if (category == null) {
			return msgAndBack(req, "해당 카테고리은 존재하지 않습니다.");
		}

		ResultData actorCanModifyRd = categoryService.getActorCanModifyRd(category, loginedMember);

		if (actorCanModifyRd.isFail()) {
			return Util.msgAndBack(actorCanModifyRd.getMsg());
		}

		ResultData modifycategoryRd = categoryService.modify(param);
		String redirectUrl = "../category/list";

		return Util.msgAndReplace(modifycategoryRd.getMsg(), redirectUrl);
	}

	@RequestMapping("/adm/category/add")
	public String ShowAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		return "/adm/category/add";
	}

	// 카테고리 작성
	@RequestMapping("/adm/category/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {

		Member loginedMember = (Member) req.getAttribute("loginedMember");

		if (param.get("code") == null) {
			return msgAndBack(req, "코드를 입력해주세요");
		}

		if (param.get("categoryName") == null) {
			return msgAndBack(req, "이름을 입력해주세요");
		}

		// 기존의 이름 확인
		Category existingcategory = categoryService.getCategoryByName((String) param.get("categoryName"));

		if (existingcategory != null) {
			return msgAndBack(req, String.format("「 %s 」은 이미 등록되어 있습니다.", existingcategory.getCategoryName()));
		}

		param.put("loginedMember", loginedMember);

		ResultData addcategoryRd = categoryService.doAdd(param);

		int newcategoryId = (int) addcategoryRd.getBody().get("id");

		return msgAndReplace(req, String.format("%s번 카테고리이 생성되었습니다.", newcategoryId), "../category/list");
	}

	// 카테고리 리스트
	@RequestMapping("/adm/category/list")
	public String showList(HttpServletRequest req, String searchKeywordType, String searchKeyword,
			@RequestParam(defaultValue = "1") int page) {

		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "codeAndCategoryName";
		}

		if (searchKeyword != null && searchKeyword.length() == 0) {
			searchKeyword = null;
		}

		if (searchKeyword != null) {
			searchKeyword = searchKeyword.trim();
		}

		if (searchKeyword == null) {
			searchKeywordType = null;
		}

		// 한 페이지에 포함 되는 카테고리의 갯수
		int itemsInAPage = 10;

		// 총 카테고리의 갯수를 구하는
		int totleItemsCount = categoryService.getCategorysTotleCount(searchKeywordType, searchKeyword);

		List<Category> categorys = categoryService.getForPrintCategorys(searchKeywordType, searchKeyword, page,
				itemsInAPage);

		// 총 페이지 갯수 (총 카테고리 수 / 한 페이지 안의 카테고리 갯수)
		int totlePage = (int) Math.ceil(totleItemsCount / (double) itemsInAPage);

		// 페이징의 반지름
		int pageMenuArmSize = 5;

		// 시작 페이지 번호
		int pageMenuStrat = page - pageMenuArmSize;

		// 시작 페이지가 1보다 작다면 시작 페이지는 1
		if (pageMenuStrat < 1) {
			pageMenuStrat = 1;
		}

		// 끝 페이지 페이지 번호
		int pageMenuEnd = page + pageMenuArmSize;

		if (pageMenuEnd > totlePage) {
			pageMenuEnd = totlePage;
		}

		req.setAttribute("totleItemsCount", totleItemsCount);
		req.setAttribute("totlePage", totlePage);
		req.setAttribute("pageMenuArmSize", pageMenuArmSize);
		req.setAttribute("pageMenuStrat", pageMenuStrat);
		req.setAttribute("pageMenuEnd", pageMenuEnd);
		req.setAttribute("page", page);
		req.setAttribute("categorys", categorys);

		return "adm/category/list";
	}

}
