select * from subject;
select * from cart;

select * from member;

select * from order_summary;
select * from order_detail;

insert into POINT_LOG(point_log_idx, order_summary_idx,amount,point_log_memo)
values(seq_point_log.nextval,1,300,'적립금');

select * from point_log;

select * from user_sequences;

select payment_type from payment where (select * from order_summary where order_summary_idx=47);

select * from payment;
insert into payment(payment_idx,payment_type)
values(1,'카드');
insert into payment(payment_idx,payment_type)
values(2,'간편결제');

select * from paystate;

insert into paystate(paystate_idx,state)
values(1,'결제대기');

insert into paystate(paystate_idx,state)
values(2,'결제완료');

drop table order_summary;
drop sequence seq_order_summary;

drop table order_detail;
drop sequence seq_order_detail;

drop table paystate;
drop sequence seq_paystate;

drop table payment;
drop sequence seq_payment;

CREATE TABLE order_summary (
	order_summary_idx number NOT NULL,
	order_id varchar2(30) not null,
	order_summary_regdate date default sysdate null,
	member_idx number	 NOT NULL,
	payment_idx number NOT NULL,
	paystate_idx number NOT NULL,
	total_buy number	 NULL,
	total_pay number	 NULL
);

create sequence seq_order_summary
increment by 1
start with 1;

CREATE TABLE payment (
	payment_idx number NOT NULL,
	payment_type varchar2(30) NULL
);

CREATE TABLE paystate (
	paystate_idx number	 NOT NULL,
	state varchar2(30) NULL
);

CREATE TABLE order_detail (
	order_detail_idx number NOT NULL,
	order_summary_idx number NOT NULL,
	subject_idx number not null
);

select * from subject;

select * from member;
desc teacher;

insert into wish(wish_idx,member_idx,subject_idx) values(seq_wish.nextval,9,1);
insert into cart(cart_idx,member_idx,subject_idx) values(seq_cart.nextval,9,2);
