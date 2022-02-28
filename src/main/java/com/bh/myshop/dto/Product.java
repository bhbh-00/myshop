package com.bh.myshop.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product extends EntityDto {

	// 중요한 순으로 나열하는 게 좋음
	private int id;
	private String regDate; // 등록 시점
	private String updateDate; // 수정 시점
	private int categoryId; 
	private int memberId;
	private String productName;
	private String body;
	private String color;
	private int price;
	private int fee;
	private boolean blindStatus;
	private String blindDate;
	private boolean delStatus;
	private String delDate;

	private String extra__writer;
	private String extra__categoryName;
	private String extra__thumbImg; // 썸네일

	public String getThumbImgUrl() {
		return "/common/genFile/file/product/" + id + "/common/attachment/1";
	}

	public String getProductFallbackImgUri() {
		return "https://via.placeholder.com/300?text=No thumbnail";
	}

	public String getProductFallbackImgOnErrorHtmlAttr() {
		return "this.src = '" + getProductFallbackImgUri() + "'";
	}

}
