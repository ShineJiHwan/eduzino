package com.edu.zino.model.member;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.edu.zino.domain.Email;
import com.edu.zino.domain.Member;
import com.edu.zino.exception.BirthdayException;
import com.edu.zino.exception.EmailException;
import com.edu.zino.exception.MemberException;
import com.edu.zino.exception.ProfilePhotoException;


@Service
public class MemberServiceImpl implements MemberService{

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private EmailDAO emailDAO;
	
	@Autowired
	private ProfilePhotoDAO profilePhotoDAO;
	
	@Autowired
	private BirthdayDAO birthdayDAO;
	
	//------------------------------------------------------------
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return memberDAO.selectAll();
	}
	
	@Override
	public Member selectMember(int member_idx) {
		
		return memberDAO.selectMember(member_idx);
	}


	@Override
	public Member select(int member_idx) {
		return memberDAO.select(member_idx);
	}

	@Override
	public Member selectById(String id) {
		return memberDAO.selectById(id);
	}
	
	//------------------------------------------------------------
	//가입시키기
	@Transactional(propagation = Propagation.REQUIRED)
	public void insert(Member member)throws MemberException, EmailException, ProfilePhotoException, BirthdayException {
		memberDAO.insert(member);		//selectKey가 실행돼서 idx가 채워져서 오면... 
		
		logger.info("멤버서비스 "+member);
		
		member.getEmail().setMember(member); //서로에게 심어줘야 했음 
		member.getProfilePhoto().setMember(member);
		
		//채워진 idx를 갖고 메일도 넣고 
		//Email email = new Email(); 이미 있는 컨트롤러에서 땡겨와야함. 이전 단계는 컨트롤러! 
		
		if(member.getSns().getSns_type().equals("google")) {
			emailDAO.insert(member.getEmail());
			profilePhotoDAO.insert(member.getProfilePhoto());  //사진 넣고
			
		}else if(member.getSns().getSns_type().equals("kakao")) {
			member.getBirthday().setMember(member);
			
			emailDAO.insert(member.getEmail());
			profilePhotoDAO.insert(member.getProfilePhoto());  //사진 넣고
			birthdayDAO.insert(member.getBirthday());  //생일 넣고 
			
		}else if(member.getSns().getSns_type().equals("naver")) {
			member.getBirthday().setMember(member);
			
			emailDAO.insert(member.getEmail());
			profilePhotoDAO.insert(member.getProfilePhoto());  //사진 넣고
			birthdayDAO.insert(member.getBirthday());  //생일 넣고 
		}
		
	}
	
	//------------------------------------------------------------
	@Override
	public void update(Member member) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int member_idx) {
		// TODO Auto-generated method stub
		
	}
	
	
}