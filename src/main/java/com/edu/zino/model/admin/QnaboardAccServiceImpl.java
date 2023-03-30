package com.edu.zino.model.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.zino.domain.QnaboardAcc;

@Service
public class QnaboardAccServiceImpl implements QnaboardAccService{
	@Autowired
	private QnaboardAccDAO qnaboardAccDAO;

	@Override
	public List selectAll() {
	
		return qnaboardAccDAO.selectAll();
	}

	@Override
	public QnaboardAcc select(int qnaboardacc_idx) {
		
		return qnaboardAccDAO.select(qnaboardacc_idx);
	}

	@Override
	public void insert(QnaboardAcc qnaboardacc) {
		qnaboardAccDAO.insert(qnaboardacc);
		
	}

	@Override
	public void update(QnaboardAcc qnaboardacc) {
		qnaboardAccDAO.update(qnaboardacc);
		
	}

	@Override
	public void delete(int qnaboardacc_idx) {
		qnaboardAccDAO.delete(qnaboardacc_idx);
		
	}

}
