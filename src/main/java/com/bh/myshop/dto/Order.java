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
	private int orderCode;
	private String name;
	private String cellphoneNo;
	private String address;
	private String email;
	private int payment;
	private int price;
	private boolean blindStatus;
	private String blindDate;
	private boolean delStatus;
	private String delDate;

	private String extra__writer;
	private String extra__categoryName;
	private String extra__thumbImg; // 썸네일

	public String getWriterThumbImgUrl() {
		return "/common/genFile/file/member/" + memberId + "/common/attachment/1";
	}

	public String getWriterProfileFallbackImgUri() {
		return "https://via.placeholder.com/300?text=No thumbnail";
	}

	public String getWriterProfileFallbackImgOnErrorHtmlAttr() {
		return "this.src = '" + getWriterProfileFallbackImgUri() + "'";
	}

}