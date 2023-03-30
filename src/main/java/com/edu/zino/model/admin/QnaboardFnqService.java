package com.edu.zino.model.admin;

import java.util.List;

import com.edu.zino.domain.QnaboardFnq;

public interface QnaboardFnqService {
	public List selectAll();
	public QnaboardFnq select(int qnaboardfnq_idx);
	public void insert(QnaboardFnq qnaboardfnq);
	public void update(QnaboardFnq qnaboardfnq);
	public void delete(int qnaboardfnq_idx);
}
