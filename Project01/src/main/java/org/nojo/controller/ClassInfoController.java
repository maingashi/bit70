package org.nojo.controller;

import java.util.List;

import javax.inject.Inject;

import org.nojo.bizDomain.ClassListVO;
import org.nojo.domain.ClassVO;
import org.nojo.domain.CourseVO;
import org.nojo.service.ClassInfoService;
import org.nojo.service.CourseService;
import org.nojo.util.Criteria;
import org.nojo.util.PageMaker;
import org.nojo.util.SearchCriteria;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/classinfo")
public class ClassInfoController {

	@Inject
	private ClassInfoService classInfoService;
	
	@Inject
	private CourseService courseService;
	
	
	//수업상세
	@RequestMapping(value="/classread", method=RequestMethod.GET)
	public String classread(String domain, Model model){
		ClassListVO clzVO ;
		clzVO = classInfoService.getClassOne(domain);
		
		System.out.println("===============================================");
		System.out.println(clzVO.getTeacherlist().size());
		System.out.println("===============================================");
		
		model.addAttribute("clzinfo", clzVO);
		
		return "/classinfo/classread" ;
	}
	
	//수업리스트
	@RequestMapping(value="/classlist", method=RequestMethod.GET)
	public String classlist(SearchCriteria cri, Model model){
		List<ClassListVO> list;
		PageMaker pagemaker;
		
		System.out.println(cri.getKeyword());
		System.out.println(cri.getSearchType());
		System.out.println(cri.getFirst());
		System.out.println(cri.getPerPageNum());
		
		list = classInfoService.getClassList(cri);
		pagemaker = new PageMaker(cri, classInfoService.getClassTotalCnt(cri));
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pagemaker);
		model.addAttribute("cri", cri);

		return "/classinfo/classlist" ;
	}
	
	//my페이지 전체 수업리스트
	@RequestMapping(value="/sclasslistjoin/{userid}", method=RequestMethod.GET)
	public String classlistjoin(@PathVariable("userid") String userid, SearchCriteria cri, Model model){
		List<ClassListVO> list;
		PageMaker pagemaker;
		
		System.out.println(cri.getKeyword());
		System.out.println(cri.getSearchType());
		System.out.println(cri.getFirst());
		System.out.println(cri.getPerPageNum());
		
		list = classInfoService.getClassList(cri);
		pagemaker = new PageMaker(cri, classInfoService.getClassTotalCnt(cri));
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pagemaker);
		model.addAttribute("cri", cri);

		return "/classinfo/sclasslistjoin" ;
	}
	
	
	
	//개인별(선생님) 수업리스트
	@RequestMapping(value="/classlist/{userid}/t", method=RequestMethod.GET)
	public String tclasslistbyid(@PathVariable("userid") String userid, Criteria cri, Model model){
		List<ClassListVO> list;
		PageMaker pagemaker;
		
		list = classInfoService.getClassListByID(userid, cri); 
		pagemaker = new PageMaker(cri, classInfoService.getClassListTotalCntByID(userid));
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pagemaker);
		
		return "/classinfo/tclasslist" ;
	}
	
	
	//개인별(학생) 수업리스트
	@RequestMapping(value="/classlist/{userid}/s", method=RequestMethod.GET)
	public String sclasslistbyid(@PathVariable("userid") String userid, Criteria cri, Model model){
		List<ClassListVO> list;
		PageMaker pagemaker;
		
		list = classInfoService.getClassListByID(userid, cri); 
		pagemaker = new PageMaker(cri, classInfoService.getClassListTotalCntByID(userid));
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pagemaker);
		
		return "/classinfo/sclasslist" ;
	}
	
	
	
	//수업등록폼
	@RequestMapping(value="/classform", method=RequestMethod.GET)
	public String classform(){
		return "/classinfo/classform";
	}

	//수업등록
	@RequestMapping(value="/classregister", method=RequestMethod.POST)
	public String classregister(ClassVO vo, String[] mem_id){
		System.out.println("@Controller:"+ vo.toString());	
		System.out.println("@Controller:"+ mem_id[0]);	
		System.out.println("@Controller:"+ mem_id[1]);	
		System.out.println("@Controller:"+ mem_id[2]);	
		classInfoService.makeClass(vo, mem_id);
		
		return "redirect:classmodify";
	}
	
	
	//학생 수업 참여 
	@ResponseBody
	@RequestMapping(value="/joinclass", method=RequestMethod.PUT)
	public void joinclass(@RequestBody CourseVO vo){
		System.out.println("@Controller:"+ vo.getClz_domain());	
		System.out.println("@Controller:"+ vo.getMem_id());	
		
		courseService.setCourse(vo);	
	}
	
	
	
	
	
	
	
	//도메인체크
	@ResponseBody
	@RequestMapping(value="/domaincheck", method= RequestMethod.POST)
	public boolean canusedomain(String clz_domain) {
		System.out.println(clz_domain);
		return classInfoService.domainCheck(clz_domain);
	}

	
}
