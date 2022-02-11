package com.bh.myshop.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bh.myshop.dao.OrderDao;
import com.bh.myshop.dto.Category;
import com.bh.myshop.dto.GenFile;
import com.bh.myshop.dto.Member;
import com.bh.myshop.dto.Order;
import com.bh.myshop.dto.ResultData;
import com.bh.myshop.util.Util;

@Service
public class OrderService {	
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private MemberService memberService;
	@Autowired
	private GenFileService genFileService;

	// 아이디로 해당 주문 가져오기
	public Order getorder(int id) {
		return orderDao.getorder(id);
	}

	// 주문 작성
	public ResultData doAdd(Map<String, Object> param) {
		orderDao.add(param);

		int id = Util.getAsInt(param.get("id"), 0);

		// 파일 업로드 시 파일의 번호를 주문의 번호를 바꾼다.
		genFileService.changeInputFileRelIds(param, id);

		return new ResultData("s-1", "주문이 추가되었습니다.", "id", id);
	}

	public List<Order> getorderList(String searchKeywordType, String searchKeyword) {
		return orderDao.getorders(searchKeywordType, searchKeyword);
	}

	// 주문 상세 페이지
	public Order getForPrintorder(Integer id) {
		return orderDao.getForPrintorder(id);
	}

	public List<Order> getForPrintorders(int categoryId, String searchKeywordType, String searchKeyword, int page,
			int itemsInAPage) {
		// 페이징 - 시작과 끝 범위
		int limitStart = (page - 1) * itemsInAPage;
		// controller에서 한 페이지에 포함 되는 주문의 갯수의 값을(itemsInAPage) 설정했음.
		int limitTake = itemsInAPage;
		// 한 페이지에 포함 되는 주문의 갯수의 값
		// LIMIT 20, 20 => 2page LIMIT 40, 20 => 3page

		List<Order> orders = orderDao.getForPrintorders(categoryId, searchKeywordType, searchKeyword, limitStart,
				limitTake);
		List<Integer> orderIds = orders.stream().map(order -> order.getId()).collect(Collectors.toList());
		Map<Integer, Map<String, GenFile>> filesMap = genFileService.getFilesMapKeyRelIdAndFileNo("order", orderIds,
				"common", "attachment");

		for (Order order : orders) {
			Map<String, GenFile> mapByFileNo = filesMap.get(order.getId());

			if (mapByFileNo != null) {
				order.getExtraNotNull().put("file__common__attachment", mapByFileNo);
			}
		}

		return orders;
	}
	
	// 주문 수정 가능 권한 여부
	public ResultData getActorCanModifyRd(Order order, Member actor) {
		if (order.getMemberId() == actor.getId()) {
			return new ResultData("S-1", "가능합니다.");
		}

		if (memberService.isAdmin(actor)) {
			return new ResultData("S-2", "가능합니다.");
		}

		return new ResultData("F-1", "권한이 없습니다.");
	}

	// 주문 수정
	public ResultData modify(Map<String, Object> param) {
		orderDao.modify(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("s-1", "수정 완료되었습니다.", "id", id);
	}

	// 주문 삭제 가능 권한 여부 확인
	public ResultData getActorCanDeleteRd(Order order, Member actor) {
		return getActorCanModifyRd(order, actor);
	}

	// 주문 삭제
	public ResultData delete(int id) {
		orderDao.delete(id);

		// 파일 삭제
		genFileService.deleteGenFiles("order", id);

		return new ResultData("S-1", "삭제되었습니다.", "id", id);
	}

	public int getordersTotleCount(int categoryId, String searchKeywordType, String searchKeyword) {
		return orderDao.getordersTotleCount(categoryId, searchKeywordType, searchKeyword);
	}

	public List<Order> getForPrintorderByMemberId(int id) {
		return orderDao.getForPrintorderByMemberId(id);
	}
	
	public int getordersTotleCountByMyList(int loginMemberId, int categoryId, String searchKeywordType,
			String searchKeyword) {
		return orderDao.getordersTotleCountByMyList(loginMemberId, categoryId, searchKeywordType, searchKeyword);
	}
	
	public Order getorderByReply(Integer id) {
		return orderDao.getorderByReply(id);
	}

	public Category getCategory(int categoryId) {
		return orderDao.getCategory(categoryId);
	}
	
	// 기존의 주문명 확인
	public Order getorderByName(String name) {
		return orderDao.getorderByName(name);
	}

}
