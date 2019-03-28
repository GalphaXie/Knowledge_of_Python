# -*- coding: utf-8 -*-
# 基于mysql的去重判断依据的存储
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

from . import BaseFilter


# class Filter(Base):
#     """"""
#     __tablename__ = "filter"
#
#     id = Column(Integer, primary_key=True)
#     hash_value = Column(String(40), index=True, unique=True)


class MySQLFilter(BaseFilter):
    """基于mysql的去重判断依据的存储"""

    def __init__(self, *args, **kwargs):
        # class Filter(Base):
        #     """"""
        #     __tablename__ = kwargs["mysql_table_name"]
        #
        #     id = Column(Integer, primary_key=True)
        #     hash_value = Column(String(40), index=True, unique=True)

        # 方法中创建类, 不太符合python风格, 可以选择使用 type 动态创建

        # self.table = Filter

        self.table = type(
            kwargs["mysql_table_name"],
            (Base,),
            dict(
                __tablename__=kwargs["mysql_table_name"],
                id=Column(Integer, primary_key=True),
                hash_value=Column(String(40), index=True, unique=True)
            )
        )

        BaseFilter.__init__(self, *args, **kwargs)

    def _get_storage(self):
        """返回一个mysql连接对象(sqlalchemy的数据库连接对象)"""
        engine = create_engine(self.mysql_url)
        Base.metadata.create_all(engine)
        Session = sessionmaker(engine)  # Session 相当于一个类
        return Session

    def _save(self, hash_value):
        """
        利用mysql(sqlachemy)
        :param hash_value:
        :return:
        """
        session = self.storage()
        filter = self.table(hash_value=hash_value)
        session.add(filter)
        session.commit()
        session.close()

    def _is_exists(self, hash_value):
        """"""
        session = self.storage()
        ret = session.query(self.table).filter_by(hash_value=hash_value).first()
        session.close()
        if ret is None:
            return False
        return True
