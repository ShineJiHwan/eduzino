package com.edu.zino.model.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.zino.domain.QnaboardVid;

@Service
public class QnaboardVidServiceImpl implements QnaboardVidService{
	
	@Autowired
	private QnaboardVidDAO qnaboardvidDAO;
	
	@Override
	public List selectAll() {
		
		return qnaboardvidDAO.selectAll();
	}

	@Override
	public QnaboardVid select(int qnaboardvid_idx) {
		
		return qnaboardvidDAO.select(qnaboardvid_idx);
	}

	@Override
	public void insert(QnaboardVid qnaboardvid) {
		qnaboardvidDAO.insert(qnaboardvid);
		
	}

	@Override
	public void update(QnaboardVid qnaboardvid) {
		qnaboardvidDAO.update(qnaboardvid);
		
	}

	@Override
	public void delete(int qnaboardvid_idx) {
		qnaboardvidDAO.delete(qnaboardvid_idx);
		
	}

}
