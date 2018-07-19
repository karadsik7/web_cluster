create table member(
    id varchar2(10) primary key,
    password varchar2(10) not null,
    name varchar2(30) not null,
    email varchar2(30) not null unique,
    gender char(1) check(gender in('m', 'f'))
);
delete from member where id = 'tester';
select * from member;
select * from member where id = 'admin';
select * from member where email = 'karadsik7@naver.com';
insert into member values('admin', '1234', '관리자', 'a@b.c', 'm');
desc member;

select * from tabs;
select * from board;
desc board;
select * from reply;

create table freeBoard(
    id number constraint pk_fBoard_id primary key,
    name varchar2(30) constraint nn_fBoard_name not null,
    title varchar2(60) constraint nn_fBoard_title not null,
    content clob constraint nn_fBoard_content not null,
    ip varchar2(20),
    regdate date,
    hit number,
    ref number,
    step number,
    depth number
);



select rownum as rnum from freeBoard;

create sequence seq_fBoard_id;

insert into freeBoard values(seq_fBoard_id.nextval, '테스터', '테스트제목', '테스트본문', '127.0.0.1', sysdate, 0, 0, 0, 0);
select * from freeBoard;
desc freeBoard;

delete from freeBoard;

alter table freeBoard add u_id varchar2(10) constraint fk_member_id references member(id);

alter table freeBoard rename column u_id to m_id;

select to_char(sysdate + 9/24, 'YYYY/MM/DD HH24:MI:SS') from dual;

alter table member modify password varchar2(64);
desc member;
delete from member;
delete from freeBoard;
alter table freeBoard drop constraint fk_member_id;
alter table freeBoard add constraint fk_member_id foreign key(m_id) references member(id) on delete set null;

select * from tabs;
select * from user_constraints where table_name = 'COMMENTS';
select * from member;
alter table member add admin number(1) check(admin in(0, 1));
update member set admin = 1 where id = 'admin';
select * from member;

alter table freeBoard add notice number(1) check(notice in(0, 1));
select * from board;    
desc board;
select * from tabs;
alter table freeBoard rename to board;
create table comments(
    id number primary key,
    b_id number constraint fk_comments_bid references board(id) on delete cascade,
    m_id varchar2(10) constraint fk_comments_mid references member(id) on delete cascade,
    name varchar2(30) not null,
    content varchar2(300) not null,
    regdate date not null
);
create sequence seq_board_id start with 109;
select * from board;
select * from comments;
insert into comments values(seq_comments_id.nextval, 64, 'admin', '관리자', 'ㅂㅇㅂㅇ', sysdate+9/24);
drop table comments;
desc comments;

create table love(
    id number primary key,
    c_id number constraint fk_love_cid references comments(id) on delete cascade,
    m_id varchar2(10) constraint fk_love_mid references member(id) on delete cascade
);


--게시판 종류 분류위한 테이블
create table boardType(
    id number primary key,
    name varchar2(60) not null
);

create sequence seq_boardType_id;

insert into boardType values(seq_boardType_id.nextval, '자유게시판');

select * from board;
alter table board add type number references boardType(id);
update board set type = 1;

select * from boardType;
insert into boardType values(seq_boardType_id.nextval, '중요 게시판');

create table hate(
    id number primary key,
    c_id number constraint fk_hate_cid references comments(id) on delete cascade,
    m_id varchar2(10) constraint fk_hate_mid references member(id) on delete cascade
);
create sequence seq_love_id;
create sequence seq_hate_id;
select * from tabs;
select * from comments;
create or replace view comments_view as select a.*, 
(select count(*) from love where c_id = a.id) as loveCount, 
(select count(*) from hate where c_id = a.id) as hateCount from (select id, b_id, m_id, name, content, regdate from comments) a;

select a.*, (select count(*) from love where c_id = a.id) as loveCount, (select count(*) from hate where c_id = a.id) as hateCount from (select id, b_id, m_id, name, content, regdate from comments) a;

insert into love values(seq_love_id.nextval, '5', 'admin');

select * from comments_view;

select count(*) from love where c_id = 5;
select * from love;
select * from hate;

insert into love values(seq_love_id.nextval, '6', 'admin');
insert into hate values(seq_hate_id.nextval, '6', 'admin');
rollback;


select sum(c.cnt) from ( (select count(*) cnt from love where c_id = '7' and m_id = 'test' ) union all (select count(*) cnt from hate where c_id='7' and m_id = 'test') ) c;
select * from love;
select * from hate;

select * from comments_view;
select * from comments;
select * from love;

select * from board;

alter table board add constraint fk_board_btid foreign key(type) references boardType(id) on delete cascade;
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'BOARD';

select * from boardType;
select * from board;

--관리자 게시판 수정삭제용 boardtype테이블과 board테이블을 조인한 게시판 통계뷰 생성
select b.*, (select count(*) from board where type = b.id) as b_total_count, (select count(*) from board where type = b.id and to_char(regdate, 'yyyy-mm-dd') = to_char(sysdate - 1, 'yyyy-mm-dd')) as b_yesterday_count from boardType b order by id;
create or replace view boardstasis_view as select b.*, (select count(*) from board where type = b.id) as b_total_count, (select count(*) from board where type = b.id and to_char(regdate, 'yyyy-mm-dd') = to_char((sysdate+9/24) - 1, 'yyyy-mm-dd')) as b_yesterday_count from boardType b order by id;

select * from boardstasis_view;
desc boardType;
select * from boardType;
select * from board;

desc member;
select * from member;

select * from (select rownum as rnum, b.* from (select * from member
 			where admin = 0 and id like '%'||'use'||'%') b ) where rnum between 0 and 5;
            
select * from member
 			where admin = 0 and id like '%'||'use'||'%';
            
select * from (select rownum as rnum, b.* from (select * from member
 			where admin = 0 and id like '%'||'use'||'%') b) where rnum between 0 and 5;
create sequence seq_tem_id;
drop sequence seq_tem_id;
create sequence seq_tem_id start with 8;
insert into member values('user'||seq_tem_id.nextval, 'ebcc70bef9ccf602fc325cbfeebfcbcd803b0afb1cdc56c2e7ba8eb68241bd02', '더미유저', 
'abc@a.bc'||seq_tem_id.currval, 'm', 0);
select * from member;
