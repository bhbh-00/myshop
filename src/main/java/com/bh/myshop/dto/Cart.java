package com.bh.myshop.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cart extends EntityDto {

	// 중요한 순으로 나열하는 게 좋음
	private int id;
	private String regDate;
	private String updateDate;
	private String relTypeCode;
	private int relId;
	private int memberId;
	private boolean delStatus;
	private String delDate;

	private String extra__writer;
	private String extra__thumbImg; // 썸네일

	public String getThumbImgUrl() {
		return "/common/genFile/file/product/" + relId + "/common/attachment/1";
	}

	public String getProductFallbackImgUri() {
		return "https://via.placeholder.com/300?text=No thumbnail";
	}

	public String getProductFallbackImgOnErrorHtmlAttr() {
		return "this.src = '" + getProductFallbackImgUri() + "'";
	}
}
