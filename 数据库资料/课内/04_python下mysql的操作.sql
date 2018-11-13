--Python 中操作 MySQL步骤

--引入模块
from pymysql import *

--connection对象
conn = connect(host='localhost',port=3306,database='jing_dong',user='root',password='mysql',charset='utf8')
.参数host:连接的mysql主机，本机是"localhost"
.参数port:连接的mysql主机的端口，默认是3306
.参数database:数据库的名称
.参数user:连接的用户名
.参数password:连接的密码
.参数charset:通信采用的编码方式，推荐使用utf8

--connection对象的方法
.close()关闭连接
.commit()提交
.cursor()返回cursor对象，用于执行sql语句并获得结果

--cursor对象
csl=conn.cursor()
.用于执行sql语句，使用频度最高的语句为select、insert、update、delete
.获取Cursor对象：调用Connection对象的cursor()方法

--cursor对象的方法
.close()关闭
.execute(operation [, parameters ])执行语句，返回受影响的行数，主要用于执行insert、update、delete语句，也可以执行create、alter、drop等语句
.fetchone()执行查询语句时，获取查询结果集的第一个行数据，返回一个元组
.fetchall()执行查询时，获取结果集的所有行，一行构成一个元组，再将这些元组装入一个元组返回


----------------------------------查询----------------------------------

conn = connect(host='localhost',port=3306,database='jing_dong',user='root',password='mysql',charset='utf8')--链接对象
cs1 = conn.cursor() --游标对象

csl.execute(sql查询语句) --execute如果成功，就会return返回生效的行数

csl.fetchone() --返回一条元组数据
csl.fetchone() --再返回下一条元组数据 

csl.fetchmany(3) --返回接下来一个包含3个元组数据语元素的大元组，承接上面的取

csl.fetchall() --返回剩下的所有元组数据的一个大元组，承接上面的取 

csl.close()
conn.close()


-----------------------------------增删改--------------------------------
conn = connect(host='localhost',port=3306,database='jing_dong',user='root',password='mysql',charset='utf8')--链接对象
cs1 = conn.cursor() --游标对象

csl.execute(sql增删改语句)--也是返回生效的行数
--id一直在递增，只要上方语句与返回结果，不管下方是不是rollback(),id一直是递增的
###commit就是为了防止多并发###
例如：csl.execute("""insert into goods_cates (name) values ("显卡") """) --注意加三个""""""冒号,

--让上方sql语句生效,如果不想让上方生效就是想撤销，conn.rollback()
conn.commit()

csl.close()
conn.close()



---------------------------------防止sql注入在pycharm----------------------