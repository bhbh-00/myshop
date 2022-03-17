package com.bh.myshop.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bh.myshop.dao.ProductDao;
import com.bh.myshop.dto.Category;
import com.bh.myshop.dto.GenFile;
import com.bh.myshop.dto.Member;
import com.bh.myshop.dto.Product;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.util.Util;

@Service
public class ProductService {
	@Autowired
	private ProductDao productDao;
	@Autowired
	private MemberService memberService;
	@Autowired
	private GenFileService genFileService;

	// 번호로 해당 제품 가져오기
	public Product getProduct(int id) {
		return productDao.getProduct(id);
	}

	// 상품 삭제 가능 권한 여부 확인
	public ResultData getActorCanDeleteRd(Product product, Member actor) {
		return getActorCanModifyRd(product, actor);
	}

	// 상품 삭제
	public ResultData delete(int id) {
		productDao.delete(id);

		// 파일 삭제
		genFileService.deleteGenFiles("product", id);

		return new ResultData("S-1", "삭제되었습니다.", "id", id);
	}

	// 기존의 상품명 확인
	public Product getProductByName(String productName) {
		return productDao.getProductByName(productName);
	}

	// 상품 작성
	public ResultData doAdd(Map<String, Object> param) {
		productDao.add(param);

		int id = Util.getAsInt(param.get("id"), 0);

		// 파일 업로드 시 파일의 번호를 상품의 번호를 바꾼다.
		genFileService.changeInputFileRelIds(param, id);

		return new ResultData("s-1", "상품이 등록되었습니다.", "id", id);
	}

	// 카테고리 가져오기
	public Category getCategory(int categoryId) {
		return productDao.getCategory(categoryId);
	}

	// 상품 리스트
	public List<Product> getForPrintProducts(int categoryId, String searchKeywordType, String searchKeyword, int page,
			int itemsInAPage) {
		// 페이징 - 시작과 끝 범위
		int limitStart = (page - 1) * itemsInAPage;
		// controller에서 한 페이지에 포함 되는 상품의 갯수의 값을(itemsInAPage) 설정했음.
		int limitTake = itemsInAPage;
		// 한 페이지에 포함 되는 상품의 갯수의 값
		// LIMIT 20, 20 => 2page LIMIT 40, 20 => 3page

		List<Product> products = productDao.getForPrintProducts(categoryId, searchKeywordType, searchKeyword,
				limitStart, limitTake);
		List<Integer> productIds = products.stream().map(product -> product.getId()).collect(Collectors.toList());
		Map<Integer, Map<String, GenFile>> filesMap = genFileService.getFilesMapKeyRelIdAndFileNo("product", productIds,
				"common", "attachment");

		for (Product product : products) {
			Map<String, GenFile> mapByFileNo = filesMap.get(product.getId());

			if (mapByFileNo != null) {
				product.getExtraNotNull().put("file__common__attachment", mapByFileNo);
			}
		}

		return products;
	}

	// 상품의 총 갯수 보기
	public int getProductsTotleCount(int categoryId, String searchKeywordType, String searchKeyword) {
		return productDao.getProductsTotleCount(categoryId, searchKeywordType, searchKeyword);
	}

	// 상품 번호로 불러오기
	public Product getForPrintProduct(Integer id) {
		return productDao.getForPrintProduct(id);
	}

	// 상품 수정 가능 권한 여부
	public ResultData getActorCanModifyRd(Product product, Member actor) {
		if (product.getMemberId() == actor.getId()) {
			return new ResultData("S-1", "가능합니다.");
		}

		if (memberService.isAdmin(actor)) {
			return new ResultData("S-2", "가능합니다.");
		}

		return new ResultData("F-1", "권한이 없습니다.");
	}

	// 상품 수정
	public ResultData modify(Map<String, Object> param) {
		productDao.modify(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "수정 완료되었습니다.", "id", id);
	}

	public List<Product> getForPrintProductByMemberId(int id) {
		return productDao.getForPrintProductByMemberId(id);
	}

	public int getProductsTotleCountByMyList(int loginMemberId, int categoryId, String searchKeywordType,
			String searchKeyword) {
		return productDao.getProductsTotleCountByMyList(loginMemberId, categoryId, searchKeywordType, searchKeyword);
	}

	// 가장 최신 자유 상품 2개
	public List<Product> getLatestProductByBoardNameFree() {
		return productDao.getLatestProductByBoardNameFree();
	}

	// 가장 최신 공지사항 상품 2개
	public List<Product> getLatestProductByBoardNameNotice() {
		return productDao.getLatestProductByBoardNameNotice();
	}

	public Product getProductByReply(Integer id) {
		return productDao.getProductByReply(id);
	}

	public List<Category> getForPrintCategorys() {
		return productDao.getForPrintCategorys();
	}

	// 가장 최근 업데이트 된 상품보기 4개
	public List<Product> getForPrintNewUpdatedProducts() {

		List<Product> products = productDao.getForPrintNewUpdatedProducts();

		List<Integer> productIds = products.stream().map(product -> product.getId()).collect(Collectors.toList());

		Map<Integer, Map<String, GenFile>> filesMap = genFileService.getFilesMapKeyRelIdAndFileNo("product", productIds,
				"common", "attachment");

		for (Product product : products) {
			Map<String, GenFile> mapByFileNo = filesMap.get(product.getId());

			if (mapByFileNo != null) {
				product.getExtraNotNull().put("file__common__attachment", mapByFileNo);
			}
		}
		return products;
	}

	// 오늘 업데이트 된 상품보기
	public List<Product> getForPrintTodayUpdatedProducts() {

		List<Product> products = productDao.getForPrintTodayUpdatedProducts();

		List<Integer> productIds = products.stream().map(product -> product.getId()).collect(Collectors.toList());

		Map<Integer, Map<String, GenFile>> filesMap = genFileService.getFilesMapKeyRelIdAndFileNo("product", productIds,
				"common", "attachment");

		for (Product product : products) {
			Map<String, GenFile> mapByFileNo = filesMap.get(product.getId());

			if (mapByFileNo != null) {
				product.getExtraNotNull().put("file__common__attachment", mapByFileNo);
			}
		}
		return products;
	}
}
