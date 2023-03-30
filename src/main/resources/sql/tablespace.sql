--테이블스페이스 생성
create tablespace eduzino 
datafile 'C:\oraclexe\app\oracle\oradata\XE\eduzino.dbf' size 5M;

--유저생성
create user zino identified by 1234 default tablespace eduzino;

--권한부여
grant connect, resource to zino;

--테이블스페이스 용량 변경
alter database datafile 'C:\oraclexe\app\oracle\oradata\XE\eduzino.dbf'
autoextend on next 100M maxsize 1024M;
