package com.jblog.repository;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jblog.vo.BlogVo;
import com.jblog.vo.CategoryVo;
import com.jblog.vo.CommentsVo;
import com.jblog.vo.PostVo;



@Repository
public class BlogDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public BlogVo getBlog(String id) {
		return sqlSession.selectOne("blog.getById", id);//user.xml로 이동
	}
	
	public List<CategoryVo> getCate(Long userNo){
		return sqlSession.selectList("blog.getCate", userNo);
	}
	
	public List<PostVo> getPostList(int cateNo){
		return sqlSession.selectList("blog.getPostList", cateNo);
	}
	
	public List<PostVo> getFirstPostList(Long userNo){
		return sqlSession.selectList("blog.getFirstPostList", userNo);
	}
	
	public List<PostVo> getPostContent(int postNo){
		System.out.println("blogDao"+sqlSession.selectList("blog.getPostContent", postNo));
		return sqlSession.selectList("blog.getPostContent", postNo);
	}
	
	public PostVo getFirstPostContent(Long userNo) {
		return sqlSession.selectOne("blog.getFirstPostContent",userNo);
	}
	
	public Long getUserNo(String userId) {
		return sqlSession.selectOne("blog.getUserNo", userId);
	}
	
	public List<CommentsVo> getReply(Long userNo){
		return sqlSession.selectList("blog.getReply", userNo);
	}
	
	public List<CommentsVo> getCommentsList(int postNo){
		return sqlSession.selectList("blog.getCommentsList", postNo);
	}
	
	public CommentsVo addReply(CommentsVo commentsvo){
		sqlSession.insert("blog.addReply", commentsvo);
		return sqlSession.selectOne("blog.firstReply");
	}
	
	public String getUserId(Long userNo) {
		return sqlSession.selectOne("blog.getUserId", userNo);
	}
	
	public List<CommentsVo> cmtDelete(CommentsVo cmtVo){
		sqlSession.delete("blog.cmtDelete", cmtVo);
		return sqlSession.selectList("blog.deletedCmtList",cmtVo);
	}

}
