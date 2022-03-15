package com.bh.myshop.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bh.myshop.dao.CartDao;
import com.bh.myshop.dto.Cart;
import com.bh.myshop.dto.GenFile;
import com.bh.myshop.dto.Product;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.util.Util;

@Service
public class CartService {
	@Autowired
	private CartDao cartDao;

	@Autowired
	private GenFileService genFileService;

	// 장바구니 취소
	public ResultData delete(Map<String, Object> param) {
		cartDao.delete(param);

		return new ResultData("S-1", "장바구니를 취소합니다.");
	}

	// 장바구니 추가
	public ResultData doAdd(Map<String, Object> param) {
		cartDao.add(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "장바구니에 추가합니다.", "id", id);
	}

	// 장바구니 가져오기
	public Cart getCart(String relTypeCode, Integer relId) {
		return cartDao.getCart(relTypeCode, relId);
	}

	// 내가 장바구니에 담은 제품 보여주기
	public List<Product> getForPrintCartsByProduct(int loginMemberId) {

		List<Product> products = cartDao.getForPrintCartsByProduct(loginMemberId);
		List<Integer> productIds = products.stream().map(article -> article.getId()).collect(Collectors.toList());
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

	// 내 번호로 장바구니 가져오기
	public List<Cart> getForPrintCartsByMemberId(int loginMemberId) {
		return cartDao.getForPrintCartsByMemberId(loginMemberId);
	}

	// 내가 장바구니에 추가한 수
	public int getCartsTotleCountByMyList(int loginMemberId) {
		return cartDao.getCartsTotleCountByMyList(loginMemberId);
	}

	// 내 장바구니 보여주기
	public List<Cart> getForPrintCartsByMyList(int loginMemberId, int page, int itemsInAPage) {
		// 페이징 - 시작과 끝 범위
		int limitStart = (page - 1) * itemsInAPage;
		// controller에서 한 페이지에 포함 되는 게시물의 갯수의 값을(itemsInAPage) 설정했음.
		int limitTake = itemsInAPage;
		// 한 페이지에 포함 되는 게시물의 갯수의 값
		// LIMIT 20, 20 => 2page LIMIT 40, 20 => 3page

		List<Cart> carts = cartDao.getForPrintCartsByMyList(loginMemberId, page, itemsInAPage, limitStart, limitTake);

		return carts;
	}

}
