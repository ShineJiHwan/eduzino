package com.edu.zino.domain;

import lombok.Data;

@Data
public class QnaboardPay {
	private int qnaboardpay_idx;
	private String qnaboardpay_title;
	private String qnaboardpay_content;
	private String qnaboardpay_regdate;
	private Admin admin;
}
