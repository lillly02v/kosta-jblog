package com.jblog.repository;


import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jblog.vo.CategoryVo;
import com.jblog.vo.UsersVo;



@Repository
public class UserDao {
	
	@Autowired
	private SqlSession sqlSession;
	
//	@Autowired
//	private DataSource dataSource;
	
	public UserDao() {
		System.out.println("userDao 생성");
	}
	public Boolean update(UsersVo vo) {
		int count  = sqlSession.update("user.update",vo);
		return 1 == count;
	}

	public UsersVo get(long no) {
		return sqlSession.selectOne("user.getByNo", no);
	}
	
	public UsersVo get(String id) {
		return sqlSession.selectOne("user.getById", id);//user.xml로 이동
	}

	public UsersVo get(String id, String password) {
		Map<String,String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("password", password);
		
		UsersVo userVo = sqlSession.selectOne("user.getByIdAndPassword",map);
		
		return userVo;
	}

	public boolean insert(UsersVo vo) {
		System.out.println(vo);
		int count = sqlSession.insert("user.insert",vo);
		sqlSession.insert("user.insertBoard",vo);
		Long userNo = sqlSession.selectOne("user.getUserNo", vo);
		CategoryVo categoryvo = new CategoryVo();
		categoryvo.setUserNo(userNo);
		sqlSession.insert("user.defaultCategory",categoryvo);
		System.out.println(vo);
		return 1==count;
	}

}
