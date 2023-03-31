package com.edu.zino.controller.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.edu.zino.domain.Birthday;
import com.edu.zino.domain.Email;
import com.edu.zino.domain.Member;
import com.edu.zino.domain.ProfilePhoto;
import com.edu.zino.domain.Sns;
import com.edu.zino.domain.Teacher;
import com.edu.zino.model.member.MemberService;
import com.edu.zino.model.member.SnsService;
import com.edu.zino.model.teacher.TeacherService;
import com.edu.zino.snslogin.GoogleLogin;
import com.edu.zino.snslogin.GoogleOAuthToken;
import com.edu.zino.snslogin.KaKaoLogin;
import com.edu.zino.snslogin.KakaoOAuthToken;
import com.edu.zino.snslogin.NaverLogin;
import com.edu.zino.snslogin.NaverOAuthToken;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

//회원관 관련된 요청을 처리하는 하위 컨트롤러 
@Controller
public class MemberController {
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	//@Autowired
	//private SnsSer -vice snsService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private SnsService snsService;
	
	@Autowired
	private GoogleLogin googleLogin;
	 
	@Autowired
	private KaKaoLogin kakaoLogin;
	
	@Autowired
	private NaverLogin naverLogin;
	
	@Autowired
	private TeacherService teacherService;
	
	//회원가입, 로그인 폼 요청처리
	@GetMapping("/member/loginform")
	public ModelAndView getLoginForm(HttpServletRequest request) {
		
		return new ModelAndView("user/member/loginform");
	}
	
	//로그아웃 처리
	@GetMapping("/member/logout")
	public ModelAndView getLogout(HttpServletRequest request) {
		logger.info("logout 요청, 세션 주기기");

        HttpSession session = request.getSession();
        session.invalidate();

        ModelAndView mav = new ModelAndView("redirect:/");
        return mav;
	}
	
	
	/*-----------------------
	 *     구글 로그인 콜백 
	--------------------------*/
		@GetMapping("/sns/google/callback")
		public ModelAndView googleCallback(HttpServletRequest request, HttpSession session) {
			String code = request.getParameter("code");
			logger.info("구글에서 발급된 코드는 "+code);
			
			//구글이 넘겨준 code와 내 계정이 보유한 client_id 및 client_secret을 조합하여 구글 서버측에 token 발급을 요청해야한다
			//이때 우리 스프링 서버는 상대적으로 클라이언트가 된다
			//token은 회원정보에 접근할 수 잇는 증명서 같은 개념임.. 
			/*--------------------------------------------------------------
			 * 1) 토큰 취득을 위한 POST 헤더와 바디 구성하기
			 ----------------------------------------------------------------*/
			String url = googleLogin.getToken_request_url();
			
			//바디(헤더)의 파라미터 구성하기 <파라미터명, 파라미터값>
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
			params.add("code", code);
			params.add("client_id", googleLogin.getClient_id());
			params.add("client_secret", googleLogin.getClient_secret());
			params.add("redirect_uri", googleLogin.getRedirect_uri());
			params.add("grant_type", googleLogin.getGrant_type());
			
			//post 방식의 헤더 (application/x-www-form-urlencoded)
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type",  "application/x-www-form-urlencoded");
			
			//머리와 몸 합치기
			HttpEntity httpEntity = new HttpEntity(params, headers);
			
			//요청시도를 위한 객체생성, 비동기 방식의 요청을 위한 객체
			RestTemplate restTemplate=new RestTemplate();
			ResponseEntity<String> responseEntity= restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class); //

			/*--------------------------------------------------------------
			 * 2) 토큰 요청 후 ResponseEntitu로부터 토큰 꺼내기 (String에 불과하므로)
			 ----------------------------------------------------------------*/
			String body = responseEntity.getBody();
			logger.info("구글에서 넘겨받은 응답정보" + body);
			
			//json으로 되어있는 문자열을 파싱하여, 자바의 객체로 옮겨담자
			ObjectMapper objectMapper = new ObjectMapper();
			GoogleOAuthToken oAuthToken = null;
			
			try {
				oAuthToken=objectMapper.readValue(body, GoogleOAuthToken.class);
				
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			
			//oAuthToken 안의 토큰을 이용하여 회원정보에 접근
			/*--------------------------------------------------------------
			 * 3) 토큰을 이용하여 회원정보에 접근 
			 ----------------------------------------------------------------*/
			String userinfo_url=googleLogin.getUserinfo_url();
			
			//GET방식요청 구성
			HttpHeaders headers2 = new  HttpHeaders();
			headers2.add("Authorization", "Bearer "+oAuthToken.getAccess_token()); //"Bearer " 한 칸 띄워야 함!!
			HttpEntity entity=new HttpEntity(headers2);
			
			//비동기 객체를 이용한 GET 요청
			RestTemplate restTemplate2 = new RestTemplate();
			ResponseEntity <String> userEntity = restTemplate2.exchange(userinfo_url, HttpMethod.GET, entity, String.class);
			
			String userBody = userEntity.getBody();
			logger.info("구글에서 넘겨받은 회원정보" + userBody);
			/*{
				  "id": "103950560430611753976",     --------------db 설계시 저장해둬야 함 -> 중복된 id인지 판단 할 수 있어야 함 
				  "email": "dokyy1226@gmail.com",
				  "verified_email": true,
				  "family_name": "an",
				  "picture": "https://lh3.googleusercontent.com/a/AGNmyxZTDDHj36GZyjxpfVRdbLTsnmYRUcNxDMbLs_A1=s96-c",
				  "locale": "en"
				}
			 */
			HashMap<String, Object> userMap = new HashMap<String, Object>();
			
			//사용자 정보 추출하기
			ObjectMapper objectMapper2 = new ObjectMapper();
			try {
				userMap = objectMapper2.readValue(userBody, HashMap.class);
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}

//------------내가 알고 싶어하는 정보 미리 받아두기  : id, nickname, email, profilePhoto ------------
			String id=(String)userMap.get("id");	
			String nickname=(String)userMap.get("name");
			String picture=(String)userMap.get("picture");
			
			logger.info("id : " + id);						//id : 100448809265993600221
			logger.info("nickname : "+ nickname);			//nickname : Do A	
			logger.info("picture : "+ picture);				//picture : https://lh3.googleusercontent.com/a/AGNmyxYvutj-Jj1vA2C8YHcEVWdOKiPJh3N7fv-14MhY=s96-c
			//logger.info("email : "+ email);				//email : asy118@hanmail.net
			
			
//------------------------------db에 들어가는 타이밍------------------------------------------------------------			
			//member에 대한 고유 id 조희 : 회원인지 아닌지 따져보기 위해서 
			Member member = memberService.selectById(id);
			
			logger.info("db들가는 타이밍"+member);
			
			if(member==null) {
			//회원여부를 판단. 이미 db에 이 회원의 식별 고유 id가 존재할 경우 회원가입을 처리해주자 (서비스의 insert) 세션에 담자 
				
				member = new Member();
				member.setMember_id(id);		//고유id 가져오기 
				member.setMember_nickname(nickname);	//닉네임 가져오기 
				
				//---여기서 넣어주려고 객체를 가지고 왔음---- 
				Email email = new Email();
				email.setEmail_addr((String)userMap.get("email"));	//메일 가져오기
				
				
				ProfilePhoto profilePhoto = new ProfilePhoto();
				profilePhoto.setProfile_photo(picture);		//프사 picture로 가져오기 
				
				
				Sns sns = snsService.selectByIdx(1);
				member.setSns(sns);		//sns유형 담기
				member.setEmail(email);
				member.setProfilePhoto(profilePhoto);
				 
				//정보 출력해보기
				logger.info("넣을 고유 id : " + id);
				logger.info("넣을 nickname : " + nickname);
				logger.info("넣을 메일주소 : " + email);
				logger.info("넣을 프로필사진 : " + profilePhoto);
				logger.info("넣을 sns_idx : "+sns);
				
				//다 채워졌으면 이제 서비스에게 일을 시킴 -> 여길 지나면 member_idx가 생성됨
				memberService.insert(member);
				
			} else{
				member=memberService.selectById(id);
				//정보 출력해보기
			}
			
			//세션에 담기 (자동 로그인 할 수 있게)
			session.setAttribute("member", member);
		
			//완료하면 메인으로 돌아가기 
			ModelAndView mav = new ModelAndView("redirect:/");
			
			return mav;
		}

		/*-----------------------
		 *     카카오 로그인 콜백 
		--------------------------*/
		@GetMapping("/sns/kakao/callback")
		public ModelAndView kakaoCallback(HttpServletRequest request, HttpSession session) {
			String code = request.getParameter("code");
			logger.info("카카오에서 발급된 코드는 "+code); 
			//카카오에서 발급된 코드는 5BbP45CUMA8Rp1FOzTbevhdxAJl3iyZ0uJM_Uhow8zBbJ7eBCpNlknWiDBH2EAaPZeTaogo9dRoAAAGG2QglXg
			
			/*--------------------------------------------------------------
			 * 1) 토큰 취득을 위한 POST 헤더와 바디 구성하기
			 ----------------------------------------------------------------*/
			String url = kakaoLogin.getToken_request_url();
			
			//바디(헤더)의 파라미터 구성하기 <파라미터명, 파라미터값>
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
			params.add("code", code);
			params.add("client_id", kakaoLogin.getClient_id());
			params.add("redirect_uri", kakaoLogin.getRedirect_uri());
			params.add("grant_type", kakaoLogin.getGrant_type());
			
			//post 방식의 헤더 (application/x-www-form-urlencoded)
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type",  "application/x-www-form-urlencoded"); 	//** . 아니고 - 로 구분
			
			//머리와 몸 합치기
			HttpEntity httpEntity = new HttpEntity(params, headers);
			
			//요청시도를 위한 객체생성, 비동기 방식의 요청을 위한 객체
			RestTemplate restTemplate=new RestTemplate();
			ResponseEntity<String> responseEntity= restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class); //
			

			/*--------------------------------------------------------------
			 * 2) 토큰 요청 후 ResponseEntitu로부터 토큰 꺼내기 (String에 불과하므로)
			 ---------------------------------------------------------------*/
			String body = responseEntity.getBody();
			logger.info("카카오에서 넘겨받은 응답정보" + body);
			/*카카오에서 넘겨받은 응답정보{
			"access_token":"yXqXjUp07S4QNq--Pyy2aDINVKOqjWR_94qWb2E9CisNHwAAAYbZZN0_",
			"token_type":"bearer",
			"refresh_token":"wKr55eEqe-iaZ2ooob34Vr67hyofHGlXZDMtLU9WCisNHwAAAYbZZN09",
			"expires_in":21599,
			"scope":"age_range account_email profile_image gender profile_nickname",
			"refresh_token_expires_in":5183999}
			*/
			
			//json으로 되어있는 문자열을 파싱하여, 자바의 객체로 옮겨담자
			ObjectMapper objectMapper = new ObjectMapper();
			KakaoOAuthToken oAuthToken = null;
			
			try {
				oAuthToken=objectMapper.readValue(body, KakaoOAuthToken.class);
				
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			
			//oAuthToken 안의 토큰을 이용하여 회원정보에 접근
			/*--------------------------------------------------------------
			 * 3) 토큰을 이용하여 회원정보에 접근 
			 ----------------------------------------------------------------*/
			String userinfo_url=kakaoLogin.getUserinfo_url();
			
			//GET방식요청 구성
			HttpHeaders headers2 = new  HttpHeaders();
			headers2.add("Authorization", "Bearer "+oAuthToken.getAccess_token()); //"Bearer " 한 칸 띄워야 함!!
			HttpEntity entity=new HttpEntity(headers2);
			
			//비동기 객체를 이용한 GET 요청
			RestTemplate restTemplate2 = new RestTemplate();
			ResponseEntity <String> userEntity = restTemplate2.exchange(userinfo_url, HttpMethod.GET, entity, String.class);
			
			String userBody = userEntity.getBody();
			logger.info("카카오에서 넘겨받은 회원정보" + userBody);
			/*
			 * {"id":2704115905,
				"connected_at":"2023-03-13T05:15:12Z",
				"properties":{"nickname":"景","profile_image":"http://k.kakaocdn.net/dn/hd5rM/btrQsGbRPNK/8TCCdKlr5eJR3q9Bv3nJyK/img_640x640.jpg",
				"thumbnail_image":"http://k.kakaocdn.net/dn/hd5rM/btrQsGbRPNK/8TCCdKlr5eJR3q9Bv3nJyK/img_110x110.jpg"},
				"kakao_account":{"profile_nickname_needs_agreement":false,
				"profile_image_needs_agreement":false,
				"profile":{"nickname":"景",
				"thumbnail_image_url":"http://k.kakaocdn.net/dn/hd5rM/btrQsGbRPNK/8TCCdKlr5eJR3q9Bv3nJyK/img_110x110.jpg",
				"profile_image_url":"http://k.kakaocdn.net/dn/hd5rM/btrQsGbRPNK/8TCCdKlr5eJR3q9Bv3nJyK/img_640x640.jpg",
				"is_default_image":false},
				"has_email":true,
				"email_needs_agreement":false,
				"is_email_valid":true,
				"is_email_verified":true,"email":"asy118@hanmail.net",
				"has_age_range":true,
				"age_range_needs_agreement":false,
				"age_range":"30~39",
				"has_gender":true,
				"gender_needs_agreement":false,
				"gender":"female"}}
			 */
			
			HashMap<String, Object> userMap = new HashMap<String, Object>();
			
			//사용자 정보 추출하기
			ObjectMapper objectMapper2 = new ObjectMapper();
			try {
				userMap = objectMapper2.readValue(userBody, HashMap.class);
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			
//----------내가 알고 싶어하는 정보 미리 받아두기  : id, nickname, email, profilePhoto, birthday ------------------
			String id = String.valueOf(userMap.get("id"));	
			Map properties = (Map) userMap.get("properties");		//내부의 json은 맵으로 처리 
			String nickname = (String)properties.get("nickname");
			//메일은 아래에서 받을 것
			String profile_image = (String)properties.get("profile_image");
			Map kakao_account = (Map) userMap.get("kakao_account");
			//String email = (String)kakao_account.get("email");
			String age_range =(String)kakao_account.get("age_range");
			
			logger.info("id : " + id);						//id : 2704115905
			logger.info("nickname : "+ nickname);			//nickname : 景
			logger.info("profile_image : "+ profile_image);	//profile_image : http://k.kakaocdn.net/dn/hd5rM/btrQsGbRPNK/8TCCdKlr5eJR3q9Bv3nJyK/img_640x640.jpg
			//logger.info("email : "+ email);					//email : asy118@hanmail.net
			logger.info("age_range : "+ age_range);			//age_range : 30~39
			
			//member에 대한 고유 id 조희
			Member member = memberService.selectById(id);
			
//------------------------------db에 들어가는 타이밍------------------------------------------------------------
		
			if(member==null) {
				//회원여부를 판단. 이미 db에 이 회원의 식별 고유 id가 존재할 경우 회원가입을 처리해주자 (서비스의 insert) 세션에 담자 
				
				member = new Member();
				member.setMember_id(id);		//고유id 가져오기 
				member.setMember_nickname(nickname);	//닉네임 가져오기 
				
				Email email = new Email();
				email.setEmail_addr((String)kakao_account.get("email"));	//메일 가져오기
				
				ProfilePhoto profilePhoto = new ProfilePhoto();
				profilePhoto.setProfile_photo(profile_image);		//프사 picture로 가져오기 
				
				Birthday birthday = new Birthday();
				birthday.setAge(age_range);			//연령대 (생일)가져오기
				
				Sns sns = snsService.selectByIdx(2);
				member.setSns(sns);		//sns유형 담기
				member.setEmail(email);
				member.setProfilePhoto(profilePhoto);
				member.setBirthday(birthday);
				
				//정보 출력해보기
				logger.info("넣을 고유 id : " + id);
				logger.info("넣을 nickname : " + nickname);
				logger.info("넣을 메일주소 : " + email);
				logger.info("넣을 프로필사진 : " + profilePhoto);
				logger.info("넣을 연령대 : " + birthday);
				logger.info("넣을 snsType: " + sns);
				
				//다 채워졌으면 이제 서비스에게 일을 시킴 -> 여길 지나면 member_idx가 생성됨
				memberService.insert(member);
				
			} else{
				
				member = memberService.selectById(id);
				
			}
			
			//세션에 담기 (로그인 할 수 있게)
			session.setAttribute("member", member);
			
			ModelAndView mav = new ModelAndView("redirect:/");
			
			return mav;
		}
		
		/*-----------------------
		 *     네이버 로그인 콜백 
		--------------------------*/
		@GetMapping("/sns/naver/callback")
		public ModelAndView naverCallback(HttpServletRequest request, HttpSession session) {
			String code = request.getParameter("code");
			logger.info("네이버에서 발급된 코드는 "+code); 
			//네이버에서 발급된 코드는 mR1ZIr8CH7WnOY4ndK
			
			/*--------------------------------------------------------------
			 * 1) 토큰 취득을 위한 POST 헤더와 바디 구성하기
			 ----------------------------------------------------------------*/
			String url = naverLogin.getToken_request_url();
			
			//바디(헤더)의 파라미터 구성하기 <파라미터명, 파라미터값>
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
			params.add("code", code);
			params.add("client_id", naverLogin.getClient_id());
			params.add("client_secret", naverLogin.getClient_secret());
			params.add("redirect_uri", naverLogin.getRedirect_uri());
			params.add("grant_type", naverLogin.getGrant_type());
			params.add("state", naverLogin.getState());
			
			//post 방식의 헤더 (application/x-www-form-urlencoded)
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type",  "application/x-www-form-urlencoded"); 	//** . 아니고 - 로 구분
			
			//머리와 몸 합치기
			HttpEntity httpEntity = new HttpEntity(params, headers);
			
			//요청시도를 위한 객체생성, 비동기 방식의 요청을 위한 객체
			RestTemplate restTemplate=new RestTemplate();
			ResponseEntity<String> responseEntity= restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class); //
			

			/*--------------------------------------------------------------
			 * 2) 토큰 요청 후 ResponseEntitu로부터 토큰 꺼내기 (String에 불과하므로)
			 ---------------------------------------------------------------*/
			String body = responseEntity.getBody();
			logger.info("네이버에서 넘겨받은 응답정보" + body);
			
			/*네이버에서 넘겨받은 응답정보 {
			"access_token": "AAAANzDn696FMlz2-XuXZRNTxF8k4wmQtGuS8z1WxyAXr9L5xxcH-dJs09pq4qLNUAVR9zV77MJB3igFiZEEyZtc2bU",
			"refresh_token": "f7gpCtR88haztmuZgcPtqZEje3dL0bbDs9bZk7nvNfipOIgSQuvrpL7B1ERErLU4PA8iiCxJSQssjlDPhVjDmYSF1x2u3Iza7IUjwAKMP7MjYB3djPMq08oB932LisM0hlf",
			"token_type": "bearer",
			"expires_in": "3600"}*/
			
			
			//json으로 되어있는 문자열을 파싱하여, 자바의 객체로 옮겨담자
			ObjectMapper objectMapper = new ObjectMapper();
			NaverOAuthToken oAuthToken = null;
			
			try {
				oAuthToken=objectMapper.readValue(body, NaverOAuthToken.class);
				
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			
			//oAuthToken 안의 토큰을 이용하여 회원정보에 접근
			/*--------------------------------------------------------------
			 * 3) 토큰을 이용하여 회원정보에 접근 
			 ----------------------------------------------------------------*/
			String userinfo_url=naverLogin.getUserinfo_url();
			
			//GET방식요청 구성
			HttpHeaders headers2 = new  HttpHeaders();
			headers2.add("Authorization", "Bearer "+oAuthToken.getAccess_token()); //"Bearer " 한 칸 띄워야 함!!
			HttpEntity entity=new HttpEntity(headers2);
			
			//비동기 객체를 이용한 GET 요청
			RestTemplate restTemplate2 = new RestTemplate();
			ResponseEntity <String> userEntity = restTemplate2.exchange(userinfo_url, HttpMethod.GET, entity, String.class);
			
			String userBody = userEntity.getBody();
			logger.info("회원정보는 "+userBody);
			
			/*회원정보는 
			 * {
				"resultcode": "00",
				"message": "success",
				"response": {
					"id": "DgPdf0zXS5lz3Hm-Kgx6-EtXpx4MPZFithX40KQawLg",
					"nickname": "\ub2f9\uadfc\uc2dc\ub7ec",
					"profile_image": "https:\/\/phinf.pstatic.net\/contact\/20210427_157\/1619532053625FKw67_JPEG\/DSC01453.JPG",
					"age": "30-39",
					"email": "asy118@hanmail.net",
					"name": "\uc548\ub3c4\uacbd",
					"birthyear": "1993"
					}
				}*/
			
			HashMap<String, Object> userMap = new HashMap<String, Object>();
			
			//사용자 정보 추출하기
			ObjectMapper objectMapper2 = new ObjectMapper();
			try {
				userMap = objectMapper2.readValue(userBody, HashMap.class);
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			
//----------내가 알고 싶어하는 정보 미리 받아두기  : id, nickname, email, profilePhoto, birthday ------------------
			Map response = (Map) userMap.get("response");		//내부의 json은 맵으로 처리 
			String id = (String)response.get("id");
			String nickname = (String)response.get("nickname");
			String profile_image = (String)response.get("profile_image");
			//String email = (String)response.get("email");
			String age = (String)response.get("age");
			
			logger.info("id : " + id);						//id : DgPdf0zXS5lz3Hm-Kgx6-EtXpx4MPZFithX40KQawLg
			logger.info("nickname : "+ nickname);			//nickname : 당근시러
			logger.info("profile_image : "+ profile_image);	//profile_image : https://phinf.pstatic.net/contact/20210427_157/1619532053625FKw67_JPEG/DSC01453.JPG
			//logger.info("email : "+ email);					//email : asy118@hanmail.net
			logger.info("age : "+ age);						//age : 30-39
			
			//member에 대한 고유 id 조희
			Member member = memberService.selectById(id);
			
//------------------------------db에 들어가는 타이밍------------------------------------------------------------
			Teacher teacher = teacherService.select(1);
			session.setAttribute("teacher", teacher);
			if(member==null) {
				//회원여부를 판단. 이미 db에 이 회원의 식별 고유 id가 존재할 경우 회원가입을 처리해주자 (서비스의 insert) 세션에 담자 
				
				member = new Member();
				member.setMember_id(id);		//고유id 가져오기 
				member.setMember_nickname(nickname);	//닉네임 가져오기 
				
				Email email = new Email();
				email.setEmail_addr((String)response.get("email"));	//메일 가져오기
				
				ProfilePhoto profilePhoto = new ProfilePhoto();
				profilePhoto.setProfile_photo(profile_image);		//프사 picture로 가져오기 
				
				Birthday birthday = new Birthday();
				birthday.setAge(age);			//연령대 (생일)가져오기
				
				Sns sns = snsService.selectByIdx(3);
				member.setSns(sns);		//sns유형 담기
				member.setEmail(email);
				member.setProfilePhoto(profilePhoto);
				member.setBirthday(birthday);
				
				//정보 출력해보기
				logger.info("넣을 고유 id : " + id);
				logger.info("넣을 nickname : " + nickname);
				logger.info("넣을 메일주소 : " + email);
				logger.info("넣을 프로필사진 : " + profilePhoto);
				logger.info("넣을 연령대 : " + birthday);
				logger.info("넣을 snsType: " + sns);
				logger.info("member : "+member);
				int teacher_member_idx = member.getMember_idx();
		        logger.info("teacher : "+teacher);
		        if(teacher != null) {
		        	member.setTeacher(teacher);
		        	session.setAttribute("teacher", teacher);
		        }
				
				//다 채워졌으면 이제 서비스에게 일을 시킴 -> 여길 지나면 member_idx가 생성됨
				memberService.insert(member);
			} else {
				member = new Member();
				member.setMember_id(id);		//고유id 가져오기 
				member.setMember_nickname(nickname);	//닉네임 가져오기 
				
				Email email = new Email();
				email.setEmail_addr((String)response.get("email"));	//메일 가져오기
				
				ProfilePhoto profilePhoto = new ProfilePhoto();
				profilePhoto.setProfile_photo(profile_image);		//프사 picture로 가져오기 
				
				Birthday birthday = new Birthday();
				birthday.setAge(age);			//연령대 (생일)가져오기
				
				Sns sns = snsService.selectByIdx(3);
				member.setSns(sns);		//sns유형 담기
				member.setEmail(email);
				member.setProfilePhoto(profilePhoto);
				member.setBirthday(birthday);
				
				//정보 출력해보기
				logger.info("넣을 고유 id : " + id);
				logger.info("넣을 nickname : " + nickname);
				logger.info("넣을 메일주소 : " + email);
				logger.info("넣을 프로필사진 : " + profilePhoto);
				logger.info("넣을 연령대 : " + birthday);
				logger.info("넣을 snsType: " + sns);
				
			}
			//세션에 담기 (로그인 할 수 있게)
			session.setAttribute("member", member);
	        
			ModelAndView mav = new ModelAndView("redirect:/");
			
			return mav;
		}
}





