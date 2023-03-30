

CREATE TABLE member (
	member_idx number  NOT NULL,
	member_nickname varchar2(100)		,
	member_regdate date default sysdate	,
	member_id varchar2(30) NOT NULL,
	sns_name_idx number NOT NULL
);



CREATE TABLE sns_name(
	sns_name_idx number primary key,
	sns_type varchar2(20) not null
);

CREATE TABLE birthday(
	birthday_idx number primary key,
	member_idx number	 NOT NULL,
	birthday varchar2(30) 
);

CREATE TABLE profile_photo(
	profile_photo_idx number primary key,
	member_idx number	 NOT NULL,
	profile_photo varchar2(50) 
);

CREATE TABLE email(
	email_idx number primary key,
	member_idx number NOT NULL,
	email varchar2(30) 
);

CREATE TABLE teacher (
	teacher_idx number	 NOT NULL,
	member_idx number	 NOT NULL
);

CREATE TABLE blacklist (
	blacklist_id number NOT NULL,
	pause date,
	blacklist_memo	 clob ,
	member_idx number	 NOT NULL
);

CREATE TABLE admin (
	admin_idx	 number NOT NULL,
	admin_id varchar2(100)		,
	admin_pass varchar2(64)		,
	grade_idx number not null,
	rank_idx number not null
);

CREATE TABLE grade (
	grade_idx number	 NOT NULL,
	grade_rank number NULL
);

review ON COLUMN grade.grade_rank IS '1: 최상위 관리자
2: 중간관리자
3:하급관리자';

CREATE TABLE top_category (
	top_category_idx number NOT NULL,
	top_name varchar2(30) NULL
);

CREATE TABLE mid_category (
	mid_category_idx number	 NOT NULL,
	mid_name varchar2(30) NULL,
	top_category_idx number NOT NULL
);

CREATE TABLE section (
	section_idx number NOT NULL,
	section_name varchar2(200) NULL,
	subject_idx number NOT NULL
);

CREATE TABLE sub_category (
	sub_category_idx number	 NOT NULL,
	sub_name varchar2(30)	 NULL,
	mid_category_idx number NOT NULL
);

CREATE TABLE movie (
	movie_idx number NOT NULL,
	movie_name varchar2(100) NULL,
	movie_link varchar2(200) NULL,
	section_idx number NOT NULL
);

CREATE TABLE goal (
	goal_idx number NOT NULL,
	goal_name varchar2(200) NULL,
	subject_idx number NOT NULL
);

CREATE TABLE requirement (
	requirement_idx number NOT NULL,
	requirement_name varchar2(200) NULL,
	subject_idx number NOT NULL
);

CREATE TABLE subject (
	subject_idx number NOT NULL,
	subject_title varchar2(200) NULL,
	subject_subTitle clob NULL,
	subject_pic varchar2(30) NULL,
	subject_price number NULL,
	subject_detail clob	 NULL,
	teacher_idx number NOT NULL,
	sub_category_idx number NOT NULL
);

CREATE TABLE cart (
	cart_idx	number		NOT NULL,
	member_idx	number		NOT NULL,
	subject_idx	number		NOT NULL
);

CREATE TABLE wish (
	wish_idx	number		NOT NULL,
	member_idx	number		NOT NULL,
	subject_idx	number		NOT NULL
);


CREATE TABLE order_summary (
	order_summary_idx	number		NOT NULL,
	order_id varcarh2(30) not null,
	order_summary_regdate	date default sysdate null,
	member_idx	number		NOT NULL,
	payment_idx	number		NOT NULL,
	paystate_idx	number		NOT NULL,
	total_buy	number		NULL,
	total_pay	number		NULL
);

CREATE TABLE payment (
	payment_idx	number		NOT NULL,
	payment_type	varchar2(30)		NULL
);

review ON COLUMN payment.payment_type IS 'idx 1 : 카드
idx 2 : 간편결제';

CREATE TABLE paystate (
	paystate_idx	number		NOT NULL,
	state	varchar2(30)		NULL
);

review ON COLUMN paystate.state IS '1 : 결제전
2 : 결제완료
3 : 결제취소';

CREATE TABLE chat (
	chat_idx	number		NOT NULL,
	chat_regdate	date		default sysdate,
	member_idx	number		NOT NULL,
	member_teacher_idx	 number	NOT NULL
);


CREATE TABLE review (
	review_idx number NOT NULL,
	review_rate number NULL,
	review_content clob NULL,
	review_regdate date NULL,
	member_idx number NOT NULL,
	subject_idx number NOT NULL
);

review ON COLUMN review.reviews_rate IS '강의 평점';

CREATE TABLE adminboard (
	adminboard_idx number NOT NULL,
	adminboard_title varchar2(200) NULL,
	adminboard_content clob NULL,
	adminboard_regdate date NULL,
	target_idx number NOT NULL,
	admin_idx number NOT NULL,
	adminboard_sort number NULL
);

CREATE TABLE target (
	target_idx number NOT NULL,
	userType varchar2(10) NULL
);

review ON COLUMN target.userType IS '1 : 모두에게
2 : 강사에게
3 : 유저에게';

CREATE TABLE teacherboard (
	teacherboard_idx number NOT NULL,
	teacherboard_title varchar2(200) NULL,
	teacherboard_content clob NULL,
	teacherboard_regdate date default sysdate NULL,
	teacher_idx number NOT NULL,
	teacherboard_sort number NULL
);

CREATE TABLE message (
	message_idx number NOT NULL,
	message_content clob		,
	message_regdate date default sysdate	,
	message_check number DEFAULT 0 NULL,
	chat_idx number NOT NULL,
	me  number		,
	you	number		
);

review ON COLUMN message.message_check IS '0 : 확인안함
1 : 확인함';

review ON COLUMN message.me IS 'member_idx를 가져오기';

review ON COLUMN message.you IS 'member_idx 가져오기';

CREATE TABLE order_detail (
	order_detail_idx	number		NOT NULL,
	order_summary_idx	number		NOT NULL,
	subject_idx number not null
);


CREATE TABLE discount_log (
	discount_log_idx	number		NOT NULL,
	point	number		NULL,
	order_summary_idx	number		NOT NULL
);

CREATE TABLE charge (
	charge_idx	number		NOT NULL,
	charge_ratio	number		NULL
);

review ON COLUMN charge.charge_ratio IS '10%';

CREATE TABLE point_log (
	point_log_idx	number		NOT NULL,
	order_summary_idx	number		NOT NULL,
	amount	number		NULL,
	point_log_memo	clob		NULL
);

CREATE TABLE point (
	point_idx	number		NOT NULL,
	point_ratio	number		NULL
);

review ON COLUMN point.point_ratio IS '10%';

--PK 제약조건
ALTER TABLE member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	member_idx
);

<<<<<<< HEAD
ALTER TABLE birthday ADD CONSTRAINT PK_BIRTHDAY PRIMARY KEY (
	birthday_idx
);

=======
ALTER TABLE birthday ADD CONSTRAINT PK_birthday PRIMARY KEY (
	birthday_idx
);

ALTER TABLE profile_photo ADD CONSTRAINT PK_profile_photo PRIMARY KEY (
	profile_photo_idx
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (
	email_idx
);

>>>>>>> 090364d14f2248e255f6a980387b9adb6e56c4f0
ALTER TABLE teacher ADD CONSTRAINT PK_TEACHER PRIMARY KEY (
	teacher_idx
);

ALTER TABLE blacklist ADD CONSTRAINT PK_BLACKLIST PRIMARY KEY (
	blacklist_idx
);

ALTER TABLE admin ADD CONSTRAINT PK_ADMIN PRIMARY KEY (
	admin_idx
);

ALTER TABLE grade ADD CONSTRAINT PK_GRADE PRIMARY KEY (
	grade_idx
);

ALTER TABLE top_category ADD CONSTRAINT PK_TOP_CATEGORY PRIMARY KEY (
	top_category_idx
);

ALTER TABLE mid_category ADD CONSTRAINT PK_MID_CATEGORY PRIMARY KEY (
	mid_category_idx
);

ALTER TABLE section ADD CONSTRAINT PK_SECTION PRIMARY KEY (
	section_idx
);

ALTER TABLE movie ADD CONSTRAINT PK_MOVIE PRIMARY KEY (
	movie_idx
);

ALTER TABLE sub_category ADD CONSTRAINT PK_SUB_CATEGORY PRIMARY KEY (
	sub_category_idx
);

ALTER TABLE goal ADD CONSTRAINT PK_GOAL PRIMARY KEY (
	goal_idx
);

ALTER TABLE requirement ADD CONSTRAINT PK_REQUIREMENT PRIMARY KEY (
	requirement_idx
);

ALTER TABLE subject ADD CONSTRAINT PK_SUBJECT PRIMARY KEY (
	subject_idx
);

ALTER TABLE cart ADD CONSTRAINT PK_CART PRIMARY KEY (
	cart_idx
);

ALTER TABLE wish ADD CONSTRAINT PK_WISH PRIMARY KEY (
	wish_idx
);

ALTER TABLE order_summary ADD CONSTRAINT PK_ORDER_SUMMARY PRIMARY KEY (
	order_summary_idx
);

ALTER TABLE payment ADD CONSTRAINT PK_PAYMENT PRIMARY KEY (
	payment_idx
);

ALTER TABLE paystate ADD CONSTRAINT PK_PAYSTATE PRIMARY KEY (
	paystate_idx
);

ALTER TABLE chat ADD CONSTRAINT PK_CHAT PRIMARY KEY (
	chat_idx
);

ALTER TABLE review ADD CONSTRAINT PK_REVIEW PRIMARY KEY (
	review_idx
);

ALTER TABLE adminboard ADD CONSTRAINT PK_ADMINBOARD PRIMARY KEY (
	adminboard_idx
);

ALTER TABLE target ADD CONSTRAINT PK_TARGET PRIMARY KEY (
	target_idx
);

ALTER TABLE teacherboard ADD CONSTRAINT PK_TEACHERBOARD PRIMARY KEY (
	teacherboard_idx
);

ALTER TABLE message ADD CONSTRAINT PK_MESSAGE PRIMARY KEY (
	message_idx
);

ALTER TABLE order_detail ADD CONSTRAINT PK_ORDER_DETAIL PRIMARY KEY (
	order_detail_idx
);

ALTER TABLE discount_log ADD CONSTRAINT PK_DISCOUNT_LOG PRIMARY KEY (
	discount_log_idx
);

ALTER TABLE charge ADD CONSTRAINT PK_CHARGE PRIMARY KEY (
	charge_idx
);

ALTER TABLE point_log ADD CONSTRAINT PK_POINT_LOG PRIMARY KEY (
	order_summary_idx
);

ALTER TABLE point ADD CONSTRAINT PK_POINT PRIMARY KEY (
	point_idx
);

ALTER TABLE sns_name ADD CONSTRAINT PK_SNS_NAME PRIMARY KEY (
	sns_name_idx
);

