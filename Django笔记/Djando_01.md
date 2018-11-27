1. 课程特点及要求:
  1.1 难,贴近实战;
  1.2 多,内存+硬盘;
  1.3 非常重要,开发主流;
  1.4 课时长: 补血,加速
2. 学习方法:
  2.1 上课认真听讲  主动听,带着问题去听
  2.2 记笔记  课程主线
  2.3 晚上敲代码 尽量不看视频
  2.4 课堂提问
Q1:
​	1. HTTP 协议
​	2. 中间层处理  --- Flask 请求钩子
​	3. web应用处理流程
​	4. 遵循HTTP协议的发送HTTP请求和接收请求的就是客户端
​	5. MVT(MVC) Model-View-Template  Model-View-Control ;      
​	6. Django 两大特点;
​	7. 如何通过 http://127.0.0.1:8000/users/index 得到 "hello world"结果:  
​		电脑   监听8000 决定由那个视图函数处理  /user/index 
​		7.0 通过 127.0.0.1 访问到当前的电脑; 而Django默认监听 8000 端口,当有请求的时候,默认都被接管.然后来由Django来决定那个视图函数来处理.
​		7.1 去掉前面的 / 
​		7.2 去整个项目的urls.py 中 urlpatterns 列表中 从上往下  找符合的正则
​		7.3 会把已经匹配到的内容(user/) 去掉, 剩下 index/
​		7.4 去应用的urls.py 中 urlpatterns 列表中 从上往下  找符合的正则
​		7.5 调用对应的视图函数,并传入请求对象.
​	8. 301 永久重定向  , global conf 里面自动配置,添加了斜线
​	9. body: xml,json,表单数据 : 都是字符串--报文;   headers: 字符串:k:v; 还可以自定义
​	10. 前后端分离
​	11. get不用 防护 csrf ;因为不会修改;  这个需要注意;不是每种方式都需要csrf;然后开启这个就默认要设置cookie
​	12. postman使用的时候,post-body可以传递: 多媒体表单 | 普通表单 | raw(原始数据) | b字节 

2.字典默认如果 k:v不存在就会报错.但是get()方法就不会报错,推荐.d[k]  VS d.get(k, default = None)
3.关于虚拟环境的注意事项:
​	要删除当前虚拟环境,必须从当前虚拟环境退出;
​	虚拟环境在Ubuntu中必须装在 ~/.virtualenv 下,否则无法正常使用; 
​	虚拟环境安装文件的是,命令前面不能加 sudo;
​	创建 Django项目必须在虚拟环境中,但是项目的目录和虚拟环境没有关系.   其实:直接进入项目的目录,然后在终端输入  workon 回车就看到有哪些虚拟环境.
​		然后,运行之即可进入.
4.创建Django工程为何不推荐直接使用Pycharm?
​	1.如果使用Pycharm直接创建可能导致添加很多额外的配置,这些配置可能会导致在终端运行或者部署上线的时候出现问题.
5. 使用 os.path.join() 的原因:

  1. STATICFILES_DIRS = [ 是个列表,可以接收多个参数(多个静态文件的文件夹),用相对路径以防写死  ]
6. 类比Flask中的url_for函数,Django有 reverse ; 这需要配合 include(使用namespace) VS url( 使用 name ) .
	1. 如果定义了 namespace ,那么使用 reverse 是: reverse( namespace名 : name名 )  eg: reverse('user:xiaoming')
	2. 如果没有定义 namespace, 那么使用 reverse 是: reverse( name名 )  eg: reverse('xiaoming')
	# 注意: 导包是从 from django.urls import reverse  # 注意导包路径  from django.core.urlresolvers import reverse  ???
7. 配置urls的时候两种方式,第二种的区别是: 
	7.1 第一个参数直接写正则的匹配 试图函数名 就可以,然后在浏览器中路径就只用写函数名   ; 
	7.2 第二个参数不再是include,而是 应用名.views.函数名
8. request.GET 属性=>提取查询参数的模式; 
	request.POST => 特殊的请求体   # 重要：request.POST只能用来获取POST方式的请求体  表单数据。
	​	(注意: 1.必须是表单格式: a=b&c=d     2.需要设置 headers-ContentType   3.也是QueryDict类型)
	request.body => 提取请求体,任意类型; 但是都是字节型;   # 提取非表单数据
	
9. META  字典对象 可以获取全部头信息(键是全部大写,横杠换成下划线)
	还有其它: method user 

10. 对比之前:
	常量(大写,推荐读不写):  GET   POST   前面是QueryDict对象     META   字典对象
	小写:  path  body  

11. del删除session和flush()清空的区别: 
	1.前者是删除内容,但是还保留着session_id(默认)
	2.后者全部删除库

12. 类视图的原理(底层调用流程):
	0. 设置路由url里面的第二个参数必须是 [函数]  -- Django底层的入口设计
	1. 通过类名.as_view()来实现,类继承的是View父类,调用类方法as_view(cls),其返回值是view方法的引用,而as_view中又封装了view方法
	2. view方法的返回值是 调用 self.dispatch方法,进行路由分发;
	3. dispatch方法会判断 自己创建的类中是否有对应的http规定的方法; 其次如果有会获取这个对应的方法对象来调用;如果没有则会返回提示和405

13. 装饰器的局限性:
	1. 装饰器不能直接装饰方法: 方法需要传递self参数;   
	2. 方法必须要用  类名(或对象名).方法名(参数) 来调用, 第一个参数默认是self,但是这里可以省略,因为是 . ;  
	3. 但是函数,可以直接调用.
14. 自定义装饰器: 参数的问题,第一个参数是 self 不是 request
15. python中风格是:多继承; 其他语言是单继承;
	多继承-->经典类|新式类-->深度优先|广度优先-->MRO|C3算法
16. 多继承 super  Mixin

17. 问题:
	1. 导包问题
	2. render(request, 'XXX.html')

强调: 看源码要找入口,看方法(函数),看属性,再看返回值.


前置知识:
​	函数装饰器一般都是默认适配函数的,所以要适配方法,就需要自己改写参数保证第一个是self-对象 或 调用 method_decorator装饰器
18. 类视图方法一: 路由(urls.py)配置中添加装饰器:
	1.最开始的思路还是从入口处解决装饰器添加的问题,想到在urls配置中设置.在url的第二个参数的位置使用装饰器;
	2.补充前置知识: 装饰器的实现原理
	​	2.1 装饰器的返回值是其内部函数的引用(这点正好可以和url参数的需求匹配);
	​	2.2 以前接触的装饰器是以语法糖的形式;实际上其本质就是: 装饰之后变成 old_func = my_decorator(old_func=view.BaseView.as_view()) = func_in_my_decorator
	​	2.2 old_func() = my_decorator(old_func)() = func_in_my_decorator()
	3.存在问题:
	​	3.1 不利于代码的完整性--如果单在视图中不知道入口urls.py中添加了装饰器;
	4.优点:简单,代码少;这种添加方式是入口处(路由分发之前)会给所有视图函数都添加
	
19. 类视图方法二:类视图中方法上面直接装饰
	1. 就是将自定义的装饰器放在定义类的方法上面,比如get(self, request)上面.那么它是如何调用的呢?
		get = my_decorator(get) = wrapper ;  而 wrapper的形参是 wrapper(request, *args, **kwargs) 显然和下面的实参不匹配
		调用时: get(self, request) = wrapper(self, request) = get(request, *args, **kwargs) 事实上,会把self传递给request形参,造成View没有相关属性
	2. 解决思路: @method_decorator( my_decorator ) 来转换成可以直接放到方法头上使用的装饰器; 导包: from django.utils.decorators import method_decorator
	3. 存在问题:
		3.1 如果想统一给方法添加装饰器较繁琐,但是又不适合在urls.py中设置,所以我们首先考虑到在view方法设置,但是显然view是封装在as_view内部的,不能直接修改
		3.2 为何获取不到: 在类方法的内部,直接访问不到.但是view方法内部又调用了dispatch方法,而该方法可以直接通过View.dispatch访问
	4. 解决思路:
		可以在自定义的装饰器中给传递的参数的第一个位置指定形参self,这也是Django的实质.
	5. 优势:
		可通过重写,直接实现父类的dispatch方法,只是给这个方法加了一个装饰器而已.
20. 类视图方法三:类视图的类上部直接装饰,只不过要通过关键字参数 name='' 来指明 装饰的方法名.

   1. 如果有多个方法,直接装饰器套在一起;以前加装饰器是功能的"嵌套",这里相当于"并联"
21. 类视图方法四:构造Mixin扩展类 -- 根据方法三的启示,尝试重写 as_view方法
	1.几个而理解的难点:
	​	1.1 为何几个一般的父类要继承 object 类,而不是 View 类?
	​		答: python MRO方法默认在 多态 的时候如果继承同一个父类(如View),那么可能只运行一个单分支找到view就结束.所以这里让父类都继承object类.
	​			object作为基类中没有as_view方法,所以能够保证完全找完,直到最后一个.
	​	1.2 子类继承的最后一个参数必须是View类?
	​		答: 同上,保证最后一个是继承 Django原生的 View类,使用原生的 as_view方法.
	2.实现的方法是:
	​	2.1 定义一个扩展类,类名结尾是XxxMixin(object),继承自object;
	​	2.2 扩展类中 重写 as_view方法, 并加上@classmethod ; 在方法内部 view = super().as_view(*args, **kwargs) ; 
	​	2.3 重写:  view = my_decorator( view )  ,然后 return view
	​	2.4 类视图继承( ...Mixin, View) 其它不需要任何操作.
	3.优势:
	​	3.1 不局限于加装饰器,还可以操作别的代码行为.
	​	3.2 只需要修改继承,就可以同时让多个 类视图 继承装饰器, 而且这里的装饰器可以多样性.

22. Django中request对象的属性问题
	.GET -- 是获取 请求行 的数据, 所以和请求方式无关,不论是 get ,post 等都可以通过该属性来获取 url 参数的问题
	.POST -- 获取的表单数据, 而且注意: POST获取表单数据的前提是 请求头 Headers 中设置了 ContentType 类型.否则获取不到
	.body -- 非表单类型的请求体数据，Django无法自动解析，可以通过request.body属性获取最原始的请求体数据，自己按照请求体格式（JSON、XML等）进行解析。request.body返回bytes类型。
	.META -- 获取请求头   注意: 可能请求头的k名字有(大小写,下划线和横杠)区别. ==> dict 类型
	
	返回类型:
	​	request.method = 'GET' 'POST'
	​	大写 常量 只读
	​	request.GET  => QueryDict
	​	request.POST => QueryDict
	​	request.META => dict
	​	request.body => bytes
	​	request.method => str

23. 做IP记录: META中有一个  REMOTE_ADDR : 127.0.0.1 来记录恶意请求的ip
	
刷赞

绕过 后台 审核

手机号验证

1. 坑, API 不要过度强调
2. 数据库的概念: 入库,字段,查询返回的是?,
3. 面试时间和讲解的通俗

4. 3个人2个月

Django 其它:

数据库保存的是 url ; 可以通过   对象.image.url 来获取
