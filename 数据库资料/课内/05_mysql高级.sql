	--mysql高级
------------------------------------一、视图-------------------------------------
1.视图是什么：视图就是一条SELECT语句执行后返回的结果集，视图是对若干张基本表的引用，一张虚表，查询语句执行的结果

2.定义视图 ：create view 视图名称 as --select语句
 以查询goods、goods_cates和goods_brands三张表的信息为例，创建一个视图
 create view v_goods_info as select g.* , b.name as brand_name , c.name as cate_name from goods as g 
							--***这里不能用 * ，要分别给b.name 和 c.name取别名，因为三张表都有name,所以要改名***--
	left join goods_cates as c on g.cate_id=c.id left join goods_brands as b on g.brand_id=b.id;
	
	
3.查看视图
show tables;

4.使用视图
select * from v_goods_info;

5.删除视图
drop view v_goods_info;

6.视图的作用
	6.1.提高了重用性，就像一个函数
	6.2.对数据库重构，却不影响程序的运行
	6.3.提高了安全性能，可以对不同的用户
	6.4.让数据更加清晰
	
7.视图只能用来查询

------------------------------------二、事物-------------------------------------
1.事物是什么：它是一个操作序列，这些操作要么都执行，要么都不执行，它是一个不可分割的工作单位。

2.ubuntu终端下的mysql 的每条增、删、改sql语句都会先开启事物并commit提交事物,所以每条语句都会立即执行

3.如何在ubuntu下理解事物，开启两个窗口都进入mysql -uroot -pmysql;
	3.1 创建一个money表，插入两个数据：1：100 2：100
	3.2 开启事务：begin / start transaction
	3.3 进行其中一个窗口进行增、删、改sql语句的操作，将数据缓存
		如果在另一个窗口也进行增、删、改sql语句的操作，
	3.4 如果谁先用commit;提交事物，那么表的数据就会就会按照先抢到commit的那个窗口
		执行的sql语句进行修改。另一个窗口执行的sql有可能出错。
	3.5 回滚事物：rollback;
	
4.注意
	4.1.修改数据的命令会自动的触发事务，包括insert、update、delete
	4.2而在SQL语句中有手动开启事务的原因是：可以进行多次数据的修改，如果成功一起成功，否则一起会滚到之前的数据
	
------------------------------------三、索引-------------------------------------
1.索引是什么：索引是一种特殊的文件(InnoDB数据表上的索引是表空间的一个组成部分)，它们包含着对数据表里所有记录的引用指针。
			  更通俗的说，数据库索引好比是一本书前面的目录，能加快数据库的查询速度

2.索引目的：索引的目的在于提高查询效率
	
3. 索引原理：三叉数等



4.创建索引，都是创建字段名的索引。
	--创建的注意事项
	如果指定字段是字符串，需要指定长度，建议长度与定义字段时的长度一致
	字段类型如果不是字符串，可以不填写长度部分
create index 索引名称 on 表名(字段名称(长度))

5.查看创建的索引
show index from 表名;

6.删除引用：
drop index 索引名称 on 表名;

-------------索引的测试表----------

1.在test数据库中创建测试表test_index
create table test_index(title varchar(10));

2.通过pymsql模块 向表中加入十万条数据
from pymysql import connect
	def main():
		conn = connect(host='localhost',port=3306,database='test',user='root',password='mysql',charset='utf8')
		cursor = conn.cursor() 
		for i in range(100000):
			cursor.execute("""insert into test_index values("ha-%d") """ % i)
		conn.commit()
		
if __name__ == "__main__":
	main()

3.创建、查询
	3.1 开启运行时间检测
	set profiling=1;
	3.2 查看第1万条数据"ha-99999"
	select * from test_index where title="ha-99999";
	3.3 查看执行的时间-没有索引
	show profiles;
	3.4 为表test_index的字段名title(列名)创建索引：名叫title_index
	create index title_index on test_index(title(10))
	--注意点：如果指定字段是字符串，需要指定长度，建议长度与定义字段时的长度一致
			--字段类型如果不是字符串，可以不填写长度部分
	3.5 执行查询语句-有索引
	select * from test_index where title="ha-99999";
	3.6 再次查看执行的时间
	show profiles;
	
	
--注意--
1.要注意的是，建立太多的索引将会影响更新和插入的速度，因为它需要同样更新每个索引文件。对于一个经常需要更新和插入的表格，
就没有必要为一个很少使用的where字句单独建立索引了，对于比较小的表，排序的开销不会很大，也没有必要建立另外的索引。
2.建立索引会占用磁盘空间