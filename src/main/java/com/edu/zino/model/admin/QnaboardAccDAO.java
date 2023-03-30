package com.edu.zino.model.admin;

import java.util.List;

import com.edu.zino.domain.QnaboardAcc;
import com.edu.zino.domain.QnaboardFnq;

public interface QnaboardAccDAO {
	public List selectAll();
	public QnaboardAcc select(int qnaboardacc_idx);
	public void insert(QnaboardAcc qnaboardacc);
	public void update(QnaboardAcc qnaboardacc);
	public void delete(int qnaboardacc_idx);
}
