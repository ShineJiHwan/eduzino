package com.edu.zino.model.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.zino.domain.QnaboardFnq;
@Service
public class QnaboardFnqServiceImpl implements QnaboardFnqService{
	@Autowired
	private QnaboardFnqDAO qnaboardfnqDAO;

	@Override
	public List selectAll() {
		
		return qnaboardfnqDAO.selectAll();
	}

	@Override
	public QnaboardFnq select(int qnaboardfnq_idx) {
		
		return qnaboardfnqDAO.select(qnaboardfnq_idx);
	}

	@Override
	public void insert(QnaboardFnq qnaboardfnq) {
		qnaboardfnqDAO.insert(qnaboardfnq);
		
		
	}

	@Override
	public void update(QnaboardFnq qnaboardfnq) {
		qnaboardfnqDAO.update(qnaboardfnq);
		
	}

	@Override
	public void delete(int qnaboardfnq_idx) {
		qnaboardfnqDAO.delete(qnaboardfnq_idx);
		
	}

}
