select time();
select version;

###################查看命令###################
show databases;  --查看所有数据库名
show create database python04; --查看你所创建的的数据库编码信息等
select database(); --查看你正在使用的数据库
show tables; --查看数据库的所有表名
desc students; --查看此表的所有列名
show create table students; --查看此表的所有列名，包括约束等
select * from students; --查看表的所有内容信息

###################删除的命名#################
drop database 数据库; --删除数据库
drop table 表名; --删除整个表
delete from 表名; --删除表中所有数据，保留表结构
delete from 表名 where 条件; --删除表中的部分数据
alter table students drop 列名; --删除这个列名字段

一、创建过程、查看创建的过程：
# 1.查看所有数据库名
show databases;

# 2.创建一个 utf-8 的 Python07 的数据库
create database python07 charset=utf8;

# 3.查看你所创建的的数据库编码信息等
show create database python04;

# 4.使用指定的数据库
use python07;

# 5.查看你正在使用的数据库
select database();

+++数据类型+++
数值类型：tinyint 、smallint 、mediumint 、int/integer、 bigint ==> unsigned(无符号范围)
小数：decimal
枚举类型：enum
字符串：char(3) 、varchar(3) 、text大文本
日期时间类型: date年月日 、time时间、 datetime年月日时间、 year年 

+++约束+++
主键：primary key
非空：not key ，因为字段名默认是null可以为空（除非你加默认default变默认值，not null不能单独用 ）
唯一：unique
默认：default
外键：foreign key 
自动生成：auto_increment

# 6.在你正在使用的数据库里新建一个 students 表：
#####注意#####默认值不是随便取的，要包含在类型的范围里
create table students(
	id int unsigned not null auto_increment primary key,
	name varchar(30),
	age tinyint unsigned default 0,
	high decimal(5,2),
	gender enum("男","女","中性","保密") default "保密" --千万注意这个默认值一定要在enum()里面，不然会报错
);

# 7.查看数据库里所有的表
show tables;

# 8.查看指定表的字段结构信息,就是创建的表下面的内容
desc students;
show create table students; 有auto_increment的显示数值，但是可读性没有上面的强 

# 9.给表插入值的信息
insert into students values(0, "老王", 18, 188.88, "男", 0);
--解释第一个0；因为有primary key 如果想一劳永逸就直接写0，会自动生成顺序值，
--如果写成其它值就必须避免重复，之后再写0时就会按照里面的id值进行判断，
--在值之间有控制就插入这个id，如果比里面的值大就会在末尾添加这个id

# 10.查看插入表里面的全部所有信息：危险操作！
select * from students;

二、增、改、删字段名（列名）的信息：修改的前提是要根据约束的格式。
# 1.新添加表的字段名（列名）：
							1.1及其字段名（列名）的数据类型
						    1.2约束可以加上去，约束的格式一定要对
alter table students add birthday datetime;

# 2.修改表的字段名-重名（列名）：
							2.1修改字段里的类型
						    2.1可以加约束，约束要按照格式来
						    2.3modify 后面的字段名（列名）要在表中存在才行						
alter table students modify birthday date;

# 3.修改表的字段名-不重名（列名）：
							3.1修改已存在的字段名（列名），可以重名
							3.2可以加数据类型
							3.3可以加约束，约束的格式一定要正确，特别是时间的格式			
alter table students change birthday birth date default "1990-01-01"

# 4.删除字段--整个字段全删
alter table students drop birth 字段名(列名);

三、增删改查：表下面的记录信息
#######-增-#######
	# 1.向一个表插入单条信息,日期格式要加冒号
		1.1insert into students values(0, "小李飞刀", 20, "女", 1, "1990-01-01");
		1.2insert into students values(null, "小李飞刀", 20, "女", 1, "1990-01-01");
		1.3insert into students values(default, "小李飞刀", 20, "女", 1, "1990-01-01");
		-- 枚举中 的 下标从1 开始 1---“男” 2--->"女"....
		1.4insert into students values(default, "小李飞刀", 20, 1, 1, "1990-02-01");
		1.1 1.2 1.3 1.4的效果是一样的

	# 2.向一个表插入单条部分的信息
	insert into students (name,gender)values("小张",1);

	# 3.向一个表插入多条信息
	3.1--多条部分
	insert into students (name,gender)values("y",2),("w",1); 
	3.2--多条 
	insert into students values(default, "西施", 20, 188.77,"女"), (default, "王昭君", 20, 178.09, "女");

#######-改-######
	# 1.修改信息
	update students set gender=1; -- 修改全部的性别为男生
	update students set gender=1 where name="小李飞刀"; -- 只要name是小李飞刀的 全部的修改
	update students set gender=1 where id=3; -- 只要id为3的 进行修改
	update students set age=22, gender=1 where id=3; -- 只要id为3的 进行修改多个信息

#######-查-######
	# 1.查看所有表内信息
	select * from students;

	# 2.定条件查询，
	select * from students where name="小李飞刀"; -- 查询 name为小李飞刀的所有信息
	select * from students where id>3; -- 查询 name为小李飞刀的所有信息

	# 3.查询指定字段名（列名）
	select name,gender from students;
	select id,name,gender from students where id>3;

	# 4.可以使用as为字段名（列名）或表指定别名
	select id as 序号，name as 姓名，gender as 性别 from students;
	select id as 序号，name as 姓名，gender as 性别 from students where id>3;

#######-删-######
	# 1.物理删除
	delete from students; -- 整个数据表中的所有数据全部删除
	delete from students where name="小李飞刀";

	# 2.逻辑删除
	-- 给students表添加一个is_delete字段 bit 类型
	alter table students add is_delete bit default 0;
	-- 把某些信息将其is_delete默认值从0改成1，就表示此信息为逻辑删除
	update students set is_delete=1 where id=6;