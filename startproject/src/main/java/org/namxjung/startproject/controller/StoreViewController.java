package org.namxjung.startproject.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.namxjung.startproject.persistence.ReviewVo;
import org.namxjung.startproject.persistence.StoreDao;
import org.namxjung.startproject.persistence.StoreVo;
import org.namxjung.startproject.service.StoreViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class StoreViewController {
	@Autowired
	private StoreViewService myStoreViewService;
	@Autowired
	private StoreDao myStoreDao;

	//주입을 그냥 DAO까지 한번에 혹시몰라 떄려박았다,,,
	public StoreViewController(StoreViewService myTestService, StoreDao mytestDao) {
		super();
		this.myStoreViewService = myTestService;
		this.myStoreDao = mytestDao;
	}

	//쓸모없는놈.....
	@RequestMapping(value = "main")
	public String mainController() {
		return "main";

	}

	// list jsp에서는 번호와 이름만꺼낼거임 테스트용도
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		List<StoreVo> list = myStoreViewService.list();
		System.out.println(list);
		model.addAttribute("list", list);
		return "list";
	}

	@RequestMapping(value = "StoreView/{store_num}", method = RequestMethod.GET)
	public String boardController(Model model, @PathVariable int store_num) {
		StoreVo storelist = myStoreViewService.readStore(store_num);
		List<Map<String, Object>> nbsCafe = myStoreDao.nearbyCafe(store_num);
		List<Map<String, Object>> nbsRestaurant = myStoreDao.nearbyRestaurant(store_num);
		
		int totalCount = myStoreDao.getReviewCount(store_num);
		
		model.addAttribute("storelist", storelist);
		model.addAttribute("nbsCafe", nbsCafe);
		model.addAttribute("nbsRestaurant", nbsRestaurant);

		// ==========================================================================
		List<Map<String, Object>> Reviewlist = myStoreDao.selectReviews(store_num, 1);
		model.addAttribute("Reviewlist", Reviewlist);
		System.out.println(Reviewlist);

		// ===========================================================================
		List<StoreVo> list = myStoreViewService.list();
		model.addAttribute("list", list);
		model.addAttribute("storeNum", store_num);
		model.addAttribute("totalCount", totalCount / 5 + 1); //
		System.out.println(list);

		return "StoreView";
	}
//===========================================================================================================================
	/*ajax 데이터전송을 위한 컨트롤러 위와 같은 storeView url컨트롤러지만 위에는 정말 말그대로 StoreView를 보여주기위한 렌더링용 컨트롤러
	 * ResponseBody가 붙었으니 ajax전송 컨트롤러 겠쥬,,,,,,,,
	 * value 부분에서 애를 많이먹었는데 아무래도 ajax선언할때의 url과 형식을 맞추는게 맞는것같다,,,,
	 */
	
	@RequestMapping(value = "StoreView2/{store_num}/{page_num}", method = RequestMethod.GET)
	public @ResponseBody List<Map<String, String>> boardPaging(@PathVariable int store_num,
			@PathVariable int page_num) {	
		
		List<Map<String, Object>> reviewList = myStoreDao.selectReviewsPaging(store_num, page_num);
		System.out.println(page_num+"입니다");
		int totalCount = myStoreDao.getReviewCount(store_num);
		
		System.out.println("totalCount = " + totalCount);
		System.out.println(reviewList);
		
		//제일 문제의 부분.....오류가 결론적으로 ajax에 전달될 List<Map<String, String>>를 미리만들어주고
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		//물론 json오류 안나게 String으로다가...
		Map<String, String> map = null;
		ReviewVo vo = null;
		//ajax에 전달된 list에다가 값넣어버리기....
		//참고자료는 https://chobopark.tistory.com/36 여기서 두번쨰 방법과 
		//https://lsk925.tistory.com/32 Responsebody가 중요한 이유를 설명해주는 자료....
		for (int i = 0; i < reviewList.size(); i++) {
			map = new HashMap<>();
			vo = (ReviewVo) reviewList.get(i);
			map.put("reivewNum", vo.getReviewNum());
			map.put("id", vo.getId());
			map.put("star", vo.getStar());
			map.put("content", vo.getContent());
			map.put("regdate", vo.getRegdate().toString());
			map.put("picture", vo.getPicture());
			list.add(map);
		}
		return list;
	}
//깔끔히 끝나면좋겠다...4/28
	//801%깔끔히 끝나는중....4/29
	@RequestMapping(value = "GPSlocation")
	public String GPSlocationController(Model model) {
		List<StoreVo> Addresslist = myStoreDao.selectAllAddress();
		System.out.println(Addresslist);
		model.addAttribute("GPS", Addresslist);
		return "GPSlocation";
	}
}
