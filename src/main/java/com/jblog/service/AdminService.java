package com.jblog.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jblog.repository.AdminDao;
import com.jblog.vo.BlogVo;
import com.jblog.vo.CategoryVo;
import com.jblog.vo.PostVo;

@Service
public class AdminService {
	
	@Autowired
	private AdminDao adminDao;
	
	public Boolean update(BlogVo blogVo) {
		return adminDao.update(blogVo);
	}
	
	//카테고리 삭제 Dao로 이동
	public Boolean delete(CategoryVo categoryvo) {
	    return adminDao.delete(categoryvo);
	}
	
	//카테고리 리스트 Dao로 이동
	public ArrayList<CategoryVo> getList(Long userNo){
	    ArrayList<CategoryVo> obj = (ArrayList<CategoryVo>) adminDao.getList(userNo);
	    for(int i=0; i<obj.size(); i++) {
	    //   System.out.println(obj.get(i) + "list");
	    }
	    return obj;
	}
	
	public ArrayList<CategoryVo> cateInsert(CategoryVo categoryvo) {
		ArrayList<CategoryVo> obj = (ArrayList<CategoryVo>) adminDao.cateInsert(categoryvo);
		return obj;
	}
	
	//카테고리 name,no가져오기
	public List<CategoryVo> getCate(Long userNo) {
		return adminDao.getCate(userNo);
	}
	
	public void insertPost(PostVo postVo) {
		adminDao.insertPost(postVo);
	}

	

}
