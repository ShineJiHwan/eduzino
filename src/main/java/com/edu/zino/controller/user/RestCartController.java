package com.edu.zino.controller.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.edu.zino.domain.Cart;
import com.edu.zino.domain.Member;
import com.edu.zino.domain.Subject;
import com.edu.zino.domain.Wish;
import com.edu.zino.exception.CartException;
import com.edu.zino.exception.WishException;
import com.edu.zino.model.user.CartService;
import com.edu.zino.model.user.WishService;
import com.edu.zino.util.FileManager;
import com.edu.zino.util.MessageUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping("/rest")
public class RestCartController {
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private WishService wishService;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private FileManager fileManager;
	
	//카트목록 비동기로 가져오기
	@GetMapping("/cart/list")
	public List<Cart> getCartList(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("member");
		
		//Member member=new Member();
		//member.setMember_idx(2);
		
		return cartService.selectAll(member);
	}
	
	
	
	
	//장바구니 삭제
	@DeleteMapping("/cart/cart_list")
	@ResponseBody
	public ResponseEntity<MessageUtil> delCart(HttpServletRequest request, @RequestBody Cart[] cartList){	
			
		//3단계
		cartService.delCart(cartList);
		//4단계
		MessageUtil msg = new MessageUtil();
		msg.setMsg("장바구니 삭제 성공");
		
		ResponseEntity entity = new ResponseEntity<MessageUtil>(msg,HttpStatus.OK);
		return entity;
	}
	
	//장바구니 한 건 삭제
		@DeleteMapping("/cart/list/{cart_idx}")
		public ResponseEntity<String> delOneCart(HttpServletRequest request, @PathVariable int cart_idx){
			//3단계
			logger.info("삭제할 cart_idx"+cart_idx);
			cartService.delOneCart(cart_idx);
			
			//4단계
			ResponseEntity<String> entity = new ResponseEntity<String>("성공",HttpStatus.OK);
			return entity;
		}
	
	//order_id 만들기
	@GetMapping("/cart/orderid")
	public ResponseEntity<String> getOrderId(HttpServletRequest request){
		String orderId=fileManager.getRealTime();
		ResponseEntity entity = new ResponseEntity<String>(orderId,HttpStatus.OK);
		return entity;
	}
	
	
	/*---------------찜--------------------*/
	//찜목록 비동기로 가져오기
	@GetMapping("/cart/wishlist")
	@ResponseBody
	public List<Cart> getWishList(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("member");
		
		//Member member=new Member();
		//member.setMember_idx(2);
		return wishService.selectAll(member);
	}
	
	//기본 찜 등록
	@PostMapping("/cart/regist_wish")
	public ResponseEntity<MessageUtil> registWish(HttpServletRequest request,  Wish wish){	
		//3단계
		wishService.insert(wish);
			
		//4단계
		MessageUtil msg = new MessageUtil();
		msg.setMsg("찜 등록 성공");
		
		ResponseEntity entity = new ResponseEntity<MessageUtil>(msg,HttpStatus.OK);
		return entity;
	}	
	
	//찜목록 장바구니에 등록 > 여러 건 등록이 가능하도록 배열로 받는다
	@PostMapping("/cart/wishTocart")
	@ResponseBody
	public ResponseEntity<String> toCart(HttpServletRequest request, @RequestBody Wish[] wishList){
		Cart[] cartList=new Cart[wishList.length];
		
		//세션에서 해당 멤버의 정보를 가져온다 
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("member");
	
		//여러 건이라 반복문을 돌린다
		for(int i=0; i<wishList.length; i++) {
			Wish wish = new Wish();
			wish= wishList[i];
			
			Subject subject = new Subject();
			subject.setSubject_idx(wish.getSubject().getSubject_idx());
						
			Cart cart = new Cart();
			cart.setSubject(subject);
			cart.setMember(member);
			
			cartList[i]=cart;
		}		
			
		//3단계 > service에서 insert 작업 진행한다
		cartService.regist(cartList);
		//logger.info("cartList는 "+cartList);
		
		//4단계 > 원하는 메시지를 반환한다
		MessageUtil msg = new MessageUtil();
		msg.setMsg("장바구니 등록 성공");
		
		ResponseEntity entity = new ResponseEntity<MessageUtil>(msg,HttpStatus.OK);
		return entity;
	}
	
	//찜목록 삭제하기
	@DeleteMapping("/cart/wish_list")
	@ResponseBody
	public ResponseEntity<MessageUtil> delWish(HttpServletRequest request, @RequestBody Wish[] wishList){	
				
		//3단계
		wishService.delWish(wishList);

		//4단계
		MessageUtil msg = new MessageUtil();
		msg.setMsg("찜 삭제 성공");
		
		ResponseEntity entity = new ResponseEntity<MessageUtil>(msg,HttpStatus.OK);
		return entity;
	}
	
	/*-----------exception-------------------*/
	@ExceptionHandler(CartException.class)
	public ResponseEntity<MessageUtil> handle(CartException e){
		
		MessageUtil msg = new MessageUtil();
		msg.setMsg("장바구니 작업 실패");
		
		ResponseEntity entity = new ResponseEntity<MessageUtil>(msg,HttpStatus.OK);
		return entity;
	}
	
	@ExceptionHandler(WishException.class)
	public ResponseEntity<MessageUtil> handle(WishException e){
		
		MessageUtil msg = new MessageUtil();
		msg.setMsg("찜 작업 실패");
		
		ResponseEntity entity = new ResponseEntity<MessageUtil>(msg,HttpStatus.OK);
		return entity;
	}
	
	
}
