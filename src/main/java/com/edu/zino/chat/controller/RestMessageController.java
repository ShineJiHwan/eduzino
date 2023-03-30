package com.edu.zino.chat.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.edu.zino.chat.model.ChatService;
import com.edu.zino.chat.model.MessageService;
import com.edu.zino.domain.Chat;
import com.edu.zino.domain.Member;
import com.edu.zino.domain.Message;
import com.edu.zino.domain.Teacher;
import com.edu.zino.model.teacher.TeacherService;
import com.edu.zino.util.MessageUtil;


@RestController
@RequestMapping("/rest")
public class RestMessageController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private TeacherService teacherService;
	
	//강사가 채팅방 조회
	@PostMapping("/teacher/chat/message/selectAll")
	public List<Chat> selectAllTeacher(HttpServletRequest request, @RequestBody Chat chat){
		logger.info("chat is "+chat);
		
		HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute("member");
        
        int teacher_member_idx = member.getMember_idx();
        
        Teacher teacher = teacherService.select(teacher_member_idx);
        member.setTeacher(teacher);
		
        /*
		//로그인 하면 session에서 로그인 정보를 가져오므로 get으로 가져올 필요는 없음
		Member member = new Member();
		logger.info("선생님이 방 요청시 chat.getMember_teacher() is "+chat.getMember_teacher());
			//선생님이 방 생성 요청 시
			int member_teacher_idx = 1;
			member.setMember_idx(member_teacher_idx);
		*/
			chat.setMember_teacher(member);
	
	
		logger.info("선생님이 방 요청시  chat2 is "+chat);
		
		List<Chat> chatList = chatService.selectByTeacher(chat); //채팅방 전체 조회하기
		
		return chatList;
	}
	
	//강사가 채팅방 생성
	@PostMapping("/teacher/chat/message")
	public Chat insertTeacher(HttpServletRequest request, @RequestBody Chat chat){
		/*
		//로그인 하면 session에서 로그인 정보를 가져오므로 get으로 가져올 필요는 없음
		Member member = new Member();
		logger.info("선생님이 방 요청시 chat.getMember_teacher() is "+chat.getMember_teacher());
			//선생님이 방 생성 요청 시
			int member_teacher_idx = 1;
			member.setMember_idx(member_teacher_idx);
			*/
		
		//logger.info("member_idx is "+member_idx);
		logger.info("chat is "+chat);
		
		HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute("member");
        
        int teacher_member_idx = member.getMember_idx();
        
        Teacher teacher = teacherService.select(teacher_member_idx);
        member.setTeacher(teacher);
		

		
			chat.setMember_teacher(member);
	
		logger.info("선생님이 방 요청시  chat2 is "+chat);
		
		
		Chat chatRoom= chatService.select(chat); //채팅방이 있는지 없는 지 판단하기
		logger.info("선생님의 채팅방이 있나요? "+chatRoom);
		
		//3단계
		if(chatRoom == null && chat.getMember().getMember_idx() !=0 && chat.getMember_teacher().getMember_idx() != 0) {
			chatService.insert(chat); //채팅방 생성하기			
		}
		
		return chatRoom;
	}
	
	//유저가 채팅방 조회
	@PostMapping("/user/chat/message/selectAll")
	public List<Chat>selectAllMember(HttpServletRequest request, @RequestBody Chat chat){
	
		
		logger.info("유저가 선택한 chat is "+chat);
		
		HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute("member");
		
		/*
		//로그인 하면 session에서 로그인 정보를 가져오므로 get으로 가져올 필요는 없음
		Member member = new Member();
		logger.info("유저가 선택한 chat.getMember() is "+chat.getMember());

			//수강생이 방 생성 요청 시
			int member_idx = 2;
			member.setMember_idx(member_idx);
			*/
			
			chat.setMember(member);
			
			logger.info("유저가 선택한  is "+chat);
		
			List<Chat> chatList = chatService.selectByStudent(chat); //채팅방 전체 조회하기
		
		return chatList;
	}
	
	//유저가 채팅방 생성
	@PostMapping("/user/chat/message")
	public Chat insertMember(HttpServletRequest request, @RequestBody Chat chat){
	
		
		logger.info("유저가 선택한 chat is "+chat);
		
		HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute("member");
		
		/*
		//로그인 하면 session에서 로그인 정보를 가져오므로 get으로 가져올 필요는 없음
		Member member = new Member();
		logger.info("유저가 선택한 chat.getMember() is "+chat.getMember());

			//수강생이 방 생성 요청 시
			int member_idx = 2;
			member.setMember_idx(member_idx);
			*/
			
			chat.setMember(member);
			
			logger.info("유저가 선택한  is "+chat);
		
		
		
		Chat chatRoom= chatService.select(chat); //채팅방이 있는지 없는 지 판단하기
		logger.info("유저의 채팅방이 있나요? "+chatRoom);
		
		//3단계
		if(chatRoom == null && chat.getMember().getMember_idx() !=0 && chat.getMember_teacher().getMember_idx() != 0) {
			chatService.insert(chat); //채팅방 생성하기			
		}
		
		
		return chatRoom;
	}
	
	//메세지 조회
	@GetMapping("/chat/chatmessage/{chat_idx}")
	public List<Message> selectChatMessages(HttpServletRequest request, @PathVariable int chat_idx){
		
		logger.info("메세지목록 "+chat_idx);
		
		Message message = new Message();
		Chat chat = new Chat();
		chat.setChat_idx(chat_idx);
		message.setChat(chat);
		
		List<Message> messageList = messageService.selectChat(message);
		
		return messageList;
	}
	
	//채팅방 읽음표시 체크
	@PostMapping("/chat/chatmessage/check")
	@ResponseBody
	public  ResponseEntity<MessageUtil> updateCheck(HttpServletRequest request,@RequestBody List<Message> messages){
		
		logger.info("읽음표시 체크 message "+messages);
		messageService.updateCheck(messages);
		
		
		MessageUtil messageUtil = new MessageUtil();
		messageUtil.setMsg("읽음표시 업데이트 성공");
		
		ResponseEntity entity=new ResponseEntity<MessageUtil>(messageUtil, HttpStatus.OK);
		
		return entity;
	}
	

}
