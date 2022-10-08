package com.jblog.repository;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jblog.vo.BlogVo;
import com.jblog.vo.CategoryVo;
import com.jblog.vo.PostVo;



@Repository
public class AdminDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public Boolean update(BlogVo blogVo) {
		int count  = sqlSession.update("admin.update", blogVo);
		return 1 == count;
	}
	
	//카테고리 리스트 출력
	public List<CategoryVo> getList(Long userNo){      
	    return sqlSession.selectList("admin.getList", userNo);
	}
	   
	//카테고리 삭제 
	public boolean delete(CategoryVo catevo) {
	    int count = sqlSession.delete("admin.delete", catevo);
	    return 1==count;
	}
	
	public List<CategoryVo> cateInsert(CategoryVo categoryvo) {
		sqlSession.insert("admin.insertCate", categoryvo);
		return sqlSession.selectList("admin.selectCate");
	}
	
	public List<CategoryVo> getCate(Long userNo) {
		return sqlSession.selectList("admin.getCate", userNo);
	}
	
	public void insertPost(PostVo postVo) {
		sqlSession.insert("admin.insertPost", postVo);
	}

}
