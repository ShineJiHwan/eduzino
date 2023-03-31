package com.edu.zino.chat.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.edu.zino.chat.model.ChatService;
import com.edu.zino.domain.Member;
import com.edu.zino.domain.OrderSummary;
import com.edu.zino.domain.Teacher;
import com.edu.zino.model.root.OrderService;
import com.edu.zino.model.teacher.TeacherService;

@Controller
public class MessageController {
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private TeacherService teacherService;
	
	
	//선생님의 수강생목록 가져오기
	@GetMapping("/chat/message")
	public ModelAndView getTeacherMessage(HttpServletRequest request,@RequestParam(defaultValue = "0") int member_idx) {
		
		//로그인 하면 session에서 teacher_idx를 가져오므로 getMapping으로 가져올 필요는 없음
		//int teacher_idx = 1;
		
		HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute("member");
        
        int teacher_member_idx = member.getMember_idx();
        
        Teacher teacher = teacherService.select(teacher_member_idx);
        int teacher_idx = teacher.getTeacher_idx();
        
        //logger.info("session"+session.getAttribute("member"));
        

		
		List<OrderSummary> orderSummaryList = chatService.selectAllByTeacher(teacher_idx);
		
		
		ModelAndView mav = new ModelAndView("/teacher/chat/message");
		mav.addObject("orderSummaryList", orderSummaryList);
		mav.addObject("member_idx", member_idx);
		
		return mav;
	}
	
	//학생의 선생님목록 가져오기
	@GetMapping("/user/chat/message")
	public ModelAndView getUserMessage(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute("member");
        logger.info("session"+session.getAttribute("member"));
        
        int member_idx = member.getMember_idx();
		
		//로그인 하면 session에서 회원를 가져오므로 getMapping으로 가져올 필요는 없음
		//int member_idx = 2;
		
		List<OrderSummary> orderSummaryMemberTeacherList = orderService.selectAllByMemberTeacher(member_idx);
		
		
		ModelAndView mav = new ModelAndView("/user/chat/message");
		mav.addObject("orderSummaryMemberTeacherList", orderSummaryMemberTeacherList);
		
		return mav;
	}
	
	
}
