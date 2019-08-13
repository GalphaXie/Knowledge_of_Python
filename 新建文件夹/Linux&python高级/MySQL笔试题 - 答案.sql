#1. 创建MySQL数据库test，并创建student表添加如下数据：
+----+--------+---------+-------+
| id | name   | subject | score |
+----+--------+---------+-------+
|  1 | 张三   | 语文    |    90 |
|  2 | 张三   | 数学    |    80 |
|  3 | 张三   | 英语    |    60 |
|  4 | 李四   | 语文    |    75 |
|  5 | 李四   | 数学    |    85 |
|  6 | 李四   | 英语    |    45 |
|  7 | 王五   | 语文    |    99 |
|  8 | 王五   | 数学    |    55 |
|  9 | 王五   | 英语    |    59 |
| 10 | 赵六   | 语文    |    88 |
| 11 | 赵六   | 数学    |    88 |
| 12 | 赵六   | 英语    |    70 |
| 13 | 田七   | 语文    |    77 |
| 14 | 田七   | 数学    |   100 |
| 15 | 田七   | 英语    |    90 |
+----+--------+---------+-------+

参考答案：
create table student(
    id int unsigned auto_increment primary key not null,
    name varchar(10),
    subject varchar(10),
    score int);
insert into student values(0, '张三', '语文', 90);
insert into student values(0, '张三', '数学', 80);
insert into student values(0, '张三', '英语', 60);
insert into student values(0, '李四', '语文', 75);
insert into student values(0, '李四', '数学', 85);
insert into student values(0, '李四', '英语', 45);
insert into student values(0, '王五', '语文', 99);
insert into student values(0, '王五', '数学', 55);
insert into student values(0, '王五', '英语', 59);
insert into student values(0, '赵六', '语文', 88);
insert into student values(0, '赵六', '数学', 88);
insert into student values(0, '赵六', '英语', 70);
insert into student values(0, '田七', '语文', 77);
insert into student values(0, '田七', '数学', 100);
insert into student values(0, '田七', '英语', 90);

#2. 写一条select语句：查询含有不及格科目的学生，其平均分（所有科目的平均分）以及不及格科目数量。

参考答案：select name,avg(score),sum(score<60) as count from student group by name having count >= 1;
		
		select name,avg(score),sum(score<60) from student where name in (select name from student where score<60) group by name;


          
        select q.*, w.num from 

        (select t.name, avg(score) from student as t 
        inner join 
        (select distinct name from student where score<60) as n 
        on t.name=n.name group by t.name) 
        as q 

        inner join 

        (select name, count(*) as num from student where score<60 group by name) 
        as w 

        on q.name=w.name;
          
+------+------------+-----+
| name | avg(score) |count|
+------+------------+-----+
| 李四 | 68.3333    | 1   |
| 王五 | 71.0000    | 2   |
+------+------------+-----+
2 rows in set

#3. 写一条select语句：查询每个学生的最大分数的科目及分数。

参考答案：

select a.* from student as a, (select name,max(score) as c from student group by name) as b where a.name=b.name and a.score = b.c;
select a.* from student as a inner join (select name,max(score) as c from student group by name) as b on a.name=b.name and a.score=b.c;

+----+--------+---------+-------+
| id | name   | subject | score |
+----+--------+---------+-------+
|  1 | 张三   | 语文    |    90 |
|  5 | 李四   | 数学    |    85 |
|  7 | 王五   | 语文    |    99 |
| 10 | 赵六   | 语文    |    88 |
| 11 | 赵六   | 数学    |    88 |
| 14 | 田七   | 数学    |   100 |
+----+--------+---------+-------+
6 rows in set (0.01 sec)

