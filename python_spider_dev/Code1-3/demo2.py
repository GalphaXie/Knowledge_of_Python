# -*- coding: utf-8 -*-

# 代码来自: https://leons.im/posts/a-python-implementation-of-simhash-algorithm/ , 略有修改

import re
from simhash import Simhash


def get_features(s):
    width = 3
    s = s.lower()  # 全部转换成小写
    s = re.sub(r'[^\w]+', '', s)  # 将空白字符或者标点符号 删除
    ret = [s[i:i + width] for i in range(max(len(s) - width + 1, 1))]  # 类似分词操作
    print(ret)
    return ret


print('%x' % Simhash(get_features('How are you? I am fine. Thanks.')).value)
print('%x' % Simhash(get_features('How are u? I am fine.     Thanks.')).value)
print('%x' % Simhash(get_features('How r you?I    am fine. Thanks.')).value)


# 分词
print(Simhash('aa').distance(Simhash('bb')))  # 31
print(Simhash(['aa', 'a']).distance(Simhash(['aa', 'b'])))  # 10



