package com.jblog.vo;


import lombok.Data;

@Data
public class UsersVo {
	private Long userNo;
	private String id;
	private String userName;
	private String password;
	private String joinDate;
	
	
	
	public UsersVo(String id, String password) {
		this.id = id;
		this.password = password;
	}

	public UsersVo() {
		super();
	}
}
