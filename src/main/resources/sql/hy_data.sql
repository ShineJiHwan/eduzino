--임시데이터

select table_name from user_tables;

---------------------------------------
 
insert into member(member_idx,member_nickname, member_id, sns_name_idx)
 values(1,'marlang','kite@naver',1);
 
insert into teacher(teacher_idx, member_idx)
 values(1,1);

insert into subject(subject_idx,subject_title,subject_subTitle,subject_price,subject_detail,teacher_idx,sub_category_idx)
 values(1, 'spring boot','jhonjam',35000,'ddfdfdf',1,1);
 
insert into subject(subject_idx,subject_title,subject_subTitle,subject_price,subject_detail,teacher_idx,sub_category_idx)
 values(2, 'java','javajava',40000,'aaaa',1,1);
 
insert into cart(cart_idx,member_idx,subject_idx)
 values(1,1,1);
 
insert into order_summary(order_summary_idx, member_idx, payment_idx, paystate_idx, total_buy, total_pay)
 values(1, 1, 1, 1, 1, 35000);
 
insert into order_detail(order_detail_idx, order_summary_idx, subje
ct_idx)
 values(1, 1, 1);
 
 

insert into member(member_idx,member_nickname, member_id, sns_name_idx)
 values(2,'mimi','mimi@naver', 1);
 
insert into  order_summary(order_summary_idx, member_idx, payment_idx, paystate_idx, total_buy, total_pay)
 values(2,2,2,2,1,35000);
  
insert into order_detail(order_detail_idx, order_summary_idx, subject_idx)
 values(2, 2, 1);
 
 insert into  order_summary(order_summary_idx, member_idx, payment_idx, paystate_idx, total_buy, total_pay)
 values(5, 2, 5, 5, 2, 75000);
  
insert into order_detail(order_detail_idx, order_summary_idx, subject_idx)
 values(6, 5, 3);
 
insert into order_detail(order_detail_idx, order_summary_idx, subject_idx)
 values(7, 5, 4);
 
 
insert into member(member_idx,member_nickname, member_id, sns_name_idx)
 values(3,'roma','roma@naver', 1);
 
insert into  order_summary(order_summary_idx, member_idx, payment_idx, paystate_idx, total_buy, total_pay)
 values(3,3,3,3,1,35000);
  
insert into order_detail(order_detail_idx, order_summary_idx, subject_idx)
 values(3, 3, 1);
 
 

insert into member(member_idx,member_nickname, member_id, sns_name_idx)
 values(4,'zizi','zizi@naver', 1);
 
insert into  order_summary(order_summary_idx, member_idx, payment_idx, paystate_idx, total_buy, total_pay)
 values(4,4,4,4,2,75000);
  
insert into order_detail(order_detail_idx, order_summary_idx, subject_idx)
 values(4, 4, 1);
 
insert into order_detail(order_detail_idx, order_summary_idx, subject_idx)
 values(5, 4, 2);
 
 
 insert into member(member_idx,member_nickname, member_id, sns_name_idx)
 values(5,'zifil','zifil@naver', 1);
 
 insert into teacher(teacher_idx, member_idx)
 values(2,5);

insert into subject(subject_idx,subject_title,subject_subTitle,subject_price,subject_detail,teacher_idx,sub_category_idx)
 values(3, 'sql','jhonjam',35000,'gggg',2,1);
 
insert into subject(subject_idx,subject_title,subject_subTitle,subject_price,subject_detail,teacher_idx,sub_category_idx)
 values(4, 'js','jsss',40000,'eeee',2,1);
 
 
 --------------------------------------
 CREATE TABLE chat (
	chat_idx number primary key,
	chat_regdate date default sysdate,
	member_idx number NOT NULL,
	member_teacher_idx number NOT NULL
);

create sequence seq_chat
increment by 1
start with 1;



CREATE TABLE message (
	message_idx	number primary key,
	message_content clob ,
	message_regdate date default sysdate ,
	message_check number DEFAULT 0,
	chat_idx number NOT NULL,
	me number ,
	you number		
);

create sequence seq_message
increment by 1
start with 1;


CREATE TABLE sns(
    sns_idx number primary key,
    sns_type varchar2(20)
);

create sequence seq_Sns increment by 1 start with 1;


CREATE TABLE member (
    member_idx    number primary key,
    member_nickname varchar2(30),
    member_id varchar2(60),
    member_regdate date default sysdate,
    sns_idx number,
    constraint fk_sns_member
    foreign key (sns_idx)
    references sns(sns_idx)
);

create sequence seq_member increment by 1 start with 1;


CREATE TABLE birthday(
    birthday_idx number primary key, 
    member_idx number,
    age varchar2(30),
    constraint fk_member_birthday
    foreign key (member_idx)
    references member(member_idx)
);

create sequence seq_birthday increment by 1 start with 1;


CREATE TABLE ProfilePhoto(
    profilePhoto_idx number primary key,
    member_idx number,
    profile_photo varchar2(100),
    constraint fk_member_profilephoto
    foreign key (member_idx)
    references member(member_idx)
);

create sequence seq_ProfilePhoto increment by 1 start with 1;


create table email(
    email_idx number primary key,
    member_idx number,
    email_addr varchar2(60),
    constraint fk_member_email
    foreign key (member_idx)
    references member(member_idx)
);

create sequence seq_email increment by 1 start with 1;

CREATE TABLE blacklist (
    blacklist_idx     number primary key,
    pause date default sysdate,
    blacklist_memo clob,
    member_idx number,
    constraint fk_member_blacklist
    foreign key (member_idx)
    references member(member_idx)
);

create sequence seq_blacklist increment by 1 start with 1;


CREATE TABLE admin (
    admin_idx    number primary key,
    admin_id    varchar2(100),
    admin_pass    varchar2(64)
);
create sequence seq_admin increment by 1 start with 1;

insert into sns(sns_idx, sns_type) values(1, 'google');
insert into sns(sns_idx, sns_type) values(2, 'kakao');
insert into sns(sns_idx, sns_type) values(3, 'naver');
insert into admin(admin_idx, admin_id, admin_pass) values(1, 'admin1', '1234');

 