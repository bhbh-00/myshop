package com.bh.myshop.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Category extends EntityDto {

	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String code;
	private String categoryName;
	private boolean blindStatus;
    private String blindDate;
	private boolean delStatus;
    private String delDate;

	private String extra__writer;

}