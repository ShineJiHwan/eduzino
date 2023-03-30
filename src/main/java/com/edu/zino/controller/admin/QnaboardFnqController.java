package com.edu.zino.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.edu.zino.domain.Admin;
import com.edu.zino.domain.QnaboardFnq;

import com.edu.zino.domain.Target;
import com.edu.zino.model.admin.QnaboardFnqService;


@Controller

public class QnaboardFnqController {
	@Autowired
	private QnaboardFnqService qnaboardfnqService;
	
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	/*qnaboard_service controller*/	
	//목록 요청 처리
	@RequestMapping(value = "qnaboard_fnq/list",method =RequestMethod.GET)
	public ModelAndView getList(HttpServletRequest request) {
		logger.info("목록요청을 받음");
		List qnaboardfnqList=qnaboardfnqService.selectAll();
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_fnq//list");
		mav.addObject("qnaboardfnqList",qnaboardfnqList);
		
		return mav;
	}
	
	//글쓰기 폼 요청
	@GetMapping("qnaboard_fnq/registform")
	public ModelAndView getRegist(HttpServletRequest request) {
		logger.info("글쓰기폼 요청");
		return new ModelAndView("/admin/qnaboard_fnq/regist");
	}
	
	//글쓰기 요청 처리
	@PostMapping("qnaboard_fnq/regist")
	public ModelAndView getInsert(HttpServletRequest request,QnaboardFnq qnaboardfnq) {
		logger.info("글쓰기 요청");
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		qnaboardfnq.setAdmin(admin);

		//일시키기 
		qnaboardfnqService.insert(qnaboardfnq);
		ModelAndView mav=new ModelAndView("redirect:/admin/qnaboard_fnq/list");
		return mav;
	}
	
	//상세보기 요청 처리
	@GetMapping(value = "qnaboard_fnq/detail")
	public ModelAndView getDetail(HttpServletRequest request,int qnaboardfnq_idx) {
		logger.info("상세보기 요청");
		QnaboardFnq qnaboardfnq=qnaboardfnqService.select(qnaboardfnq_idx);
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_fnq/detail");
		mav.addObject("qnaboardfnq",qnaboardfnq);
		return mav;
	}
	
	//수정폼 요청 처리
	@GetMapping("qnaboard_fnq/editform")
	public ModelAndView getEditForm(HttpServletRequest request, int qnaboardfnq_idx) {
		logger.info("수정폼  요청");
		
		QnaboardFnq qnaboardfnq=qnaboardfnqService.select(qnaboardfnq_idx);
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_fnq/editform");
		mav.addObject("qnaboardfnq",qnaboardfnq);
		return mav;
	}
	//한건 수정하기
	@PostMapping("/qnaboard_fnq/edit")
	public ModelAndView getEdit(HttpServletRequest request,QnaboardFnq qnaboardfnq) {
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		
		qnaboardfnq.setAdmin(admin);
		
		qnaboardfnqService.update(qnaboardfnq);
		
		ModelAndView mav=new ModelAndView("redirect:/admin/qnaboard_fnq/list");
		
		return mav;
	}
	
	@GetMapping("qnaboard_fnq/delform")
	public ModelAndView getDelForm(HttpServletRequest request,int qnaboardfnq_idx) {
		logger.info("삭제폼 요청");
		QnaboardFnq qnaboardfnq=qnaboardfnqService.select(qnaboardfnq_idx);
		ModelAndView mav=new ModelAndView("/admin/qnaboard_fnq/delform");
		mav.addObject("qnaboardfnq",qnaboardfnq);
		return mav;
	}
	
	//한건 삭제하기
	@PostMapping("qnaboard_fnq/del")
	public ModelAndView getDel(HttpServletRequest request,int qnaboardfnq_idx,QnaboardFnq qnaboardfnq) {
		
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		qnaboardfnq.setAdmin(admin);
		
		qnaboardfnqService.delete(qnaboardfnq_idx);
		return new ModelAndView("redirect:/admin/qnaboard_fnq/list");
	}
	
	
	
}
	

