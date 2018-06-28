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

create sequence seq_fBoard_id;

insert into freeBoard values(seq_fBoard_id.nextval, '테스터', '테스트제목', '테스트본문', '127.0.0.1', sysdate, 0, 0, 0, 0);
select * from freeBoard;
desc freeBoard;
select * from freeBoard;

