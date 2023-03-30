package com.edu.zino.domain;

import lombok.Data;

@Data
public class QnaboardAcc {
	private int qnaboardacc_idx;
	private String qnaboardacc_title;
	private String qnaboardacc_content;
	private String qnaboardacc_regdate;
	private Admin admin;
}
