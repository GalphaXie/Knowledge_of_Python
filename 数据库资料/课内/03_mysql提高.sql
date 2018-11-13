--数据库的使用======> use jing_dong;

------一、SQL语句的强化
--1.查询每种类型的商品中 最贵、最便宜、平均价、数量
select cate_id,max(price),min(price),avg(price),count(*) from goods group by cate_id;

--2.查询所有价格大于平均价格的商品，并且按价格降序排序
###大于小于符号后面应该跟一个数值###
select * from goods where price>(select avg(price) from goods) order by price desc;

--3.查询每种类型中最贵的电脑信息:
###将查出来的结果 as 成一个新表，再和其他表inner join,大表在inner join前小表在inner join后###
select * from goods inner join (select cate_id as c,max(price) as m from goods group by cate_id) as old_1 on old_1.c = goods.cate_id and old_1.m = goods.price;

----------------以下操作是：创建其他两个表，给goods表里的cate_name 和 brand_name update成数值----------------


------二、创建 "商品分类"" 表 :goods_cates
	1.创建"商品分类"表，以 if not exists 的方式
	###如果数据库里没有 goods_cates,就创建，如果有不会创建也不会报错，而没有 if not exists,就会报错###
	 create table if not exists goods_cates(5
		id int unsigned primary key auto_increment,
		name varchar(40) not null);

	2.将goods表中cate_name种类分组结果写入到goods_cates数据表
	###把电脑各个种类名重新插入到创建好的goods_cates表中###
	insert into goods_cates (name) select cate_name from goods group by cate_name;

	3.同步数据表
	通过goods_cates数据表来更新goods表
	###就是把goods数据表里的cate_name的汉字变成goods_cates表里对应的数值
	update goods as g inner join goods_cates as c on g.cate_name=c.name set g.cate_name=c.id;

------三、创建 "商品品牌表" :goods_brands
	1.创建"商品分类"表，以 if not exists 的方式
	create table if not exists goods_brands (
		id int unsigned primary key auto_increment,
		name varchar(40) not null);
		
	2.将goods表中brand_name种类分组结果写入到goods_brands数据表	，不用写values
	insert into goods_brands (name)select brand_name from goods group by brand_name;

	3.同步数据表
	通过goods_brands数据表来更新goods表
	update goods as g inner join goods_brands as b on g.brand_name=b.name set g.brand_name=b.id;

------四、修改表结构
###查看 goods 的数据表结构,会发现 cate_name 和 brand_name对应的类型为 varchar 但是存储的都是数字###
alter table goods change cate_name cate_id int unsigned not null,
	change brand_name brand_id int unsigned not null;
	
------五、外键
1.分别在 goods_cates 和 goods_brands表中插入记录
insert into goods_cates(name) values ('路由器'),('交换机'),('网卡');
insert into goods_brands(name) values ('海尔'),('清华同方'),('神舟');

2.在 goods 数据表中写入任意记录
insert into goods (name,cate_id,brand_id,price)
values('LaserJet Pro P1606dn 黑白激光打印机', 12, 4,'1849');

3.查询所有商品的详细信息 (通过内连接)
select g.id,g.name,c.name,b.name,g.price from goods as g
inner join goods_cates as c on g.cate_id=c.id
inner join goods_brands as b on g.brand_id=b.id;

4.查询所有商品的详细信息 (通过左连接)
select g.id,g.name,c.name,b.name,g.price from goods as g
left join goods_cates as c on g.cate_id=c.id
left join goods_brands as b on g.brand_id=b.id;

5.如何防止无效信息的插入,就是可以在插入前判断类型或者品牌名称是否存在呢?
###如果插入到goods表里的cate_id 或 brand_id不在约束的goods_names(id) 或 goods_brands(id)里,就插不进去###
-- 给brand_id 添加外键约束成功
alter table goods add foreign key (brand_id) references goods_brands(id);
-- 给cate_id 添加外键失败
-- 会出现1452错误
-- 错误原因:已经添加了一个不存在的cate_id值12,因此需要先删除
alter table goods add foreign key (cate_id) references goods_cates(id);

6.如何在创建数据表的时候就设置外键约束呢?
注意: goods 中的 cate_id 的类型一定要和 goods_cates 表中的 id 类型一致
create table goods(
    id int primary key auto_increment not null,
    name varchar(40) default '',
    price decimal(5,2),
    cate_id int unsigned,
    brand_id int unsigned,
    is_show bit default 1,
    is_saleoff bit default 0,
    foreign key(cate_id) references goods_cates(id),
    foreign key(brand_id) references goods_brands(id)
);

7.如何取消外键约束，在实际开发中,很少会使用到外键约束,会极大的降低表更新的效率
-- 需要先获取外键约束名称,该名称系统会自动生成,可以通过查看表创建语句来获取名称
show create table goods;
-- 获取名称之后就可以根据名称来删除外键约束
alter table goods drop foreign key 外键名称;


---------以下代码是结合给定的表的结构设计图来设计的表外键，，，----------
8.创建 "顾客" 表
create table customer(
    id int unsigned auto_increment primary key not null,
    name varchar(30) not null,
    addr varchar(100),
    tel varchar(11) not null
);

9.创建 "订单" 表
create table orders(
    id int unsigned auto_increment primary key not null,
    order_date_time datetime not null,
    customer_id int unsigned,
    foreign key(customer_id) references customer(id)
);

10.创建 "订单详情" 表
create table order_detail(
    id int unsigned auto_increment primary key not null,
    order_id int unsigned not null,
    goods_id int unsigned not null,
    quantity tinyint unsigned not null,
    foreign key(order_id) references orders(id),
    foreign key(goods_id) references goods(id)
);



###说明
1.以上创建表的顺序是有要求的,即如果goods表中的外键约束用的是goods_cates或者是goods_brands,那么就应该先创建这2个表,否则创建goods会失败
2.创建外键时,一定要注意类型要相同,否则失败