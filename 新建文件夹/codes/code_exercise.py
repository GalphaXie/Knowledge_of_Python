print("hello python")
print("你好世界")



print("hello")



# 这是第一个注释
print("hello hello")

"""
这是一个多行注释

。。。。

。。。。


。。。。
注释结束了
"""
# 这是第二个注释
print("hello world")  # 输出欢迎信息



# 1. 定义一个变量记录 QQ 号码
qq_number = "1234567"

# 2. 定义一个变量记录 QQ 密码
qq_password = "123"

# 注意：在使用解释器执行 python 程序的时候，不能直接使用变量名
# 在控制台输出变量的信息
qq_number

# 如果希望通过解释器的方式，输出变量的内容，需要使用 print 函数
print(qq_number)
print(qq_password)






# 1. 定义苹果的单价
price = 8.5

# 2. 挑选苹果
weight = 7.5

# 3. 计算付款金额
money = weight * price

# 4. 只要买苹果，就返回 5 块钱
money = money - 5

print(money)





"""
姓名：小明
年龄：18 岁
性别：是男生
身高：1.75 米
体重：75.0 公斤
"""

# 在 Python 中，定义变量时是不需要指定变量的类型的
# 在运行的时候，Python 解释器，会根据赋值语句等号右侧的数据
# 自动推导出变量中保存数据的准确类型
# str 表示是一个字符串类型
name = "小明"
# int 表示是一个整数类型
age = 18
# bool 表示是一个布尔类型，真 True 或者假 False
gender = False  # 不是
# float 表示是一个小数类型，浮点数
height = 1.75

weight = 75

print(name)






# 1. 输入苹果的单价
price_str = input("苹果的单价：")

# 2. 输入苹果的重量
weight_str = input("苹果的重量：")

# 3. 计算支付的总金额
# 注意：两个字符串变量之间是不能直接用乘法的
# money = price_str * weight_str
# 1> 将价格转换成小数
price = float(price_str)

# 2> 将重量转换成小数
weight = float(weight_str)

# 3> 用两个小数来计算最终的金额
money = price * weight

print(money)



# 1. 提示用户输入苹果的单价
price = float(input("苹果的单价："))

# 2. 提示用户输入苹果的重量
weight = float(input("苹果的重量："))

# 3. 计算金额
money = price * weight

print(money)



# 定义字符串变量 name，输出 我的名字叫 小明，请多多关照！
name = "大小明"
print("我的名字叫 %s，请多多关照！" % name)

# 定义整数变量 student_no，输出 我的学号是 000001
student_no = 100123456
print("我的学号是 %06d" % student_no)

# 定义小数 price、weight、money，
# 输出 苹果单价 9.00 元／斤，购买了 5.00 斤，需要支付 45.00 元
price = 8.5
weight = 7.5
money = price * weight
print("苹果单价 %.2f 元／斤，购买了 %.3f 斤，需要支付 %.4f 元" % (price, weight, money))

# 定义一个小数 scale，输出 数据比例是 10.00%
scale = 0.8
print("数据比例是 %.2f%%" % (scale * 100))
