参考大神文章:

[优化Django ORM中的性能问题](https://blog.csdn.net/orangleliu/article/details/57088557)



思路整理:

- 1.如何查问题?
  - 1.1 数据库(缺少索引  | 模型字段和选项设计不合理)
  - 1.2 数据存储接口(ORM | 低效的查询--查询方式和语句)
  - 1.3 展现/数据使用(views | 报表等)