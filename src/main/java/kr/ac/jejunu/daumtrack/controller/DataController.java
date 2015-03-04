package kr.ac.jejunu.daumtrack.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import kr.ac.jejunu.daumtrack.dao.DataDao;
import kr.ac.jejunu.daumtrack.dao.DataVo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DataController {
	private static final Logger logger = LoggerFactory.getLogger(DataController.class);
	
	@Resource(name = "dataDao")
	private DataDao dataDao;
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String mainPage() {
		return "index";
	}
	
	@RequestMapping(value = "/busArriveList", method = RequestMethod.GET)
	public String showBusList(Model model) {
		logger.info("Display View busList");
		
		List<DataVo> list = this.dataDao.getSelect();
		model.addAttribute("list", list);
		
		logger.info("Total Count : " + list.size());
		
		return "busArriveList";
	}
	
	@RequestMapping(value = "/busStation", method = RequestMethod.GET)
	public Model showBusStationList(Model model) {
		logger.info("Display View busStationList");
		Map<String, String> qParam = new HashMap<String, String>();
		List<Map<String, String>> list = this.dataDao.selectBusStationList(qParam);
		model.addAttribute("list", list);
		
		logger.info("Total busStation Count : ");
		
		return model;
	}
}