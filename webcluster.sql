select * from member;
select * from member where email = 'karadsik7@naver.com';
insert into member values('admin', '1234', '°ü¸®ÀÚ', 'a@b.c', 'm');
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

select * from freeBoard;

