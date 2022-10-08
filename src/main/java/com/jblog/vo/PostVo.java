package com.jblog.vo;


import lombok.Data;

@Data
public class PostVo {
	private int postNo;
	private int cateNo;
	private String postTitle;
	private String postContent;
	private String regDate;
}
