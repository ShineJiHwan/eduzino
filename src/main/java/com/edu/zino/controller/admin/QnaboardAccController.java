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
import com.edu.zino.domain.QnaboardAcc;
import com.edu.zino.domain.QnaboardPay;
import com.edu.zino.model.admin.QnaboardAccService;
import com.edu.zino.model.admin.QnaboardPayService;

@Controller
public class QnaboardAccController {
	
	@Autowired
	private QnaboardAccService qnaboardaccService;
	
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	/*qnaboard_service controller*/	
	//목록 요청 처리
	@RequestMapping(value = "qnaboard_acc/list",method =RequestMethod.GET)
	public ModelAndView getList(HttpServletRequest request) {
		logger.info("목록요청을 받음");
		List qnaboardaccList=qnaboardaccService.selectAll();
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_acc/list");
		mav.addObject("qnaboardaccList",qnaboardaccList);
		
		return mav;
	}
	
	//글쓰기 폼 요청
	@GetMapping("qnaboard_acc/registform")
	public ModelAndView getRegist(HttpServletRequest request) {
		logger.info("글쓰기폼 요청");
		return new ModelAndView("/admin/qnaboard_acc/regist");
	}
	
	//글쓰기 요청 처리
	@PostMapping("qnaboard_acc/regist")
	public ModelAndView getInsert(HttpServletRequest request,QnaboardAcc qnaboardacc) {
		logger.info("글쓰기 요청");
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		qnaboardacc.setAdmin(admin);

		//일시키기 
		qnaboardaccService.insert(qnaboardacc);
		ModelAndView mav=new ModelAndView("redirect:/admin/qnaboard_acc/list");
		return mav;
	}
	
	//상세보기 요청 처리
	@GetMapping(value = "qnaboard_acc/detail")
	public ModelAndView getDetail(HttpServletRequest request,int qnaboardacc_idx) {
		logger.info("상세보기 요청");
		QnaboardAcc qnaboardacc=qnaboardaccService.select(qnaboardacc_idx);
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_acc/detail");
		mav.addObject("qnaboardacc",qnaboardacc);
		return mav;
	}
	
	//수정폼 요청 처리
	@GetMapping("qnaboard_acc/editform")
	public ModelAndView getEditForm(HttpServletRequest request, int qnaboardacc_idx) {
		logger.info("수정폼  요청");
		
		QnaboardAcc qnaboardacc=qnaboardaccService.select(qnaboardacc_idx);
		
		ModelAndView mav=new ModelAndView("/admin/qnaboard_acc/editform");
		mav.addObject("qnaboardacc",qnaboardacc);
		return mav;
	}
	//한건 수정하기
	@PostMapping("/qnaboard_acc/edit")
	public ModelAndView getEdit(HttpServletRequest request,QnaboardAcc qnaboardacc) {
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		
		qnaboardacc.setAdmin(admin);
		
		qnaboardaccService.update(qnaboardacc);
		
		ModelAndView mav=new ModelAndView("redirect:/admin/qnaboard_acc/list");
		
		return mav;
	}
	
	@GetMapping("qnaboard_acc/delform")
	public ModelAndView getDelForm(HttpServletRequest request,int qnaboardacc_idx) {
		logger.info("삭제폼 요청");
		QnaboardAcc qnaboardacc=qnaboardaccService.select(qnaboardacc_idx);
		ModelAndView mav=new ModelAndView("/admin/qnaboard_acc/delform");
		mav.addObject("qnaboardacc",qnaboardacc);
		return mav;
	}
	
	//한건 삭제하기
	@PostMapping("qnaboard_acc/del")
	public ModelAndView getDel(HttpServletRequest request,int qnaboardacc_idx,QnaboardAcc qnaboardacc) {
		
		Admin admin=new Admin();
		admin.setAdmin_idx(1);
		qnaboardacc.setAdmin(admin);
		
		qnaboardaccService.delete(qnaboardacc_idx);
		return new ModelAndView("redirect:/admin/qnaboard_acc/list");
	}
	

}
