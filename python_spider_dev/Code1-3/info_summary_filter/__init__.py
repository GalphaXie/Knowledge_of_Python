# -*- coding: utf-8 -*-

# 基于信息摘要算法, 进行数据 去重 判断 存储
# 1.基于内存的存储
# 2.基于redis的持久化存储
# 3.基于mysql的持久化存储

import hashlib
import six


class BaseFilter(object):
    """
    基于信息摘要算法, 进行数据 去重 判断 存储
    主要有两个逻辑： 1. 判断逻辑  2. 存储逻辑
    """

    def __init__(self,
                 hash_func_name="md5",
                 redis_host="localhost",
                 redis_port=6379,
                 redis_db=0,
                 redis_key="filter",
                 mysql_url=None,
                 mysql_table_name="filter"):
        self.redis_host = redis_host
        self.redis_port = redis_port
        self.redis_db = redis_db
        self.redis_key = redis_key
        self.mysql_url = mysql_url
        self.mysql_table_name = mysql_table_name

        self.hash_func = getattr(hashlib, hash_func_name)
        self.storage = self._get_storage()

    def _safe_data(self, data):
        """
        python2 : str <=> python3 : bytes
        python2 : unicode <=> python3 : str
        对原始数据进行类型的校验, 并转换成满足要求的数据
        :param data: 原始数据
        :return: 转换成 二进制的字符串数据
        """
        if six.PY3:
            if isinstance(data, bytes):
                return data
            elif isinstance(data, str):
                return data.encode()
            else:
                raise Exception("Please give a str or bytes data")
        else:
            if isinstance(data, str):
                return data
            elif isinstance(data, unicode):
                return data.encode()
            else:
                raise Exception("Please give a str or bytes data")

    def _get_hash_value(self, data):
        """
        通过原始的二进制字符串数据来生成对应的 摘要(指纹)-- 固定长度的文本数据
        :param data: 原始的二进制文本数据或字符串数据
        :return: 摘要(指纹)-- 固定长度的文本数据
        """
        hash_obj = self.hash_func()
        hash_obj.update(self._safe_data(data))  # 数据存在问题
        hash_value = hash_obj.hexdigest()
        return hash_value

    def save(self, data):
        """
        根据 data 计算出 指纹进行存储
        :param data: 给定的原始的数据
        :return: 存储的结果(success or fail)
        """
        hash_value = self._get_hash_value(data)
        return self._save(hash_value)

    def _save(self, hash_value):
        """
        存储对应的hash值(留给子类去进行继承和重写)
        :param hash_value: 通过信息摘要算法生成的hash值
        :return: 存储的结果
        """
        pass

    def is_exists(self, data):
        """
        判断给定的数据对应的指纹是否存在
        :param data: 原始数据
        :return: True | False
        """
        hash_value = self._get_hash_value(data)
        return self._is_exists(self, hash_value)

    def _is_exists(self, hash_value):
        """
        通过 摘要算法生成的hash值判断是否已经存在 (留给子类去继承重写)
        :param hash_value: 摘要算法生成的hash值
        :return: 判断结果:True | False
        """
        pass

    def _get_storage(self):
        """返回对应的存储对象(留给子类去进行 去重方案的选择)"""
        pass


from .memory_filter import MemoryFilter
from .mysql_filter import MySQLFilter
from .redis_filter import RedisFilter