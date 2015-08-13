package org.nojo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
///////////////////////////////////////////////////////////////
//  mypage
///////////////////////////////////////////////////////////////

	//학원 mypage
	@RequestMapping(value="/{userid}/a/mypage", method=RequestMethod.GET)
	public String amypage(@PathVariable String userid, Model model){
		model.addAttribute("userid", userid);
		return "/mypage/amypage";
	}
	
	//선생님 mypage
	@RequestMapping(value="/{userid}/t/mypage", method=RequestMethod.GET)
	public String tmypage(@PathVariable String userid, Model model){
		model.addAttribute("userid", userid);
		return "/mypage/tmypage";
	}
	
	//학생 mypage
	@RequestMapping(value="/{userid}/s/mypage", method=RequestMethod.GET)
	public String smypage(@PathVariable String userid, Model model){
		model.addAttribute("userid", userid);
		return "/mypage/smypage";
	}	

	
	
///////////////////////////////////////////////////////////////
//카페index
///////////////////////////////////////////////////////////////	

	//선생님/카페//설정
	@RequestMapping(value="/{domain}/{userid}/t", method=RequestMethod.GET)
	public String tsetting(@PathVariable String domain, @PathVariable  String userid, Model model){
	model.addAttribute("domain", domain);	
	model.addAttribute("userid", userid);
	return "/index/tindex";
	}
	
	@RequestMapping(value="/{domain}/{userid}/s", method=RequestMethod.GET)
	public String ssetting(@PathVariable String domain, @PathVariable  String userid, Model model){
	model.addAttribute("domain", domain);	
	model.addAttribute("userid", userid);
	return "/index/sindex";
	}
	
	
	
	
///////////////////////////////////////////////////////////////
//카페 홈(메인)
///////////////////////////////////////////////////////////////	
	
	//선생님/카페/메인(main만)
	@RequestMapping(value="/{domain}/{userid}/t/main", method=RequestMethod.GET)
	public String tmain(@PathVariable("domain") String domain, @PathVariable("userid") String userid, Model model){
		model.addAttribute("domain", domain);
		model.addAttribute("userid", userid);
		return "/index/tmain";
	}
	
	//선생님/카페/메인(main만)
	@RequestMapping(value="/{domain}/{userid}/s/main", method=RequestMethod.GET)
	public String smain(@PathVariable("domain") String domain, @PathVariable("userid") String userid, Model model){
		model.addAttribute("domain", domain);
		model.addAttribute("userid", userid);
		return "/index/smain";
	}

	

	
	
///////////////////////////////////////////////////////////////
//기타
///////////////////////////////////////////////////////////////	
	
	
	@RequestMapping(value="/mypage", method=RequestMethod.GET)
	public void mypage(){
	}

	@RequestMapping(value="/mypage2", method=RequestMethod.GET)
	public void mypage2(){
	}
	
	@RequestMapping(value="/index", method=RequestMethod.GET)
	public void index(){
	}
	
	@RequestMapping(value="/index2", method=RequestMethod.GET)
	public void index2(){
	}
	
	@RequestMapping(value="/include/header", method=RequestMethod.GET)
	public void header(){
	}
	
	@RequestMapping(value="/include/aside", method=RequestMethod.GET)
	public void aside(){
	}
	
	@RequestMapping(value="/include/footer", method=RequestMethod.GET)
	public void footer(){
	}
	
	
}
