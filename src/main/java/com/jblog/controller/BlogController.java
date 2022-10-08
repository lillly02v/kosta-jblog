package com.jblog.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jblog.service.BlogService;
import com.jblog.vo.BlogVo;
import com.jblog.vo.CommentsVo;
import com.jblog.vo.PostVo;



@Controller
@RequestMapping("/")
public class BlogController {
	
	@Autowired
	private BlogService blogService;
	
	public BlogController() {
		System.out.println("blogController 생성");
	}
	
	@RequestMapping(value="/{userId}",method = RequestMethod.GET)
	public String enterBlog(@PathVariable("userId") String userId, Model model, HttpSession session) {
		model.addAttribute("blogVo", blogService.getBlog(userId));
		Long userNo = blogService.getUserNo(userId);
		System.out.println("userNo"+userNo);
		model.addAttribute("cateVo", blogService.getCate(userNo));
		model.addAttribute("postVo",blogService.getFirstPostList(userNo));
		System.out.println(blogService.getFirstPostList(userNo));
		model.addAttribute("postContent",blogService.getFirstPostContent(userNo));
		model.addAttribute("userId",blogService.getUserId(userNo));
		//첫번째 답변가져옴
		model.addAttribute("commentsVo", blogService.getReply(userNo));
		return "blog/blog-main";
	}
	
	@ResponseBody
	@RequestMapping(value="/{userId}/blog/getPostLIst",method = RequestMethod.GET)
	public List<PostVo> getPostList(@PathVariable("userId") String userId, @RequestParam("cateNum") String cateNum) {
		int cateNo = Integer.parseInt(cateNum);
		System.out.println("cateNo"+cateNo);
		System.out.println("getPostList"+blogService.getPostList(cateNo));
		return blogService.getPostList(cateNo);
	}
	
	@ResponseBody
	@RequestMapping(value="/{userId}/getPostContent",method = RequestMethod.GET)
	public List<PostVo> getPostContent(@PathVariable("userId") String userId, @RequestParam("postNum") String postNum) {
		System.out.println("getPostContent");
		int postNo = Integer.parseInt(postNum);
		return blogService.getPostContent(postNo);
	}
	
	@ResponseBody
	@RequestMapping(value="/{userId}/getCommentsList",method = RequestMethod.GET)
	public List<CommentsVo> getCommentsList(@PathVariable("userId") String userId, @RequestParam("postNum") String postNum) {
		int postNo = Integer.parseInt(postNum);
		System.out.println("getCommentList"+postNo);
		return blogService.getCommentsList(postNo);
	}
	
	@ResponseBody
	@RequestMapping(value="/{userNo}/addReply",method = RequestMethod.GET)
	public CommentsVo addReply(@PathVariable("userNo") Long userNo, 
		@RequestParam("postNum") String postNum, @RequestParam("name") String name, @RequestParam("replyContent") String replyContent) {
		int postNo = Integer.parseInt(postNum);
		System.out.println("postNUm"+ postNum);
		System.out.println("userNo"+userNo);
		CommentsVo commentsvo = new CommentsVo();
		commentsvo.setUserNo(userNo);
		commentsvo.setCoName(name);
		commentsvo.setCmtContent(replyContent);
		commentsvo.setPostNo(postNo);
		return blogService.addReply(commentsvo);
	}
	
	

	
}