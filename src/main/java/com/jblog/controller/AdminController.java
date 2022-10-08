package com.jblog.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jblog.service.AdminService;
import com.jblog.service.BlogService;
import com.jblog.vo.BlogVo;
import com.jblog.vo.CategoryVo;
import com.jblog.vo.PostVo;
import com.jblog.vo.UsersVo;

import lombok.extern.log4j.Log4j;


@Log4j
@Controller
@RequestMapping("/")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private BlogService blogService;
	
	public AdminController() {
		System.out.println("adminController 생성");
	}
	
	//내블로그 관리로 이동
	@RequestMapping(value="/{userId}/admin/basic",method = RequestMethod.GET)
	public String blogAdmin(@PathVariable("userId") String userId, Model model) {
		model.addAttribute("blogVo", blogService.getBlog(userId));
		return "blog/admin/blog-admin-basic";
	}
	
	@PostMapping(value="/{userId}/admin/update")
	public String profileUpload(@PathVariable("userId") String userId, Model model, MultipartFile[] file, @RequestParam("blogTitle") String blogTitle, @ModelAttribute BlogVo blogVo) {
		String uploadFolder = "C:\\Users\\apf_temp_admin\\eclipse-workspace\\jblog\\src\\main\\webapp\\assets\\images";
		blogVo = blogService.getBlog(userId);
		for (MultipartFile multipartFile : file) {
			
			log.info("-------------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			blogVo.setLogoFile(multipartFile.getOriginalFilename());
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());

			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			} // end catch
		} // end for
		
		blogVo.setBlogTitle(blogTitle);
		adminService.update(blogVo);
		System.out.println(blogVo);
		model.addAttribute("blogVo", blogVo);
		return "blog/admin/blog-admin-basic";
	}
	
	@RequestMapping(value="/{userId}/admin/category",method = RequestMethod.GET)
	public String blogAdminCategory(@PathVariable("userId") String userId, Model model) {
		model.addAttribute("blogVo", blogService.getBlog(userId));
		return "blog/admin/blog-admin-cate";
	}
	
	//글작성 페이지
	@RequestMapping(value="/{userId}/admin/write",method = RequestMethod.GET)
	public String blogAdminWrite(@PathVariable("userId") String userId, Model model, HttpSession session) {
		model.addAttribute("blogVo", blogService.getBlog(userId));
		UsersVo uservo = (UsersVo)session.getAttribute("authUser");
		Long userNo = uservo.getUserNo();
		model.addAttribute("cateList", adminService.getCate(userNo));
		return "blog/admin/blog-admin-write";
	}
	
	//포스트하기
	@RequestMapping(value="/{userId}/admin/post",method = RequestMethod.GET)
	public String blogAdminPost(@ModelAttribute PostVo postVo, @PathVariable("userId") String userId, HttpSession session) {
		adminService.insertPost(postVo);
		return "redirect:/"+userId+"/admin/write";
	}
	
	//카테고리(방명록) 리스트 띄우기
	@ResponseBody
	@RequestMapping(value = "/catelist", method=RequestMethod.GET)
	public List<CategoryVo> getCateList(HttpSession session){
		UsersVo uservo = (UsersVo)session.getAttribute("authUser");
		Long userNo = uservo.getUserNo();
		return adminService.getList(userNo);
	}
	
	 //카테고리(방명록) 삭제할 번호 가져오기
	 @RequestMapping(value="/{userId}/delete/{cateNo}", method = RequestMethod.GET)
	 public String delete(Model model, @PathVariable(value="cateNo") int cateNo, @PathVariable(value="userId") String userId) {
	     model.addAttribute("cateNo", cateNo);
	     return "redirect:/"+userId+"/admin/delete";
	 }

	   //카테고리(방명록) 삭제 처리  
	 @RequestMapping(value="/{userId}/admin/delete", method = RequestMethod.GET)
	 public String delete(@ModelAttribute CategoryVo categoryvo,Model model, @PathVariable(value="userId") String userId) {
	    boolean result =adminService.delete(categoryvo);
	    if(result) {
	       return "redirect:/"+userId+"/admin/category";
	    }else {
	       model.addAttribute("result", "fail");
	       return "redirect:/"+userId+"/delete/"+categoryvo.getCateNo();
	    }
	 }
	 
	 
	 @RequestMapping(value="/{userId}/admin/cateInsert", method = RequestMethod.POST)
	 public @ResponseBody List<CategoryVo> cateInsert(Model model, @PathVariable(value="userId") String userId, String cateName, String desc, HttpSession session){
		 CategoryVo categoryvo = new CategoryVo();
		 UsersVo uservo = (UsersVo)session.getAttribute("authUser");
		 categoryvo.setUserNo(uservo.getUserNo());
		 categoryvo.setCateName(cateName);
		 categoryvo.setDescription(desc);
		 return adminService.cateInsert(categoryvo);
	 }
	
	
	
	
}