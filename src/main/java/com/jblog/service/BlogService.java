package com.jblog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jblog.repository.BlogDao;
import com.jblog.vo.BlogVo;
import com.jblog.vo.CategoryVo;
import com.jblog.vo.CommentsVo;
import com.jblog.vo.PostVo;

@Service
public class BlogService {
	
	@Autowired
	private BlogDao blogDao;
	
	public BlogVo getBlog(String userId) {
		return blogDao.getBlog(userId);
	}

	public List<CategoryVo> getCate(Long userNo){
		return blogDao.getCate(userNo);
	}
	
	public List<PostVo> getPostList(int cateNo){
		return blogDao.getPostList(cateNo);
	}
	
	public List<PostVo> getFirstPostList(Long userNo){
		return blogDao.getFirstPostList(userNo);
	}
	
	public List<PostVo> getPostContent(int postNo){
		return blogDao.getPostContent(postNo);
	}
	
	public PostVo getFirstPostContent(Long userNo) {
		return blogDao.getFirstPostContent(userNo);
	}
	
	public Long getUserNo(String userId) {
		return blogDao.getUserNo(userId);
	}
	
	public List<CommentsVo> getReply(Long userNo){
		return blogDao.getReply(userNo);
	}
	
	public List<CommentsVo> getCommentsList(int postNo){
		return blogDao.getCommentsList(postNo);
	}
	
	public CommentsVo addReply(CommentsVo commentsvo){
		return blogDao.addReply(commentsvo);
	}
	
	public String getUserId(Long userNo) {
		return blogDao.getUserId(userNo);
	}
}
