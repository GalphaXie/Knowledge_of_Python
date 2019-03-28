# -*- coding: utf-8 -*-
# 基于 python 中 set() 数据结构进行去重

from . import BaseFilter


class MemoryFilter(BaseFilter):
    """
    基于 python 中 set() 数据结构进行去重
    """

    def _get_storage(self):
        return set()

    def _save(self, hash_value):
        """
        数据的保存
        :param hash_value:
        :return:
        """
        return self.storage.add(hash_value)

    def _is_exists(self, hash_value):
        """
        判断数据是否已经存在
        :param hash_value:
        :return:
        """
        if hash_value in self.storage:
            return True
        else:
            return False
