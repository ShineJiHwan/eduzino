package com.edu.zino.domain;

import lombok.Data;

@Data
public class QnaboardVid {
	private int qnaboardvid_idx;
	private String qnaboardvid_title;
	private String qnaboardvid_content;
	private String qnaboardvid_regdate;
	private Admin admin;
		
}
