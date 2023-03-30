package com.edu.zino.aop;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.edu.zino.exception.AdminException;



public class AdminLoginCheckAdvice {
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	public Object sessionCheck(ProceedingJoinPoint joinPoint) throws AdminException, Throwable{
		Object result=null;   //proceed() 후 반환되는 객체를 담기위한 변수 (ModelAndView, String...)
		
		Class targetClass=joinPoint.getTarget().getClass();
		Object[] args=joinPoint.getArgs();//매개변수를 배열로 반환함..
		
		logger.info("호출하려는 타겟 클래스는 "+targetClass.getName());
		logger.info("호출하려는 타겟 메서드의 매개변수의 수는 "+args.length);
		
		//타겟메서드에서 HttpServletRequest 추출하여 session에 관리자 객체가 들어있는지 체크하기 
		HttpServletRequest request=null;
		HttpSession session=null;
		
		for(int i=0;i<args.length;i++) {
			if(args[i] instanceof HttpServletRequest) {
				request = (HttpServletRequest)args[i];
			}
		}
		
		//로그인을 체크해야 되는 경우와, 그냥 보내야 하는경우를 나눈다 
		String uri=request.getRequestURI(); 
		
		if(
			uri.equals("/admin/rest/login/admin") ||  //비동기 로그인 요청시 제외
			uri.equals("/admin/member/login") //동기방식으로 로그인 요청이 들어올때 제외 
		) {
			result=joinPoint.proceed();
		}else {
			//로그인이 필요한 서비스에서만 아래의 코드들이 수행되어야 한다..
			session = request.getSession();
			if(session.getAttribute("admin")==null) {
				logger.info("aop 에 의한 로그인 체크 : 세션없음");
				throw new AdminException("로그인이 필요한 서비스입니다");
			}else {
				result=joinPoint.proceed(); //로그인한 사람은 가던 길 가게...
			}
		}
		
		return result;
	}
	
}