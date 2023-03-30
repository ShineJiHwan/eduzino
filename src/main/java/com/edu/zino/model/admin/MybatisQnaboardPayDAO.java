package com.edu.zino.model.admin;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.edu.zino.domain.QnaboardPay;
import com.edu.zino.exception.QnaboardException;

@Repository
public class MybatisQnaboardPayDAO implements QnaboardPayDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		
		return sqlSessionTemplate.selectList("QnaboardPay.selectAll");
	}

	@Override
	public QnaboardPay select(int qnaboardpay_idx) {
		
		return sqlSessionTemplate.selectOne("QnaboardPay.select",qnaboardpay_idx);
	}

	@Override
	public void insert(QnaboardPay qnaboardpay) throws QnaboardException{
		int result=sqlSessionTemplate.insert("QnaboardPay.insert",qnaboardpay);
		if(result<1) {
			throw new QnaboardException("pay등록실패");
		}
		
	}

	@Override
	public void update(QnaboardPay qnaboardpay) throws QnaboardException{
		int result=sqlSessionTemplate.update("QnaboardPay.update",qnaboardpay);
		if(result<1) {
			throw new QnaboardException("pay수정 실패");
		}
		
	}

	@Override
	public void delete(int qnaboardpay_idx) {
		int result=sqlSessionTemplate.delete("QnaboardPay.delete",qnaboardpay_idx);
		if(result<1) {
			throw new QnaboardException("pay삭제 실패");
		}
		
	}

}
