package com.edu.zino.controller.user;

import java.io.IOException;
import java.net.URI;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.edu.zino.domain.Cart;
import com.edu.zino.domain.Member;
import com.edu.zino.exception.CartException;
import com.edu.zino.exception.OrderSummaryException;
import com.edu.zino.model.root.OrderService;
import com.edu.zino.util.MessageUtil;

@Controller
public class OrderController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private OrderService orderService;
	
	/*--------- 주문내역-----------------*/
	
	//회원별 주문내역 가져오기
	@GetMapping("/order/orderlist")
	public ModelAndView getOrderList(HttpServletRequest request, Member member) {
		
		HttpSession session = request.getSession();
		Member member1= (Member)session.getAttribute("member");
		
		//임시 member데이터
		//Member member1 = new Member();
		//member1.setMember_idx(2);
		
		//3단계
		List<Member> orderList = orderService.selectAllByMember(member1);
		//orderDetailService.selectAll(orderSummary)
		logger.info("orderList "+orderList.toString());
		//4단계
		ModelAndView mav = new ModelAndView("/user/order/orderList");
		mav.addObject("orderList",orderList);
		return mav;
	}
	
	
	/*--------- 포인트------------------*/
	
	//포인트 내역 보여주기
	@GetMapping("/order/point")
	public ModelAndView getPointList() {
		return new ModelAndView("/user/order/point");
	}
	
	
	
	/*-----------exception-------------------*/
	@ExceptionHandler(OrderSummaryException.class)
	public ResponseEntity<MessageUtil> handle(OrderSummaryException e){
		
		MessageUtil msg = new MessageUtil();
		msg.setMsg("결제내역 작업 실패");
		
		ResponseEntity entity = new ResponseEntity<MessageUtil>(msg,HttpStatus.OK);
		return entity;
	}
}
