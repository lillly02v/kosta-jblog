package com.jblog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class MainController {
	
	@RequestMapping({"/","main"})
	public String main() {
	  System.out.println("main....");
		return "main/index";
	}
	
	
}
