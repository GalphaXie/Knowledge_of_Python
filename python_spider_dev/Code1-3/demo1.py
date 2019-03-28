# -*- coding: utf-8 -*-

from info_summary_filter import MemoryFilter
from info_summary_filter import RedisFilter
from info_summary_filter import MySQLFilter

# filter = MemoryFilter()
# filter = RedisFilter()
# mysql_url = "pymysql+mysql://root:password@localhost:3306/db_name?charset=utf8"
mysql_url = "mysql+pymysql://root:mysql@localhost:3306/filter?charset=utf8"
filter = MySQLFilter(mysql_url=mysql_url)

# 模拟数据
data = ["111", "222", "333", "qwe", "222", "qwe", "中文"]

for d in data:
    if filter._is_exists(d):
        print("已存在重复数据: {}".format(d))
    else:
        filter._save(d)
        print("保存去重的数据: {}".format(d))





