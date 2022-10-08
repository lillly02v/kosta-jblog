package com.jblog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jblog.repository.UserDao;
import com.jblog.vo.UsersVo;

@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
	public Boolean existId(String id) {
		UsersVo userVo = userDao.get(id);
		return userVo != null;
	}
	
	public UserService() {
		System.out.println("userService 생성");
	}

	public Boolean join(UsersVo userVo) {
		return userDao.insert(userVo);
	}

	public UsersVo getUser(UsersVo userVo) {
		return userDao.get(userVo.getId(), userVo.getPassword());
	}
	
	public UsersVo getUser(long no) {
		
		return userDao.get(no);
	}

	public Boolean update(UsersVo updateUserVo) {
		return userDao.update(updateUserVo);
	}

}
