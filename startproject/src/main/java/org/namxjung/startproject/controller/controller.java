package org.namxjung.startproject.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.namxjung.startproject.persistence.ReviewVo;
import org.namxjung.startproject.persistence.TestDao;
import org.namxjung.startproject.persistence.TestVo;
import org.namxjung.startproject.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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

	// list jsp에서는 번호와 이름만꺼낼거임 테스트용도
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		List<TestVo> list = myTestService.list();
		System.out.println(list);
		model.addAttribute("list", list);
		return "list";
	}

	@RequestMapping(value = "board/{store_num}", method = RequestMethod.GET)
	public String boardController(Model model, @PathVariable int store_num) {
		TestVo storelist = myTestService.readStore(store_num);
		int totalCount = mytestDao.getReviewCount(store_num);
		model.addAttribute("storelist", storelist);

		// ==========================================================================
		List<Map<String, Object>> Reviewlist = mytestDao.selectReviews(store_num, 1);
		model.addAttribute("Reviewlist", Reviewlist);
		System.out.println(Reviewlist);

		// ===========================================================================
		List<TestVo> list = myTestService.list();
		model.addAttribute("list", list);
		model.addAttribute("storeNum", store_num);
		model.addAttribute("totalCount", totalCount / 5 + 1); //
		System.out.println(list);

		return "board";
	}

	@RequestMapping(value = "board2/{store_num}/{page_num}", method = RequestMethod.GET)
	public @ResponseBody List<Map<String, String>> boardPaging(@PathVariable int store_num,
			@PathVariable int page_num) {
	//이컨트롤러는 @ResponseBody가 붙었으니 ajax에 전달하기 위한용도
		
		
	
		List<Map<String, Object>> reviewList = mytestDao.selectReviewsPaging(store_num, page_num);

		int totalCount = mytestDao.getReviewCount(store_num);
		System.out.println("totalCount = " + totalCount);
		System.out.println(reviewList);

		// ajax로 값을 보낼려는데 위에 reviewList처럼 string,Object는 전달이 안되는 오류가 발생한다.찾아보니 json은
		// 기본적으로다가 string으로 받는단다 그래서 string,string으로
		// map을 만들어봄
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();

		// null을 넣은 이유는 이따가 map에는 HashMap<>으로 생성하고 값들을 .put으로 넣을라고
		Map<String, String> map = null;
		ReviewVo vo = null;

		
		for (int i = 0; i < reviewList.size(); i++) {
			map = new HashMap<>();
			
			vo = (ReviewVo) reviewList.get(i);
			
	
			map.put("reivewNum", vo.getReviewNum());
			map.put("id", vo.getId());
			map.put("star", vo.getStar());
			map.put("content", vo.getContent());
			map.put("regdate", vo.getRegdate().toString());
			map.put("picture", vo.getPicture());
			
			//ajax에 보낼 list에다가 map값들을 다넣어버리기
			list.add(map);
		}
		return list;
	}

}
