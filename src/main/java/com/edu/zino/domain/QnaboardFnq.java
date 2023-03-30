package com.edu.zino.domain;

import lombok.Data;

@Data
public class QnaboardFnq {
	private int qnaboardfnq_idx;
	private String qnaboardfnq_title;
	private String qnaboardfnq_content;
	private String qnaboardfnq_regdate;
	private Admin admin;
}
