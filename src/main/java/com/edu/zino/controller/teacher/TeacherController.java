package com.edu.zino.controller.teacher;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.edu.zino.domain.Member;
import com.edu.zino.domain.OrderSummary;
import com.edu.zino.domain.Subject;
import com.edu.zino.domain.Teacher;
import com.edu.zino.model.root.OrderService;
import com.edu.zino.model.teacher.SubjectService;
import com.edu.zino.model.teacher.TeacherService;

//강사페이지 관련
@Controller
public class TeacherController {
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private SubjectService subjectService;
	
	@Autowired
	private TeacherService teacherService;
	
	
	@GetMapping("/index")
	public ModelAndView getMain(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/teacher/index");
		return mav;
	}
	
	@GetMapping("/default")
	public ModelAndView getDefault(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/teacher/default");
		return mav;
	}
	@GetMapping("/board")
	public ModelAndView getBoard(HttpServletRequest request) {
		ModelAndView mav=new ModelAndView("/teacher/board/board_main");
		return mav;
	}
	
	//매출, 정산내역
	@GetMapping("/salescaculate/sales")
	public ModelAndView getSales(HttpServletRequest request) {
		HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute("member");
        
        int teacher_member_idx = member.getMember_idx();
        
        Teacher teacher = teacherService.select(teacher_member_idx);
        request.getSession().setAttribute("teacher", teacher);
		ModelAndView mav = new ModelAndView("/teacher/salescaculate/sales");
		return mav;
	}
	
	//수강생 관리_검색시 사용
	@RequestMapping(value="/student/studentManagement", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getStudentManagement(HttpServletRequest request) {
		
		/*
		//로그인 하면 session에서 teacher_idx를 가져오므로 getMapping으로 가져올 필요는 없음
		int teacher_idx = 1;
		*/
		
		HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute("member");
        
        int teacher_member_idx = member.getMember_idx();
        
        Teacher teacher = teacherService.select(teacher_member_idx);
        int teacher_idx = teacher.getTeacher_idx();
        
		
		List<OrderSummary> orderSummaryList = null;

		List<Subject> subjectList = subjectService.selectAllByTeacher(teacher_idx); //과목명전체조회
		
		logger.info("subjectList"+subjectList);

		String subject_idx = request.getParameter("subject_idx"); //검색 시 받는 과목idx
		String member_nickname = request.getParameter("member_nickname"); //검색 시 받는 닉네임
		
		logger.info("검색시 subject_idx"+subject_idx);
		logger.info("검색시 member_nickname"+member_nickname);
		
		//검색시 사용
		
		logger.info("subject_idx"+subject_idx);
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("teacher_idx", teacher_idx);
		searchMap.put("subject_idx", subject_idx);				
		searchMap.put("member_nickname", member_nickname);
		
		logger.info("searchMap 주문목록 param"+searchMap);

		
		//검색하기 : subject_idx와 member_nickname이 null일땐 전체 조회
		orderSummaryList = orderService.selectAllBySearch(searchMap);
		
		logger.info("수강생 목록 "+orderSummaryList);
		
		ModelAndView mav = new ModelAndView("/teacher/student/studentManagement");
		mav.addObject("subjectList", subjectList); //전체과목명
		mav.addObject("orderSummaryList", orderSummaryList); //수강생들

		
		orderSummaryList = orderService.selectAllBySearch(searchMap);
		
		
		return mav;
	}
	


}
