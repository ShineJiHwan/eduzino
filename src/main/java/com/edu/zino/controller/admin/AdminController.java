package com.edu.zino.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.edu.zino.domain.Blacklist;
import com.edu.zino.domain.Member;
import com.edu.zino.domain.Teacher;
import com.edu.zino.model.admin.AdminboardService;
import com.edu.zino.model.member.BlacklistService;
import com.edu.zino.model.member.MemberService;
import com.edu.zino.model.teacher.TeacherService;
import com.edu.zino.util.MessageUtil;

@Controller
public class AdminController {
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private  AdminboardService adminboardService;
	
	@Autowired
	private MemberService memberService;
	
    @Autowired
    private TeacherService teacherService;

    @Autowired
    private BlacklistService blacklistService;
	
	@GetMapping("/board")
	public ModelAndView getBoard(HttpServletRequest request) {
		
		List adminboardList=adminboardService.selectAll();
		
		ModelAndView mav=new ModelAndView("/admin/board/board_main");
		mav.addObject("adminboardList",adminboardList);
		return mav;
	}	
	 
	@GetMapping("/index")
	public String getIndex() {
		return "/admin/index";
	}

	/* ----------------------------------
				관리자 로그인
	------------------------------------ */

	
	@GetMapping("/login")
	public ModelAndView getLogin(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/admin/member/login");
		return mav;
	}
	
	/* ----------------------------------
	 			전체 회원 관리
	 ------------------------------------ */
	@GetMapping("/member")	//전체 회원 목록
	public ModelAndView getMember(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/admin/member/list");
		return mav;
	}
	
	@GetMapping("/member/detail")	//회원 한 명 상세보기 
	public ModelAndView getMemberDetail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/admin/member/detail");
		return mav;
	}
	

	@GetMapping("/member/blacklist")	//정지 회원 목록
	public ModelAndView getBlacklist(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/admin/member/blacklist");
		return mav;
	}

	@GetMapping("/member/blackdetail")	//정지 회원 한 명 상세보기 
	public ModelAndView getBlackDetail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/admin/member/blackdetail");
		return mav;
	}
	
	
	
	//회원->강사
    @GetMapping("/member/toteacher")
    @ResponseBody
    public ResponseEntity<Teacher> regist(@RequestParam("member_idx") String member_idx){
    	 HttpHeaders resHeaders = new HttpHeaders();
         resHeaders.add("Content-Type", "text/html;charset=UTF-8");
         logger.info(member_idx);
         
         Teacher teacher = new Teacher();
         
       //3단계: 일 시키기 -> 가입직전에,  member 내용 추가
         teacher.setMember(memberService.selectMember(Integer.parseInt(member_idx)));
         teacherService.insert(teacher);
    	
         return new ResponseEntity<Teacher>(teacher, resHeaders ,HttpStatus.OK);
    } 
    
    

    //회원->정지
        @PostMapping("/member/blacklist")
        public ResponseEntity<MessageUtil> regist(HttpServletRequest request, Blacklist blacklist){
            //3단계: 일 시키기
            blacklistService.insert(blacklist);
            MessageUtil message = new MessageUtil();
            message.setMsg("정지회원 등록 성공");

            ResponseEntity entity=new ResponseEntity<MessageUtil>(message, HttpStatus.OK);
            return entity;
        } 

        @GetMapping("/qnaboard")
        public ModelAndView getQanboard(HttpServletRequest request) {
            ModelAndView mav=new ModelAndView("/admin/qnaboard/board_main");
            return mav;
        }
	
}
