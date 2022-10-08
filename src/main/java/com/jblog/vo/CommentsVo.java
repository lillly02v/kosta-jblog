package com.jblog.vo;


import lombok.Data;

@Data
public class CommentsVo {
	private int cmtNo;
	private int postNo;
	private long userNo;
	private String cmtContent;
	private String regDate;
	private String coName;
	
}
