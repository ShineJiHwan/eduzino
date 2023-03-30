package com.edu.zino.aop;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.edu.zino.exception.AdminException;



@ControllerAdvice(annotations = Controller.class)
public class UserGlobalException {
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@ExceptionHandler(AdminException.class)
	public ModelAndView handle(AdminException e) {
		logger.info("관리자 글로벌 예외 호출");
		
		ModelAndView mav = new ModelAndView("user/error/result");
		mav.addObject("e", e);
		return mav;
	}
	
}