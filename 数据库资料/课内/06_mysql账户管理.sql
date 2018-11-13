1.查看所有的用户
	mysql -uroot -pmysql
	1.1 所有用户及权限信息存储在名为mysql数据库的user表中
	1.2 查询user表的结构
	use mysql;
	select host,user,authentication_string from user;
		主要字段说明：
			.Host表示允许访问的主机
			.User表示用户名
			.authentication_string表示密码，为加密后的值

2.创建账户、授权
grant 权限列表 on 数据库 to '用户名'@'访问主机' identified by '密码';

解释-权限列表：
	1.常用权限主要包括：create、alter、drop、insert、update、delete、select
	2.如果分配所有权限，可以使用all privileges

解释-数据库：	
	3.数据库：3.1某数据库名.* --意思是：某数据库下的所有表
			  3.2*.*  		  --意思是：所有数据库下的所有表
			  
解释-用户名：
	4.你要创建的用户名

解释-访问主机：
	5.1设置成 localhost或具体的ip，表示只允许本机或特定主机访问
	5.2设置成 百分号 % 表示此账户可以使用任何ip的主机登录访问此数据库
	
3.查看用户有哪些权限
show grands for slave@localhost;
	
4.使用slave账号登录
mysql -uslave -p密码
--只能用给的权限列表操作数据库

5.修改权限
	5.1mysql -uroot -pmysql; --先进入root
	5.2grant 权限名称 on 数据库 to 账户@主机 with grant option;
	5.3flush privileges;
	5.4quit
	5.5mysql -uslave -p密码
	
6.修改密码
	6.1mysql -uroot -pmysql; --先进入root
	6.2update user set authentication_string=password('新密码') where user='用户名';
	6.3flush privileges
	
7.远程登录
	7.1vim /etc/mysql/mysql.conf.d/mysqld.cnf --打开配置文件
	7.2在bind-address = 127.0.0.1前的#注释  --修改配置文件
	7.3service mysql restart  --重启msyql

8.删除账户
	8.1drop user '用户名'@'主机';
	或
	8.1delete from user where user='用户名';
	-- 操作结束之后需要刷新权限
	8.3flush privileges