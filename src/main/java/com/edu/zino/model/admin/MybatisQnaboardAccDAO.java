package com.edu.zino.model.admin;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.edu.zino.domain.QnaboardAcc;
import com.edu.zino.exception.QnaboardException;

@Repository
public class MybatisQnaboardAccDAO implements QnaboardAccDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	@Override
	public List selectAll() {
		
		return sqlSessionTemplate.selectList("QnaboardAcc.selectAll");
	}

	@Override
	public QnaboardAcc select(int qnaboardacc_idx) {
		
		 return sqlSessionTemplate.selectOne("QnaboardAcc.select",qnaboardacc_idx);
	}

	@Override
	public void insert(QnaboardAcc qnaboardacc) throws QnaboardException{
		int result=sqlSessionTemplate.insert("QnaboardAcc.insert",qnaboardacc);
		if(result<1) {
			throw new QnaboardException("Acc등록실패");
		}
		
	}

	@Override
	public void update(QnaboardAcc qnaboardacc) throws QnaboardException{
		int result=sqlSessionTemplate.update("QnaboardAcc.update",qnaboardacc);
		if(result<1) {
			throw new QnaboardException("Acc수정실패");
		}
		
	}

	@Override
	public void delete(int qnaboardacc_idx) throws QnaboardException{
		int result=sqlSessionTemplate.delete("QnaboardAcc.delete",qnaboardacc_idx);
		if(result<1) {
			throw new QnaboardException("Acc삭제실패");
		}
		
	}

}
