package com.bh.myshop.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Delivery extends EntityDto {

	// 중요한 순으로 나열하는 게 좋음
	private int id;
	private String regDate; // 등록 시점
	private String updateDate; // 수정 시점
	private int orderId;
	private int memberId;
	private String company; // 택배사
	private String waybillNum; // 운송장번호
	private int deliverystate; // 배송상태
	private String deliveryDate;
	private boolean blindStatus;
	private String blindDate;
	private boolean delStatus;
	private String delDate;
	
	private String extra__writer;
	private String extra__thumbImg; // 썸네일

}
