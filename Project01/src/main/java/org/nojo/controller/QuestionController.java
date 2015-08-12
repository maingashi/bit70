package org.nojo.controller;

import java.util.List;

import javax.inject.Inject;

import org.nojo.domain.AnswerVO;
import org.nojo.domain.QuestionVO;
import org.nojo.service.AnswerService;
import org.nojo.service.QuestionService;
import org.nojo.util.Criteria;
import org.nojo.util.PageMaker;
import org.nojo.util.Search;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/{domain}/qna")
public class QuestionController {

	
	//region Inject 
	@Inject
	private QuestionService service;
	@Inject
	private AnswerService ansService;
	//region End
	
	
	
	
	//리스트페이지 & 검색
	@RequestMapping("/listpage")
	public String ListPage(@PathVariable("domain") String domain, Criteria cri, Model model, String searchKey,
			String searchValue) throws Exception {

		Search search = new Search();
		if (searchKey != null)
			search.setSearchKey(searchKey.split("&"));
		search.setSearchValue(searchValue);

		PageMaker pagemaker = null;
		List<QuestionVO> list = null;
		
		if (search.getSearchValue() == null) {

			pagemaker = new PageMaker(cri, service.getCnt(domain));
			list = service.listQuestion(domain, cri);
			
		} else {

			pagemaker = new PageMaker(cri, service.getSearchCnt(domain, search));
			list = service.searchQuestion(domain, cri, search);

			model.addAttribute("searchKey", searchKey);
			model.addAttribute("searchValue", searchValue);

		}

		model.addAttribute("list", list);
		model.addAttribute("pagemaker", pagemaker);

		return "qna/listpage";
	}

	
	//등록 region
	@RequestMapping(value = "/questionRegist", method = RequestMethod.GET)
	public String regist() {

		return "qna/questionRegist";
	}

	@RequestMapping(value = "/questionRegist", method = RequestMethod.POST)
	public String registQuestion(QuestionVO vo) throws Exception {

		service.addQuestion(vo);
		return "redirect:listpage";
	}
	//region End
	

	
	
	//질문 글 조회 
	@RequestMapping("/detail")
	public String readBoard(@PathVariable("domain") String domain, @RequestParam("no") int no, @ModelAttribute("cri") Criteria cri, Model model)
			throws Exception {
		
		PageMaker pagemaker = null;
		List<AnswerVO> list = null;

		pagemaker = new PageMaker(cri, ansService.getCntList(no));
		list = ansService.getAllAnswers(domain, no, cri);

		model.addAttribute("ansList", list);
		model.addAttribute("QuestionVO", service.getReadQuestion(no));

		return "qna/detail";
	}

	
	//글 수정 region
	@RequestMapping("/questionModify")
	public String modify(@PathVariable("domain") String domain, @RequestParam("no") int no, @ModelAttribute("cri") Criteria cri, Model model)
			throws Exception {

		readBoard(domain, no, cri, model);

		return "qna/questionModify";
	}

	@RequestMapping(value = "/questionModify", method = RequestMethod.POST)
	public String modifyBoard(QuestionVO vo) throws Exception {

		service.modifyQuestion(vo);

		return "redirect:detail?no=" + vo.getQuestion_no();
	}
	//region End
	

	//글삭제
	@RequestMapping(value = "/questionRemove/{no}")
	public String removeBoard(@PathVariable("no") int no) throws Exception {

		service.removeQuestion(no);

		return "redirect:../listpage";
	}

}
