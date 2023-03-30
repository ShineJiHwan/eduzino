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
import com.edu.zino.domain.QnaboardPay;
import com.edu.zino.domain.Target;
import com.edu.zino.model.admin.QnaboardFnqService;
import com.edu.zino.model.admin.QnaboardPayService;


@Controller

public class QnaboardPayController {
	@Autowired
	private QnaboardPayService qnaboardpayService;
	
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	/*qnaboard_service controller*/	
	//목록 요청 처리
	@RequestMapping(value = "qnaboard_pay/list",method =RequestMethod.GET)
	public ModelAndView getList(HttpServletRequest request) {
		logger.info("목록요청을 받음");
		List qnaboardpayList=qnaboardpayService.selectAll();
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_pay/list");
		mav.addObject("qnaboardpayList",qnaboardpayList);
		
		return mav;
	}
	
	//글쓰기 폼 요청
	@GetMapping("qnaboard_pay/registform")
	public ModelAndView getRegist(HttpServletRequest request) {
		logger.info("글쓰기폼 요청");
		return new ModelAndView("/admin/qnaboard_pay/regist");
	}
	
	//글쓰기 요청 처리
	@PostMapping("qnaboard_pay/regist")
	public ModelAndView getInsert(HttpServletRequest request,QnaboardPay qnaboardpay) {
		logger.info("글쓰기 요청");
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		qnaboardpay.setAdmin(admin);

		//일시키기 
		qnaboardpayService.insert(qnaboardpay);
		ModelAndView mav=new ModelAndView("redirect:/admin/qnaboard_pay/list");
		return mav;
	}
	
	//상세보기 요청 처리
	@GetMapping(value = "qnaboard_pay/detail")
	public ModelAndView getDetail(HttpServletRequest request,int qnaboardpay_idx) {
		logger.info("상세보기 요청");
		QnaboardPay qnaboardpay=qnaboardpayService.select(qnaboardpay_idx);
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_pay/detail");
		mav.addObject("qnaboardpay",qnaboardpay);
		return mav;
	}
	
	//수정폼 요청 처리
	@GetMapping("qnaboard_pay/editform")
	public ModelAndView getEditForm(HttpServletRequest request, int qnaboardpay_idx) {
		logger.info("수정폼  요청");
		
		QnaboardPay qnaboardpay=qnaboardpayService.select(qnaboardpay_idx);
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_pay/editform");
		mav.addObject("qnaboardpay",qnaboardpay);
		return mav;
	}
	//한건 수정하기
	@PostMapping("/qnaboard_pay/edit")
	public ModelAndView getEdit(HttpServletRequest request,QnaboardPay qnaboardpay) {
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		
		qnaboardpay.setAdmin(admin);
		
		qnaboardpayService.update(qnaboardpay);
		
		ModelAndView mav=new ModelAndView("redirect:/admin/qnaboard_pay/list");
		
		return mav;
	}
	
	@GetMapping("qnaboard_pay/delform")
	public ModelAndView getDelForm(HttpServletRequest request,int qnaboardpay_idx) {
		logger.info("삭제폼 요청");
		QnaboardPay qnaboardpay=qnaboardpayService.select(qnaboardpay_idx);
		ModelAndView mav=new ModelAndView("/admin/qnaboard_pay/delform");
		mav.addObject("qnaboardpay",qnaboardpay);
		return mav;
	}
	
	//한건 삭제하기
	@PostMapping("qnaboard_pay/del")
	public ModelAndView getDel(HttpServletRequest request,int qnaboardpay_idx,QnaboardPay qnaboardpay) {
		
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		qnaboardpay.setAdmin(admin);
		
		qnaboardpayService.delete(qnaboardpay_idx);
		return new ModelAndView("redirect:/admin/qnaboard_pay/list");
	}
	
	
	
}
	

