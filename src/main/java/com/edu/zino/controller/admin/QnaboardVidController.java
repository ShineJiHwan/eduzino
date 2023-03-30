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
import com.edu.zino.domain.QnaboardVid;
import com.edu.zino.domain.Target;
import com.edu.zino.model.admin.QnaboardFnqService;
import com.edu.zino.model.admin.QnaboardPayService;
import com.edu.zino.model.admin.QnaboardVidService;


@Controller

public class QnaboardVidController {
	@Autowired
	private QnaboardVidService qnaboardvidService;
	
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	/*qnaboard_service controller*/	
	//목록 요청 처리
	@RequestMapping(value = "qnaboard_vid/list",method =RequestMethod.GET)
	public ModelAndView getList(HttpServletRequest request) {
		logger.info("목록요청을 받음");
		List qnaboardvidList=qnaboardvidService.selectAll();
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_vid/list");
		mav.addObject("qnaboardvidList",qnaboardvidList);
		
		return mav;
	}
	
	//글쓰기 폼 요청
	@GetMapping("qnaboard_vid/registform")
	public ModelAndView getRegist(HttpServletRequest request) {
		logger.info("글쓰기폼 요청");
		return new ModelAndView("/admin/qnaboard_vid/regist");
	}
	
	//글쓰기 요청 처리
	@PostMapping("qnaboard_vid/regist")
	public ModelAndView getInsert(HttpServletRequest request,QnaboardVid qnaboardvid) {
		logger.info("글쓰기 요청");
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		qnaboardvid.setAdmin(admin);

		//일시키기 
		qnaboardvidService.insert(qnaboardvid);
		ModelAndView mav=new ModelAndView("redirect:/admin/qnaboard_vid/list");
		return mav;
	}
	
	//상세보기 요청 처리
	@GetMapping(value = "qnaboard_vid/detail")
	public ModelAndView getDetail(HttpServletRequest request,int qnaboardvid_idx) {
		logger.info("상세보기 요청");
		QnaboardVid qnaboardvid=qnaboardvidService.select(qnaboardvid_idx);
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_vid/detail");
		mav.addObject("qnaboardvid",qnaboardvid);
		return mav;
	}
	
	//수정폼 요청 처리
	@GetMapping("qnaboard_vid/editform")
	public ModelAndView getEditForm(HttpServletRequest request, int qnaboardvid_idx) {
		logger.info("수정폼  요청");
		
		QnaboardVid qnaboardvid=qnaboardvidService.select(qnaboardvid_idx);
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_vid/editform");
		mav.addObject("qnaboardvid",qnaboardvid);
		return mav;
	}
	//한건 수정하기
	@PostMapping("/qnaboard_vid/edit")
	public ModelAndView getEdit(HttpServletRequest request,QnaboardVid qnaboardvid) {
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		
		qnaboardvid.setAdmin(admin);
		
		qnaboardvidService.update(qnaboardvid);
		
		ModelAndView mav=new ModelAndView("redirect:/admin/qnaboard_vid/list");
		
		return mav;
	}
	
	@GetMapping("qnaboard_vid/delform")
	public ModelAndView getDelForm(HttpServletRequest request,int qnaboardvid_idx) {
		logger.info("삭제폼 요청");
		QnaboardVid qnaboardvid=qnaboardvidService.select(qnaboardvid_idx);
		ModelAndView mav=new ModelAndView("/admin/qnaboard_vid/delform");
		mav.addObject("qnaboardvid",qnaboardvid);
		return mav;
	}
	
	//한건 삭제하기
	@PostMapping("qnaboard_vid/del")
	public ModelAndView getDel(HttpServletRequest request,int qnaboardvid_idx,QnaboardVid qnaboardvid) {
		
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		qnaboardvid.setAdmin(admin);
		
		qnaboardvidService.delete(qnaboardvid_idx);
		return new ModelAndView("redirect:/admin/qnaboard_vid/list");
	}
	
	
	
}
	

