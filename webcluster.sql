create table member(
    id varchar2(10) primary key,
    password varchar2(10) not null,
    name varchar2(30) not null,
    email varchar2(30) not null unique,
    gender char(1) check(gender in('m', 'f'))
);

select * from member;
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
select * from user_constraints where table_name = 'FREEBOARD';
select * from member;
alter table member add admin number(1) check(admin in(0, 1));
update member set admin = 1 where id = 'admin';
select * from member;

alter table freeBoard add notice number(1) check(notice in(0, 1));
select * from freeBoard;
