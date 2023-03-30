package com.edu.zino.model.admin;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.edu.zino.domain.QnaboardFnq;
import com.edu.zino.exception.QnaboardException;

@Repository
public class MybatisQnaboardFnqDAO implements QnaboardFnqDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List selectAll() {
		
		return sqlSessionTemplate.selectList("QnaboardFnq.selectAll");
	}

	@Override
	public QnaboardFnq select(int qnaboardfnq_idx) {
		
		return sqlSessionTemplate.selectOne("QnaboardFnq.select",qnaboardfnq_idx);
	}

	@Override
	public void insert(QnaboardFnq qnaboardfnq) throws QnaboardException{
		int result=sqlSessionTemplate.insert("QnaboardFnq.insert",qnaboardfnq);
		if(result<1) {
			throw new QnaboardException("fnq등록 실패");
		}	
		
	}

	@Override
	public void update(QnaboardFnq qnaboardfnq) throws QnaboardException{
		int result=sqlSessionTemplate.update("QnaboardFnq.update",qnaboardfnq);
		if(result<1) {
			throw new QnaboardException("fnq수정 실패");
		}
		
	}

	@Override
	public void delete(int qnaboardfnq_idx) throws QnaboardException{
		int result=sqlSessionTemplate.delete("QnaboardFnq.delete",qnaboardfnq_idx);
		if(result<1) {
			throw new QnaboardException("fnq삭제 실패");
		}
		
	}

}
