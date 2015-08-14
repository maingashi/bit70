package org.nojo.controller;

import java.util.List;

import javax.inject.Inject;

import org.nojo.domain.SeatVO;
import org.nojo.service.SeatService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/{domain}/seat")
public class SeatController {
	@Inject
	SeatService seatService;

	@RequestMapping(method = RequestMethod.GET)
	public String seatPage(@PathVariable("domain") String clz_domain, Model model) throws Exception {
		
		model.addAttribute("list", seatService.listMember(clz_domain, "lobby"));
		return "/seat/seat";
	}
	
	@ResponseBody
	@RequestMapping(value="/ajax", method = RequestMethod.GET)
	public List<SeatVO> seat(@PathVariable String domain) throws Exception {
		return seatService.listMember(domain, "seat");
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public void seatPage(@RequestBody List<SeatVO> list, @PathVariable String domain) throws Exception {
		seatService.addSeat(list, domain);
		System.out.println(list);
	}
}
