--테이블스페이스 생성
create tablespace zino 
datafile 'C:\oraclexe\app\oracle\oradata\XE\zino.dbf' size 10M;

--유저생성
create user eduzino identified by 1234 default tablespace zino;

--권한부여
grant connect, resource to eduzino;

--테이블스페이스 용량 변경
alter database datafile 'C:\oraclexe\app\oracle\oradata\XE\eduzino.dbf'
autoextend on next 100M maxsize 1024M;

