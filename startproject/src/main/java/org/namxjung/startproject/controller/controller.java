package org.namxjung.startproject.controller;

import java.util.List;
import java.util.Map;

import org.namxjung.startproject.persistence.TestDao;
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
	@Autowired
	private TestDao mytestDao;
	
	public controller(TestService myTestService, TestDao mytestDao) {
		super();
		this.myTestService = myTestService;
		this.mytestDao = mytestDao;
	}
	
	@RequestMapping(value = "main")
	public String mainController() {
		return "main";
		
	}
	
	//list jsp에서는 번호와 이름만꺼낼거임 테스트용도
	@RequestMapping(value="/list",method = RequestMethod.GET)
	public String list(Model model) {
		List<TestVo> list = myTestService.list();
		System.out.println(list);
		model.addAttribute("list", list);
		return "list";
	}
	
	
	@RequestMapping(value = "board/{store_num}", method = RequestMethod.GET)
	public String map2Controller(Model model, @PathVariable int store_num) {
		TestVo storelist = myTestService.readStore(store_num);
		model.addAttribute("storelist", storelist);
		
		//==========================================================================
		List<Map<String, Object>> Reviewlist = mytestDao.selectReviews(store_num);
		model.addAttribute("Reviewlist", Reviewlist);
		System.out.println(Reviewlist);
		
		return "board";
		
	}

}
