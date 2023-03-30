package com.edu.zino.model.admin;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.edu.zino.domain.QnaboardVid;
import com.edu.zino.exception.QnaboardException;

@Repository
public class MybatisQnaboardVidDAO implements QnaboardVidDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	@Override
	public List selectAll() {
		
		return sqlSessionTemplate.selectList("QnaboardVid.selectAll");
	}

	@Override
	public QnaboardVid select(int qnaboardvid_idx) {
	
		return sqlSessionTemplate.selectOne("QnaboardVid.select",qnaboardvid_idx);
	}

	@Override
	public void insert(QnaboardVid qnaboardvid) throws QnaboardException{
		int result=sqlSessionTemplate.insert("QnaboardVid.insert",qnaboardvid);
		if(result<1) {
			throw new QnaboardException("vid등록 실패");
		}
		
	}

	@Override
	public void update(QnaboardVid qnaboardvid) throws QnaboardException{
		int result=sqlSessionTemplate.update("QnaboardVid.update",qnaboardvid);
		if(result<1) {
			throw new QnaboardException("vid수정 실패");
		}
		
	}

	@Override
	public void delete(int qnaboardvid_idx) throws QnaboardException{
		int result=sqlSessionTemplate.delete("QnaboardVid.delete",qnaboardvid_idx);
		if(result<1) {
			throw new QnaboardException("vid 삭제 실패");
		}
	}

}
