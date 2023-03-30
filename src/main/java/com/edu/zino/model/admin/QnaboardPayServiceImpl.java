package com.edu.zino.model.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.zino.domain.QnaboardPay;

@Service
public class QnaboardPayServiceImpl implements QnaboardPayService{
	@Autowired
	QnaboardPayDAO qnaboarPayDAO;

	@Override
	public List selectAll() {
		
		return qnaboarPayDAO.selectAll();
	}

	@Override
	public QnaboardPay select(int qnaboardpay_idx) {
		
		return qnaboarPayDAO.select(qnaboardpay_idx);
	}

	@Override
	public void insert(QnaboardPay qnaboardpay) {
		qnaboarPayDAO.insert(qnaboardpay);
		
	}

	@Override
	public void update(QnaboardPay qnaboardpay) {
		qnaboarPayDAO.update(qnaboardpay);
		
	}

	@Override
	public void delete(int qnaboardpay_idx) {
		qnaboarPayDAO.delete(qnaboardpay_idx);
		
	}

}
