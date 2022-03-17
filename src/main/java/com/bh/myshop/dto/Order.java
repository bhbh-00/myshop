package com.bh.myshop.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order extends EntityDto {

	// 중요한 순으로 나열하는 게 좋음
	private int id;
	private String regDate; // 등록 시점
	private String updateDate; // 수정 시점
	private int productId;
	private int categoryId;
	private int memberId;
	private String orderName;
	private String cellphoneNo;
	private String post;
	private String address;
	private String detailAddress;
	private String email;
	private int payment;
	private int totalPayment;
	private int paymentStatus;
	private String paymentDate;
	private boolean blindStatus;
	private String blindDate;
	private boolean delStatus;
	private String delDate;

	private String extra__writer;
	private String extra__productName; // 상품명
	private String extra__productColor; // 컬러
	private String extra__productSize; // 사이즈
	private String extra__productPrice; // 컬러
	private String extra__productFee; // 사이즈

	public String getThumbImgUrl() {
		return "/common/genFile/file/product/" + productId + "/common/attachment/1";
	}

	public String getProductFallbackImgUri() {
		return "https://via.placeholder.com/300?text=No thumbnail";
	}

	public String getProductFallbackImgOnErrorHtmlAttr() {
		return "this.src = '" + getProductFallbackImgUri() + "'";
	}

}
