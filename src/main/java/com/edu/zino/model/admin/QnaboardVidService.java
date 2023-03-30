package com.edu.zino.model.admin;

import java.util.List;

import com.edu.zino.domain.QnaboardVid;

public interface QnaboardVidService {
	public List selectAll();
	public QnaboardVid select(int qnaboardvid_idx);
	public void insert(QnaboardVid qnaboardvid);
	public void update(QnaboardVid qnaboardvid);
	public void delete(int qnaboardvid_idx);
}
