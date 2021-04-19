package org.namxjung.startproject.controller;

import java.util.List;

import org.namxjung.startproject.persistence.TestVo;
import org.namxjung.startproject.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class controller {
	@Autowired
	private TestService myTestService;

	public controller(TestService myTestService) {
		super();
		this.myTestService = myTestService;
	}
			
	@RequestMapping(value = "main")
	public String mainController() {
		return "main";
		
	}
	
	@RequestMapping(value="/list",method = RequestMethod.GET)
	public String list(Model model) {
		List<TestVo> list = myTestService.list();
		System.out.println(list);
		model.addAttribute("list", list);
		return "list";
	}
	
	@RequestMapping(value = "map2/{store_num}", method = RequestMethod.GET)
	public String map2Controller(Model model, @PathVariable int store_num) {
		model.addAttribute("TestVo", myTestService.read(store_num));
		return "map2";
		
	}

}
