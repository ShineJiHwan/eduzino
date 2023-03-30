package com.edu.zino.model.admin;

import java.util.List;

import com.edu.zino.domain.QnaboardPay;

public interface QnaboardPayService {
	public List selectAll();
	public QnaboardPay select(int qnaboardpay_idx);
	public void insert(QnaboardPay qnaboardpay);
	public void update(QnaboardPay qnaboardpay);
	public void delete(int qnaboardpay_idx);
}
