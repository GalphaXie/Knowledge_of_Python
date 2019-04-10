## 五 Djaong基础

### Django介绍

![django_logo](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/django_logo.png)

#### 1. 简介

Django，**发音为[`dʒæŋɡəʊ]**，是用python语言写的开源web开发框架，并遵循MVC设计。劳伦斯出版集团为了开发以新闻内容为主的网站，而开发出来了这个框架，于2005年7月在BSD许可证下发布。这个名称来源于比利时的爵士音乐家DjangoReinhardt，他是一个吉普赛人，主要以演奏吉它为主，还演奏过小提琴等。**由于Django在近年来的迅速发展，应用越来越广泛，被著名IT开发杂志SDTimes评选为2013SDTimes100，位列"API、库和框架"分类第6位，被认为是该领域的佼佼者。**

![django信念](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/django_belief.png)

Django的**主要目的是简便、快速的开发数据库驱动的网站。**它强调代码复用，多个组件可以很方便的以"插件"形式服务于整个框架，Django有许多功能强大的第三方插件，你甚至可以很方便的开发出自己的工具包。这使得Django具有很强的可扩展性。它还强调快速开发和DRY(DoNotRepeatYourself)原则。

#### 2. 特点

##### 1） 重量级框架

对比Flask框架，Django原生提供了众多的功能组件，让开发更简便快速。

- 提供项目工程管理的自动化脚本工具(shell)  ==具体使用,补充链接==
  - 命令行创建工程目录
  - 提供shell
  - 类比 Flask中的 **script 扩展**  ==忘记==
- 数据库ORM支持（对象关系映射，英语：Object Relational Mapping）
- 模板
- 表单
- Admin管理站点
  - 一旦创建完成数据库, 那么就可以自动进行管理后台的 增删改查.
- 文件管理
  - 前端上传文件, 后端自动可以保存到 服务器 指定的位置 ==疑问==
- 认证权限
- session机制
- 缓存
- 等等

##### 2）MVT模式

有一种程序设计模式叫**MVC**，其核心思想是**分工、解耦，让不同的代码块之间降低耦合，增强代码的可扩展性和可移植性，实现向后兼容**。

> MVC的全拼为**Model-View-Controller**，最早由TrygveReenskaug在1978年提出，是施乐帕罗奥多研究中心(Xerox PARC)在20世纪80年代为程序语言Smalltalk发明的一种软件设计模式，是为了将传统的输入（input）、处理（processing）、输出（output）任务运用到图形化用户交互模型中而设计的。随着标准输入输出设备的出现，开发人员只需要将精力集中在业务逻辑的分析与实现上。后来被推荐为Oracle旗下Sun公司Java EE平台的设计模式，并且受到越来越多的使用ColdFusion和PHP的开发者的欢迎。现在虽然不再使用原来的分工方式，但是这种分工的思想被沿用下来，广泛应用于软件工程中，是一种典型并且应用广泛的软件架构模式。后来，MVC的思想被应用在了Ｗeb开发方面，被称为Ｗeb MVC框架。

#### MVC模式说明

![mvc](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/mvc.png)

- M全拼为Model，主要封装对数据库层的访问，对数据库中的数据进行增、删、改、查操作。
- V全拼为View，用于封装结果，生成页面展示的html内容。
- C全拼为Controller，用于接收请求，处理业务逻辑，与Model和View交互，返回结果。

#### Django的MVT

![mvt](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/mvt.png)

- M全拼为Model，与MVC中的M功能相同，负责和数据库交互，进行数据处理。
- V全拼为View，与MVC中的C功能相同，接收请求，进行业务处理，返回应答。
- T全拼为Template，与MVC中的V功能相同，负责封装构造要返回的html。

**注：差异就在于黑线黑箭头标识出来的部分**

#### 3. Django学习资料

- [官方网站](https://www.djangoproject.com/)
- [Github源码](https://github.com/django/django)
- [1.11版英文文档](https://docs.djangoproject.com/en/1.11/)
- [1.11版中文文档](https://yiyibooks.cn/xx/Django_1.11.6/index.html)
- [Django Book 教程](http://djangobook.com/)
- [Tange With Django 教程](http://www.tangowithdjango.com/book17/)









接口设计思路



#### restful风格

**综合上面的解释，RESTful架构就是：**

- **每一个URL代表一种资源；**
- **客户端和服务器之间，传递这种资源的某种表现层；**
- **客户端通过四个HTTP动词，对服务器端资源进行操作，实现"表现层状态转化"。**

```txt
自己的理解:
1. 具象状态转化协议
2. 通过请求的四个方法(POST, GET, PUT, PATCH, DELETE)  来获取资源
3. 主要是url,将之前的查询参数变成资源路径. url中使用名词, 且使用复数
```





#### 使用drf实现视图时的思路

- 先以视图为主
- 分析视图实现的具体逻辑
- 思考逻辑中有哪些可以使用 drf 框架提供的工具来复用代码
  - 序列化
    - 参数校验
    - 保存
    - 序列化返回数据
  - 视图扩展类  子类视图
    - 视图整个实现的流程  可以复用的代码





## 六 Django框架

### 1. 环境创建和工程创建注意事项

#### 1.1 环境创建和工程创建

- 1.推荐 `1.XX` 版本的 **Django** ,  在虚拟环境中通过 `-p` 选项来指定对应的 解释器版本, 如果不指定可能会默认是python2的解释器.

- 2.推荐通过命令行的模式创建 `django` 工程, 然后再在 **pycharm** 中进行适当配置(如果不能自动找到新创建的django虚拟环境,则需要我们手动添加虚拟环境;  对于通过manage.py启动来说还需要我们添加必要的启动参数 `runserver` 这些).

  - 2.1 解释: 如果直接通过 pycharm 创建工程 可能会自动添加其它额外参数, 可能导致在 线上命令行部署时候出现其它的一些问题.
  - 2.2 补充：我们在pycharm打开django工程的时候, 发现会自动创建 `db.splite3` 数据库, 这是 **django** 默认数据库.  在我们配置指定的数据库之后, 该文件会被django自动删除.

- 3.**manage.py** 不仅是功能模块,  还是 **Django** 提供的脚本文件的模块, 可以用来提供 **django命令模式来操作django项目**, 类似 Flask 框架的 Script 模块. 

- 4.单个django工程 | 单个app 分别包括:

  - 4.1 **settings.py**  **urls.py**  **uwsgi**  **\_\_init\_\_.py**  和平行的 **manage.py** , **db.splite3**
  - 4.2 **migrations文件夹**  **\_\_init\_\_.py**  **admin.py(后台管理站点)**  **apps.py(关于该子应用的一些配置信息)**  **models.py**  **tests.py(子引用的单元测试)**  **views.py**  和 我们需要自己创建的 **serializers.py**  **urls.py**

  ![django项目目录结构](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/django_pro_dir.png)

  - 与项目同名的目录，此处为demo。
  - **settings.py** 是项目的整体配置文件。
  - **urls.py** 是项目的URL配置文件。
  - **wsgi.py** 是项目与WSGI兼容的Web服务器入口。
  - **manage.py** 是项目管理文件，通过它管理项目。

- 5.运行 **开发服务器**

  `python manage.py runserver ip:端口`  其中,  `ip:port`可省略, 则默认: **127.0.0.1:8000 **

  `python manage.py runserver` 运行 服务器

  - django默认工作在调式Debug模式下，如果增加、修改、删除文件，服务器会自动重启。
  - 按ctrl+c停止服务器。

#### 1.2 创建子应用

​	在Web应用中，通常有一些业务功能模块是在不同的项目中都可以复用的，故在开发中通常将工程项目拆分为不同的子功能模块，各功能模块间可以保持相对的独立，在其他工程项目中需要用到某个特定功能模块时，可以将该模块代码整体复制过去，达到复用。

在Flask框架中也有类似子功能应用模块的概念，即蓝图Blueprint。

**Django的视图编写是放在子应用中的。**

##### 通过命令行创建子应用

 `python manage.py startapp 子应用名称`   备注: 可能需要创建目录如apps等(看需求)

- **admin.py** 文件跟网站的后台管理站点配置相关。
- **apps.py** 文件用于配置当前子应用的相关信息。
  - 注: **子应用的配置文件**,和在`settings.py`中注册APP联系起来, **app_name.apps.XxConfig**
  - 类比 **Flask** 中的 **蓝图注册**, 将独立的蓝图模块和项目配置关联起来.
- **migrations** 目录用于存放数据库迁移历史文件夹。
- **models.py** 文件用户保存数据库模型类。  ==整理常见的套路==
- **tests.py** 文件用于开发测试用例，编写单元测试。
- **views.py** 文件用于编写Web应用视图。

![app子应用的目录结构](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/app_dir.png)

#### 1.3 注册APP

创建出来的子应用目录文件虽然被放到了工程项目目录中，但是django工程并不能立即直接使用该子应用，需要注册安装后才能使用。

在工程配置文件settings.py中，**INSTALLED_APPS**项保存了工程中已经注册安装的子应用，初始工程中的INSTALLED_APPS如下：

![初始INSTALLED_APPS](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/initial_installed_apps.png)

- **注册安装一个子应用的方法，即是将子应用的配置信息文件apps.py中的Config类添加到INSTALLED_APPS列表中。**
- 从 **1.8 版本**之后, 注册路由就不在直接使用 **子应用的名字** 而是 代替成 **子应用名.apps.配置类的名字**
- 注意: 项目中, 往往有**多个 APP 应用**, 常常会创建**apps**目录, 将各个应用添加到apps目录下, 则需要在 **settings.py** 文件中配置 `sys.path.insert(0, os.path.join(BASE_DIR, "apps"))` 

#### 1.4 APP应用配置

在每个应用目录中都包含了apps.py文件，用于保存该应用的相关信息。

在创建应用时，Django会向apps.py文件中写入一个该应用的配置类，如

```python
from django.apps import AppConfig

class UsersConfig(AppConfig):
    name = 'users'
```

我们将此类添加到工程settings.py中的INSTALLED_APPS列表中，表明注册安装具备此配置属性的应用。

- **AppConfig.name** 属性表示这个配置类是加载到哪个应用的，每个配置类必须包含此属性，默认自动生成。

- **AppConfig.verbose_name** 属性用于设置该应用的直观可读的名字，此名字在Django提供的Admin管理站点中会显示，如

  ```python
  from django.apps import AppConfig
  
  class UsersConfig(AppConfig):
      name = 'users'
      verbose_name = '用户管理'  # 涉及到admin的时候要设置
  ```



#### 1.4 创建视图函数或视图类

*<u>同Flask框架一样，Django也用视图来编写Web应用的业务逻辑。</u>*

*<u>Django的视图是定义在子应用的views.py中的</u>*

##### 1.4.1 打开刚创建的users模块，在views.py中编写视图代码。

```python
from django.http import HttpResponse  # 注意导包的位置, 注意包名; 不要和爬虫中HTTPResponse混淆

def index(request):  # 必须有request参数
    """
    index视图
    :param request: 包含了请求信息的请求对象
    :return: 响应对象
    """
    return HttpResponse("hello the world!")  # 不能直接返回一个字符串
```

说明：

- 视图函数的第一个传入参数必须定义，用于接收Django构造的包含了请求数据的**HttpReqeust**对象，通常名为**request**。
  - ==区别==: **Flask** 中是 `from flask import request` 请求上下文来获取到`request` 对象.
- 视图函数的返回值必须为一个响应对象，不能像**Flask一样直接返回一个字符串**，可以将要返回的字符串数据放到一个**HTTPResponse**对象中。

##### 1.4.2 类视图

<a href="#4.1 类视图">点击跳转(Ctrl+单击)</a>



#### 1.5 定义路由url

##### 1) 在子应用中新建一个`urls.py`文件用于保存该应用的路由。

##### 2) 在users/urls.py文件中定义路由信息。

```python
from django.conf.urls import url  # 导包

from . import views

# urlpatterns是被django自动识别的路由列表变量
urlpatterns = [
    # 每个路由信息都需要使用url函数来构造
    # url(路径, 视图)  元素不是简单的元组,而是url()函数对象
    # 第一个参数: url路径字符串; 
    # 第二个参数: 函数. 所以,类试图需要通过 as_view() 转换成函数.
    url(r'^index/$', views.index),    # $ 结尾, 以防 url 覆盖问题的发生. 但是 项目url不能, 否则报错.
]
```

关于**视图集**,  还有一种设置 url 的方式:

```pyton
router = DefaultRouter()
router.register('app_name', views.App_View_ViewSet, base_name="xxx")
urlpatterns = []
urlpatterns += router.urls
```



##### 3) 在工程总路由demo/urls.py中添加子应用的路由数据。

```python
from django.conf.urls import url, include
from django.contrib import admin

urlpatterns = [
    url(r'^admin/', admin.site.urls),  # django默认包含的

    # 添加
    url(r'^users/', include('users.urls')), 
]
# 该文件上面有关于如何创建 urlpatterns 变量的提示信息, 在创建django项目的时候自动生成
```

- 使用include来将子应用users里的全部路由包含进工程路由中；
- r'^users/' 决定了users子应用的所有路由都已/users/开头，如我们刚定义的视图index，其最终的完整访问路径为/users/index/。

include函数除了可以传递字符串之外，也可以直接传递应用的urls模块，如

```python
from django.conf.urls import url, include
from django.contrib import admin
import users.urls  # 先导入应用的urls模块

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    # url(r'^users/', include('users.urls')),
    url(r'^users/', include(users.urls)),  # 添加应用的路由
]
```

##### 4) 启动运行

重新启动django程序

```shell
python manage.py runserver
```

### 2. 配置、静态文件与路由

#### 2.1 配置文件

##### 1. BASE_DIR

```python
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # 这里也可能需要结合实际情况调整.
```

当前工程的根目录，Django会依此来定位工程内的相关文件，我们也可以使用该参数来构造文件路径。

实战:

- 在项目中一般会 创建 apps 文件夹用来 放多个 app , 需要添加到 **python解释器** 的搜索路径中, 代码 `sys.path.insert(0, os.path.join(BASE_DIR, 'apps'))` , 注: 也有使用 `os.path.append()` 方法的; 其次要注意 同时用到 `os` 和 `sys` 模块.
- 类似的还有,  常常需要创建不同环境下的 运行环境, 那么需要在 `manage.py`中修改 django项目的默认配置环境: `os.environ.setdefault("DJANGO_SETTINGS_MODULE", "buyfree_mall.settings.dev")`.

##### 2. SECRET_KEY 

​	该变量是创建 django 项目的时候自动生成的, 其值常用于 加密传输过程, 不要泄露.

##### 3. DEBUG

调试模式，创建工程后初始值为**True**，即默认工作在调试模式下。

作用：

- 修改代码文件，程序自动重启
- Django程序出现异常时，向前端显示详细的错误追踪信息，例如

![error](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/error_trackback.png)

​	而非调试模式下，仅返回Server Error (500)

 **特别注意：部署线上运行的Django不要运行在调式模式下，记得修改DEBUG=False。**

- 如果DEBUG = False , 那么必须要进行  ALLOWED_HOSTS 配置.

##### 4. ALLOWED_HOSTS

​	允许访问的 **域名** 或者 **IP** , 如  ALLOWED_HOSTS=['127.0.0.1', 'www.yuming.com']

​	配置任意:  ALLOWED_HOSTS = ['*']

##### 5. INSTALLED_APPS

- 注意区分 django 不同版本的不同写法.
- django 会自带一部分

##### 6. MIDDLEWARE

- 重点: **关注顺序:** 在视图函数执行之前是从上往下调用, 视图函数执行过程中是从下往上调用.  ( ==需要核实, 视图函数执行结束之后== )
- 通常分为三部分: 
  - 1.django 自带的 app 
  - 2.我们使用三方工具引入的 app
  - 3.我们自己定义的视图 app. `app_name.apps.App_nameConfig`
- 实例

```python
MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',  # 2. 关注顺序(一定要添加到最前面)  # 解决跨域请求
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```

##### 7. ROOT_URLCONF = 'pro_name.urls'   

​	创建项目,自动生成

##### 8. TEMPLATES  模板配置

```python
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],  # 配置模板文件的目录
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',                			'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
```

##### 9. WSGI_APPLICATION = 'pro_name.wsgi.application'

##### 10. DATABASES

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',  # 后端可以配置, mysql、oracle 等等
        'HOST': '127.0.0.1',  # 数据库主机
        'PORT': 3306,  # 数据库端口
        'USER': 'user_name',  # 数据库用户名
        'PASSWORD': 'password',  # 数据库用户密码
        'NAME': 'db_name'  # 数据库名字
    }
}
```

== 考虑数据库集群如何配置, 考虑如何分配用户的权限, 不要直接使用 root 账户, 不安全 ==

##### 11. CACHES  

<u>注: 是django框架中比较重要的部分</u>

配置方式: 以字典的形式配置, 内部元素也是字典, k用于标记保存对应数据的名字, 配置三个值

```python
CACHES = {
    "default": {  # 默认的是用于做什么呢?
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379/0",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    "session": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379/1",  指明数据库ip:port/库名
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    "verify_codes": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379/2",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    "history": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379/3",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    "cart": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379/4",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    }
}

# 给admin站点使用的session
SESSION_ENGINE = "django.contrib.sessions.backends.cache"
SESSION_CACHE_ALIAS = "session"
```

*<u>注: redis 数据库也是可以设置 用户名和密码的,  这种情况下有些配置需要添加</u>*

##### 12. AUTH_PASSWORD_VALIDATORS    密码校验



##### 13. 本地语言与时区

<u>*Django支持本地化处理，即显示语言与时区支持本地化。*</u>

本地化是将显示的语言、时间等使用本地的习惯，这里的本地化就是进行中国化，中国大陆地区使用**简体中文**，时区使用**亚洲/上海**时区，注意这里不使用北京时区表示。

初始化的工程默认语言和时区为**英语**和**UTC**标准时区, 但是在做定时任务的时候可能还存在问题.

```python
LANGUAGE_CODE = 'en-us'  # 语言
TIME_ZONE = 'UTC'  # 时区
```

将语言和时区修改为中国大陆信息

```python
LANGUAGE_CODE = 'zh-hans'  # 记忆方式: zhongwen ,  hanyu  s 
TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True
USE_L10N = True
USE_TZ = False  # 使用本地时间, 禁止使用UTC, 否则数据库保存时间会比本地慢8h

# 可以参考:
https://blog.csdn.net/lmb20056127/article/details/77862904
```

![worked](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/chinese_index_page.png)

##### 14. STATIC_URL='/static/'   是 django 的默认配置

```python
STATIC_URL = '/static/'  # 静态文件的前缀, 类比Flask中的 pre_fix
STATICFILES_DIRS = [  # 复数, 配置列表
    os.path.join(BASE_DIR, 'static_files')  
]
# django 一旦 发现传递过来的请求是 /static/..., 那么直接去请求本地的静态文件, 而不会再进行动态url解析.
# django是一个动态框架, 所以在生产模式下, django默认关闭 提供静态文件的功能, 转而提供一个函数来收集静态文件打包交给专门的静态文件服务器处理.
```

==待补充完善,  如何使用打包静态文件的函数==





##### 15. 配置日志



##### 16. REST_FRAMEWORK



##### 17. JWT_AUTH



##### 18. AUTH_USER_MODEL = 'users.User'  # 配置,让django使用我们定义的模型



##### 19. CORS_ORIGIN_WHITELIST













#### 2.2 静态文件

项目中的CSS、图片、js都是静态文件。一般会将静态文件放到一个单独的目录中，以方便管理。在html页面中调用时，也需要指定静态文件的路径，Django中提供了一种解析的方式配置静态文件路径。静态文件可以放在项目根目录下，也可以放在应用的目录下，由于有些静态文件在项目中是通用的，所以**推荐放在项目的根目录下，方便管理**。

为了提供静态文件，需要配置两个参数：

- **STATICFILES_DIRS** 存放查找静态文件的目录    <u>注: `S`说明是容器类型, 可以有多个元素.</u>
- **STATIC_URL** 访问静态文件的URL前缀

##### 示例

1） 在项目根目录下创建static_files目录来保存静态文件。

2） 在demo/settings.py中修改静态文件的两个参数为

```python
STATIC_URL = '/static/'
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static_files'),
]
```

3）此时在static_files添加的任何静态文件都可以使用网址 **/static/文件在static_files中的路径** 来访问了。

例如，我们向static_files目录中添加一个index.html文件，在浏览器中就可以使用127.0.0.1:8000/static/index.html来访问。

或者我们在static_files目录中添加了一个子目录和文件goods/detail.html，在浏览器中就可以使用127.0.0.1:8000/static/goods/detail.html来访问。

##### 注意

Django 仅在调试模式下（DEBUG=True）能对外提供静态文件。

当DEBUG=False工作在生产模式时，Django不再对外提供静态文件，需要是用collectstatic命令来收集静态文件并交由其他静态文件服务器来提供。==（详细在部署时会讲）==

#### 2.3 路由

##### 1. 路由定义位置

Django 在 `settings.py`文件中有根路由`ROOT_URL` 配置.

Django的主要路由信息定义在工程同名目录下的urls.py文件中，该文件是Django解析路由的入口。

每个子应用为了保持相对独立，可以在各个子应用中定义属于自己的urls.py来保存该应用的路由。然后用主路由文件包含各应用的子路由数据。

除了上述方式外，也可将工程的全部路由信息都定义在主路由文件中，子应用不再设置urls.py。如：

```
from django.conf.urls import url
from django.contrib import admin
import users.views

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^users/index/$', users.views.index)
]

```

##### 2. 路由解析顺序

Django在接收到一个请求时，从主路由文件中的urlpatterns列表中以由上至下的顺序查找对应路由规则，如果发现规则为include包含，则再进入被包含的urls中的urlpatterns列表由上至下进行查询。

值得关注的**由上至下**的顺序，有可能会使上面的路由屏蔽掉下面的路由，带来非预期结果。例如：

```python
urlpatterns = [
    url(r'^say', views.say),
    url(r'^sayhello', views.sayhello),
]
```

即使访问sayhello/路径，预期应该进入sayhello视图执行，但实际优先查找到了say路由规则也与sayhello/路径匹配，实际进入了say视图执行。

###### 提示：

**需要注意定义路由的顺序，避免出现屏蔽效应。**

##### 3. 路由命名与reverse反解析（逆向）

###### 3.1 路由命名

在定义路由的时候，可以为路由命名，方便查找特定视图的具体路径信息。

1) 在使用include函数定义路由时，可以使用namespace参数定义路由的命名空间，如

```python
url(r'^users/', include('users.urls', namespace='users')),   # 命名空间
```

命名空间表示，凡是users.urls中定义的路由，均属于namespace指明的users名下。

**命名空间的作用：避免不同应用中的路由使用了相同的名字发生冲突，使用命名空间区别开。**

2) 在定义普通路由时，可以使用name参数指明路由的名字，如

```python
urlpatterns = [
    url(r'^index/$', views.index, name='index'),
    url(r'^say', views.say, name='say'),  # 命名
]
```

###### 3.2 reverse反解析  <u>注: 同Flask 中的 url_for</u>

使用reverse函数，可以根据路由名称，返回具体的路径，如：

```python
from django.core.urlresolvers import reverse  # 注意导包路径

def index(request):
    return HttpResponse("hello the world!")

def say(request):
    url = reverse('users:index')  # 返回 /users/index/
    print(url)
    return HttpResponse('say')
```

- 对于未指明namespace的，reverse(路由name)
- 对于指明namespace的，reverse(命名空间namespace:路由name)     *<u>namespace 是 一个 url集合</u>*
- 类比,  Flask 中的 `url_for`

##### 4. 路径结尾斜线/的说明

Django中定义路由时，通常以斜线/结尾，其好处是用户访问不以斜线/结尾的相同路径时，Django会把用户重定向到以斜线/结尾的路径上，而不会返回404不存在。如

```python
urlpatterns = [
    url(r'^index/$', views.index, name='index'),
]
```

用户访问 index 或者 index/ 网址，均能访问到index视图。

**说明：**

虽然路由结尾带/能带来上述好处，但是却违背了HTTP中URL表示资源位置路径的设计理念。

是否结尾带/以所属公司定义风格为准。

```python
# 关于  301、302 区别和 斜线结尾的知识补充
1. 301 302 浏览器缓存
301 永久重定向, django 会将网页内容保存在本地浏览器缓存中, 如果不清除则下次访问会直接从本地拿取数据;
302 临时重定向, 每次发起请求都是 发起两次请求才拿到资源.

前提: 默认情况下:
    在`urls.py`配置中 如果结尾以 / , 那么在访问的时候:
        如果 没有加/ 且 浏览器本地无缓存, 那么会进行两次请求 301 和 200;
        如果 没有加/ 且 浏览器本地有缓存, 那么会进行一次请求 200; (301灰色)
        如果 加了 / , 均是 200;
    在`urls.py`配置中 如果结尾 不以 / , 那么访问的时候:
        如果 没有加 / , 均是 200;
        如果加 /  , 那么 返回 404 ;
总之: 
    如果配置url正则的时候没有加, 那么django不会自动加上;
    如果配置url正则的时候有加, 那么django会自动加上.
```







### 3. 请求和响应 COOKIE和SESSION

#### 3.1 请求 Request

回想一下，利用**HTTP协议向服务器传参**有几种途径？

- 提取URL的特定部分(路径参数)，如/weather/beijing/2018，可以在服务器端的路由中用正则表达式截取；
- 查询字符串（query string)，形如key1=value1&key2=value2；
- 请求体（body）中发送的数据，如表单数据、json、xml；  *<u>注: 必须是可以传递请求体的method</u>*
- 在http报文的头（header）中。

##### 1 URL路径参数

在定义路由URL时，可以使用正则表达式提取参数的方法从URL中获取请求参数，Django会将提取的参数直接传递到视图的传入参数中。

- 未命名参数按定义顺序传递， 如

  ```python
  # 位置参数变成 关键字参数
  url(r'^weather/([a-z]+)/(\d{4})/$', views.weather),  # url函数自带正则匹配功能
  
  def weather(request, city, year):
      print('city=%s' % city)
      print('year=%s' % year)
      return HttpResponse('OK')
  ```

- 命名参数按名字传递，如

  ```python
  url(r'^weather/(?P<city>[a-z]+)/(?P<year>\d{4})/$', views.weather),  # 这种方式更被推荐一些
  
  def weather(request, year, city):
      print('city=%s' % city)
      print('year=%s' % year)
      return HttpResponse('OK')
  ```

##### 2 Django中的QueryDict对象

定义在django.http.QueryDict

**HttpRequest对象的属性GET、POST都是QueryDict类型的对象**

与python字典不同，QueryDict类型的对象用来处理同**一个键带有多个值**的情况

- 方法get()：根据键获取值

  如果一个键同时拥有多个值将获取最后一个值

  **如果键不存在则返回None值，可以设置默认值进行后续处理**

  ```python
  dict.get('键',默认值)
  可简写为
  dict['键']
  ```

- 方法getlist()：根据键获取值，值以列表返回，可以获取指定键的所有值

  如果键不存在则返回空列表[]，可以设置默认值进行后续处理

  ```python
  dict.getlist('键',默认值)
  ```

##### 3. 查询字符串Query String

获取请求路径中的查询字符串参数（形如?k1=v1&k2=v2），可以通过request.GET属性获取，返回QueryDict对象。

```python
# /qs/?a=1&b=2&a=3

def qs(request):
    a = request.GET.get('a')
    b = request.GET.get('b')
    alist = request.GET.getlist('a')
    print(a)  # 3
    print(b)  # 2
    print(alist)  # ['1', '3']
    return HttpResponse('OK')
```

**重要：查询字符串不区分请求方式，即假使客户端进行POST方式的请求，依然可以通过request.GET获取请求中的查询字符串数据。**

##### 4 请求体

请求体数据格式不固定，可以是表单类型字符串，可以是JSON字符串，可以是XML字符串，应区别对待。

可以发送请求体数据的请求方式有**POST**、**PUT**、**PATCH**、**DELETE**。

**Django默认开启了CSRF防护**，会对上述请求方式进行CSRF防护验证，在测试时可以关闭CSRF防护机制，方法为在settings.py文件中注释掉CSRF中间件，如：

![](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/csrf_middleware.png)

###### 4.1 表单类型 Form Data

前端发送的表单类型的请求体数据，可以通过request.POST属性获取，返回QueryDict对象。

```python
def get_body(request):
    a = request.POST.get('a')
    b = request.POST.get('b')
    alist = request.POST.getlist('a')
    print(a)
    print(b)
    print(alist)
    return HttpResponse('OK')
```

**重要：只要请求体的数据是表单类型，无论是哪种请求方式（POST、PUT、PATCH、DELETE），都是使用request.POST来获取请求体的表单数据。结果也是QueryDict类型.**

###### 4.2 非表单类型 Non-Form Data

非表单类型的请求体数据，Django无法自动解析，可以通过**request.body**属性获取最原始的请求体数据，自己按照请求体格式（JSON、XML等）进行解析。**request.body返回bytes类型。**

**注意: 请求体的数据在提交的时候, 还要注意需要配套 `Content-Type:xxx`**

例如要获取请求体中的如下JSON数据

```json
{"a": 1, "b": 2}
```

可以进行如下方法操作：

```python
import json

def get_body_json(request):
    json_str = request.body
    json_str = json_str.decode()  # python3.6 无需执行此步
    req_data = json.loads(json_str)
    print(req_data['a'])
    print(req_data['b'])
    return HttpResponse('OK')
```

##### 5 请求头

可以通过**request.META**属性获取请求头headers中的数据，**request.META为字典类型**。

*<u>注: django中的请求头的写法部分和 历览器中看到的请求头的写法有一些细小的差别. django把字符全部转换成大写, 然后将横杠变成下划线</u>*

常见的请求头如：

- `CONTENT_LENGTH` – The length of the request body (as a string).
- `CONTENT_TYPE` – The MIME type of the request body.
- `HTTP_ACCEPT` – Acceptable content types for the response.
- `HTTP_ACCEPT_ENCODING` – Acceptable encodings for the response.
- `HTTP_ACCEPT_LANGUAGE` – Acceptable languages for the response.
- `HTTP_HOST` – The HTTP Host header sent by the client.
- `HTTP_REFERER` – The referring page, if any.
- `HTTP_USER_AGENT` – The client’s user-agent string.
- `QUERY_STRING` – The query string, as a single (unparsed) string.
- `REMOTE_ADDR` – The IP address of the client.
- `REMOTE_HOST` – The hostname of the client.
- `REMOTE_USER` – The user authenticated by the Web server, if any.
- `REQUEST_METHOD` – A string such as `"GET"` or `"POST"`.
- `SERVER_NAME` – The hostname of the server.
- `SERVER_PORT` – The port of the server (as a string).

具体使用如:

```python
def get_headers(request):
    print(request.META['CONTENT_TYPE'])
    return HttpResponse('OK')
```

##### 6 其他常用HttpRequest对象属性

- **method**：一个**字符串**，表示请求使用的HTTP方法，常用值包括：'GET'、'POST'。
- **user：请求的用户对象。**
- path：一个字符串，表示请求的页面的完整路径，不包含域名和参数部分。
- encoding：一个字符串，表示提交的数据的编码方式。
  - 如果为None则表示使用浏览器的默认设置，一般为utf-8。
  - 这个属性是可写的，可以通过修改它来修改访问表单数据使用的编码，接下来对属性的任何访问将使用新的encoding值。
- FILES：一个类似于字典的对象，包含所有的上传文件。

```python
# 小结一下:
1. request 是django封装的对象(HttpRequest), 具有一些常用的属性和方法, 比如  GET, POST, user, method等
2. request 是django中基于应用层(HTTP协议)的对象, 所以其通过前端传递参数的方式有 4 种, 分别是:
    2.1 位置(路径)参数, 可以直接通过 django 提供的正则方式(小括号)提取;  或者通过命名的方式(?P<name>)转化成 命名参数 , 在参数较复杂的情况下推荐使用;
    2.2.0: QueryDict 对象, 父类是python中的dict, 但是它可以处理 '一键多值'
    2.2 查询参数(query_params), 即?k=v, 存在一键多值, 取最后一个. 通过 reqeust对象的 GET 属性(其返回值是: QueryDict)获取, request.GET.get()  或 request.GET.getlist() -- 获取的是一个列表(会覆盖);
    2.3 请求体(body), 在 原生 django 中要分成两类:
        2.3.1 表单类型, 通过 POST属性的 get 和 getlist 获取. 返回的也是 QueryDict对象
        2.3.2 非表单类型(xml, json, 二进制等) , 通过 body 属性获取, 是'bytes'对象,要用其对应类型的方式获取.如json, json.loads()方法
    2.4 请求头(header), 通过 META 属性获取, 返回的是 'dict' 对象.如, request.META['CONTENT_TYPE']
3. 其他常用属性
# 总之, 要搞清楚 HttpRequest对象(通常在视图中用 reqeust 参数来引用)的常用属性, 以及对应的 前端传递参数的类型, 以及每种属性的返回值是什么?返回值的不同类型决定了其取值方式的不同.

# 其他补充:
在Flask中是通过 视图函数增加路由装饰器, <int:xx> 这种 路由转换器, django 直接通过 url()函数的正则方法, 提取 () 中的原子.
大P 表示 参数 params 的意思
查询参数是 get post 都可以提交的,因为他们保存在 请求报文中的请求行 中, 这种分析思路要具备, 考虑一种传递参数的方式是否可以被 不同的方法所使用其核心还是判断 不同的请求方式的请求报文的构成.

# django 中 视图函数是不限制访问方式的, 类视图中指明的除外; Flask 通过 method 来指明.
```





#### 3.2 响应 Response

视图在接收请求并处理后，必须返回HttpResponse对象或子对象。HttpRequest对象由Django创建，HttpResponse对象由开发人员创建。

##### 1 HttpResponse

可以使用**django.http.HttpResponse**来构造响应对象。

```python
HttpResponse(content=响应体, content_type=响应体数据类型, status=状态码)
```

也可通过HttpResponse对象属性来设置响应体、响应体数据类型、状态码：

- content：表示返回的内容。
- status_code：返回的HTTP响应状态码。
- content_type：指定返回数据的的MIME类型。

**响应头**可以直接将HttpResponse对象当做字典进行响应头键值对的设置：

```python
response = HttpResponse()
response['language'] = 'Python'  # 自定义响应头language, 值为Python
```

示例：

```python
from django.http import HttpResponse

def demo_view(request):
    return HttpResponse('language python', status=400)
    或者
    response = HttpResponse('language python')
    response.status_code = 400  # 通过属性的方式设置
    response['language'] = 'Python'
    return response
```

##### 2 HttpResponse子类

Django提供了一系列HttpResponse的子类，可以快速设置状态码

- HttpResponseRedirect 301
- HttpResponsePermanentRedirect 302
- HttpResponseNotModified 304
- HttpResponseBadRequest 400
- HttpResponseNotFound 404
- HttpResponseForbidden 403
- HttpResponseNotAllowed 405
- HttpResponseGone 410
- HttpResponseServerError 500

##### 3 JsonResponse

若要返回json数据，可以使用JsonResponse来构造响应对象，作用：

- 1. 帮助我们将数据转换为json字符串
- 1. 设置响应头**Content-Type**为 **application/json**

```python
from django.http import JsonResponse

def demo_view(request):
    return JsonResponse({'city': 'beijing', 'subject': 'python'})
```

##### 4 redirect重定向

```python
from django.shortcuts import redirect

def demo_view(request):
    return redirect('/index.html')
```





#### 3.3 Cookie

​	Cookie，有时也用其复数形式Cookies，指某些网站为了辨别用户身份、进行session跟踪而储存在用户本地终端上的数据（通常经过加密）。Cookie最早是网景公司的前雇员Lou Montulli在1993年3月的发明。Cookie是由服务器端生成，发送给User-Agent（一般是浏览器），浏览器会将Cookie的key/value保存到某个目录下的文本文件内，下次请求同一网站时就发送该Cookie给服务器（前提是浏览器设置为启用cookie）。Cookie名称和值可以由服务器端开发自己定义，这样服务器可以知道该用户是否是合法用户以及是否需要重新登录等。服务器可以利用Cookies包含信息的任意性来筛选并经常性维护这些信息，以判断在HTTP传输中的状态。Cookies最典型记住用户名。

Cookie是存储在浏览器中的一段纯文本信息，建议不要存储敏感信息如密码，因为电脑上的浏览器可能被其它人使用。

**Cookie的特点**

- Cookie以键值对的格式进行信息的存储。
- Cookie**基于域名安全**，不同域名的Cookie是不能互相访问的，如访问google.cn时向浏览器中写了Cookie信息，使用同一浏览器访问baidu.com时，无法访问到google.cn写的Cookie信息。
- 当浏览器请求某网站时，会**(自动)**将浏览器存储的跟网站相关的所有Cookie信息提交给网站服务器。

##### 1 设置Cookie

可以通过HttpResponse对象中的set_cookie方法来设置cookie。

```python
HttpResponse.set_cookie(cookie名, value=cookie值, max_age=cookie有效期)
```

- **max_age** 单位为秒，默认为**None**。如果是临时cookie，可将max_age设置为None。
  示例：

```python
def demo_view(request):
    response = HttpResponse('ok')
    response.set_cookie('language1', 'python1')  # 临时cookie
    response.set_cookie('language2', 'python2', max_age=3600)  # 有效期一小时
    return response
```

##### 2 读取Cookie

可以通过**HttpRequest对象**的**COOKIES**属性来读取本次请求携带的cookie值。**request.COOKIES为字典类型**。

```python
def demo_view(request):
    cookie1 = request.COOKIES.get('language1')
    print(cookie1)
    return HttpResponse('OK')
```

#### 3.4 Session

##### 1 启用Session

**Django项目默认启用Session。**

可以在settings.py文件中查看，如图所示

![](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/session_middleware.png)

如需禁用session，将上图中的session中间件注释掉即可。

##### 2 存储方式

在settings.py文件中，可以设置session数据的存储方式，可以保存在数据库、本地缓存等。

##### 2.1 数据库

存储在数据库中，如下设置可以写，也可以不写，**这是默认存储方式**。

```python
SESSION_ENGINE='django.contrib.sessions.backends.db'
```

如果存储在数据库中，需要在项INSTALLED_APPS中安装Session应用。

![](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/session_app.png)

数据库中的表如图所示

![](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/session_database.png)

表结构如下

![](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/session_table.png)

由表结构可知，操作Session包括三个数据：键，值，过期时间。

##### 2.2 本地缓存

存储在本机内存中，如果丢失则不能找回，比数据库的方式读写更快。

```python
SESSION_ENGINE='django.contrib.sessions.backends.cache'
```

**注意:** **<u>本地缓存可能存在跨机的问题, 当有多台服务器的时候分别保存在各自的本地, 那么不同的请求可能会访问不同的主机,而session只保存在其中的一台主机上, 所以可能会出现问题. 用redis, 搭建在一台单独的主机上解决.</u>**

##### 2.3 混合存储

优先从本机内存中存取，如果没有则从数据库中存取。

```python
SESSION_ENGINE='django.contrib.sessions.backends.cached_db'
```

##### 2.4 Redis

在redis中保存session，需要引入第三方扩展，我们可以使用**django-redis**来解决。

1） 安装扩展

```python
pip install django-redis  # 综合后端, 既可以当作 server来使用, 还可以当作 client 来使用.
```

2）配置

在settings.py文件中做如下设置:

```python
# django 中引入 redis 的本质原理还是, 利用了 redis 的引擎: cache, 所以下面的配置有 SESSION_ENGINE, 指向cache, 只不过把 CACHE 后端给修改成 RedisCache, 而不是在本地的内存中.

CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379/1",  # 指明redis的位置.
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    }
}
SESSION_ENGINE = "django.contrib.sessions.backends.cache"
SESSION_CACHE_ALIAS = "default"  # 将操作django的 cache 和 rediscache 联系起来.
```

###### 注意

如果redis的ip地址不是本地回环127.0.0.1，而是其他地址，访问Django时，可能出现Redis连接错误，如下：

![](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/redis_connect_error.png)

解决方法：

修改redis的配置文件，添加特定ip地址。

打开redis的配置文件

```shell
sudo vim /etc/redis/redis.conf
```

在如下配置项进行修改（如要添加10.211.55.5地址）

![](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/modify_redis_config.png)

重新启动redis服务

```shell
sudo service redis-server restart
```

##### 3 Session操作

通过HttpRequest对象的session属性进行会话的读写操作。

1） 以键值对的格式写session。

```
request.session['键']=值

```

2）根据键读取值。

```
request.session.get('键',默认值)

```

3）清除所有session，在存储中删除值部分。

```python
request.session.clear()  # 只删值
```

4）清除session数据，在存储中删除session的整条数据。

```
request.session.flush()  # 如果非redis数据库也是这个操作嘛?

```

5）删除session中的指定键及值，在存储中只删除某个键及对应的值。

```
del request.session['键']

```

6）设置session的有效期

```
request.session.set_expiry(value)

```

- 如果value是一个整数，session将在value秒没有活动后过期。
- 如果value为0，那么用户session的Cookie将在用户的浏览器关闭时过期。
- 如果value为None，那么session有效期将采用系统默认值，**默认为两周**，可以通过在settings.py中设置**SESSION_COOKIE_AGE**来设置全局默认值。

------

关于session还有很多内容需要深入了解

------

### 4. 类视图与中间件

#### 4.1 类视图  

<a href="#1.4.2 类视图">点击返回(Ctrl+点击)</a>

##### 1 类视图引入

以函数的方式定义的视图称为**函数视图**，函数视图便于理解。但是遇到一个视图对应的路径提供了多种不同HTTP请求方式的支持时，便需要在一个函数中编写不同的业务逻辑，代码可读性与复用性都不佳。

```python
 def register(request):
    """处理注册"""

    # 获取请求方法，判断是GET/POST请求
    if request.method == 'GET':
        # 处理GET请求，返回注册页面
        return render(request, 'register.html')
    else:
        # 处理POST请求，实现注册逻辑
        return HttpResponse('这里实现注册逻辑')
```

在Django中也可以使用类来定义一个视图，称为**类视图**。

使用类视图可以将视图对应的不同请求方式以类中的不同方法来区别定义。如下所示

```python
from django.views.generic import View

class RegisterView(View):
    """类视图：处理注册"""

    def get(self, request):
        """处理GET请求，返回注册页面"""
        return render(request, 'register.html')

    def post(self, request):
        """处理POST请求，实现注册逻辑"""
        return HttpResponse('这里实现注册逻辑')
```

类视图的好处：

- **代码可读性好**
- **类视图相对于函数视图有更高的复用性**， 如果其他地方需要用到某个类视图的某个特定逻辑，直接继承该类视图即可

##### 2 类视图使用

定义类视图需要继承自Django提供的父类**View**，可使用`from django.views.generic import View`或者`from django.views.generic.base import View` 导入，定义方式如上所示。

**配置路由时，使用类视图的as_view()方法来添加**。

```python
urlpatterns = [
    # 视图函数：注册
    # url(r'^register/$', views.register, name='register'),
    # 类视图：注册
    url(r'^register/$', views.RegisterView.as_view(), name='register'),
]
```

##### 3 类视图原理

```python
    @classonlymethod  # django封装的类方法, 所以url配置第二个参数要用类名调用
    def as_view(cls, **initkwargs):
        """
        Main entry point for a request-response process.
        """
        ...省略代码...

        def view(request, *args, **kwargs):
            self = cls(**initkwargs)
            if hasattr(self, 'get') and not hasattr(self, 'head'):
                self.head = self.get
            self.request = request
            self.args = args
            self.kwargs = kwargs
            # 调用dispatch方法，按照不同请求方式调用不同请求方法
            return self.dispatch(request, *args, **kwargs)

        ...省略代码...

        # 返回真正的函数视图
        return view


    def dispatch(self, request, *args, **kwargs):
        # Try to dispatch to the right method; if a method doesn't exist,
        # defer to the error handler. Also defer to the error handler if the
        # request method isn't on the approved list.
        if request.method.lower() in self.http_method_names:
            handler = getattr(self, request.method.lower(), self.http_method_not_allowed)
        else:
            handler = self.http_method_not_allowed
        return handler(request, *args, **kwargs)
```

##### 4 类视图使用装饰器

为类视图添加装饰器，可以使用三种方法(url配置中装饰; 为特定的请求方式添加装饰器; 使用扩展类)。

为了理解方便，我们先来定义一个**为函数视图准备的装饰器**（在设计装饰器时基本都以函数视图作为考虑的被装饰对象），及一个要被装饰的类视图。

```python
def my_decorator(func):
    def wrapper(request, *args, **kwargs):
        print('自定义装饰器被调用了')
        print('请求路径%s' % request.path)
        return func(request, *args, **kwargs)
    return wrapper

class DemoView(View):
    def get(self, request):
        print('get方法')
        return HttpResponse('ok')

    def post(self, request):
        print('post方法')
        return HttpResponse('ok')
```

###### 4.1 在URL配置中装饰

```python
urlpatterns = [
    url(r'^demo/$', my_decorate(DemoView.as_view()))
]
```

此种方式最简单，但因装饰行为被放置到了url配置中，单看视图的时候无法知道此视图还被添加了装饰器，不利于代码的完整性，不建议使用。

**此种方式会为类视图中的所有请求方法都加上装饰器行为**（因为是在视图入口处，分发请求方式前）。

> 补充关于 **装饰器** 的理解:
>
> 装饰器就是在原来函数外面装了一层壳,然后再赋值给原函数
>
> `func = my_deractor(func)`

###### 4.2 在类视图中装饰

在类视图中使用为函数视图准备的装饰器时，不能直接添加装饰器，需要使用**method_decorator**将其转换为适用于类视图方法的装饰器。

**method_decorator装饰器使用name参数指明被装饰的方法**

*<u>注: method_decorator 是django封装的方法, 使得我们可以像装饰函数一样来装饰 django类视图中的方法</u>*

**思考:  为何要封装方法才能处理 类视图 的方法?**

> **参数个数变化, 对应不上.**具体来说:
>
> 因为源码中, dispatch()等方法都是类方法, 其第一个参数都是 `self` , django处理之后会添加上 self , 和原来view函数的参数 `def view(request, *args, **kwargs):` 进行补充.

```python
# 1. 为全部请求方法添加装饰器
# 思考: 为何要指明 dispatch 而不选用 view 方法?  答:取不到
@method_decorator(my_decorator, name='dispatch')
class DemoView(View):
    def get(self, request):
        print('get方法')
        return HttpResponse('ok')

    def post(self, request):
        print('post方法')
        return HttpResponse('ok')


# 2. 为特定请求方法添加装饰器
@method_decorator(my_decorator, name='get')
class DemoView(View):
    def get(self, request):
        print('get方法')
        return HttpResponse('ok')

    def post(self, request):
        print('post方法')
        return HttpResponse('ok')
```

**如果需要为类视图的多个方法添加装饰器，但又不是所有的方法（为所有方法添加装饰器参考上面例子），可以直接在需要添加装饰器的方法上使用method_decorator，如下所示**

```python
from django.utils.decorators import method_decorator

# 为特定请求方法添加装饰器
class DemoView(View):

    @method_decorator(my_decorator)  # 为get方法添加了装饰器
    def get(self, request):
        print('get方法')
        return HttpResponse('ok')

    @method_decorator(my_decorator)  # 为post方法添加了装饰器
    def post(self, request):
        print('post方法')
        return HttpResponse('ok')

    def put(self, request):  # 没有为put方法添加装饰器
        print('put方法')
        return HttpResponse('ok')
```

##### 5 类视图Mixin扩展类

> 类视图Mixin扩展类装饰器引入:
>
> ```python
> class BaseViewMixin(View):
>    
>    @classmethod  # 重写类方法 as_view
>    def as_view(cls, *args, **kwargs):
>        view = super().as_view()  # 获取父类的 view函数, 然后对其进行装饰
>        view = mydecorator(view)
>        return view
> 
> class DemoView(BaseView):
>    def get(self, request):
>        return HttpResponse('response body')
>    def post(self, request):
>        return HttpResponse("响应体")
> ```
>
>

**使用面向对象多继承的特性，可以通过定义父类（作为扩展类），在父类中定义想要向类视图补充的方法，类视图继承这些扩展父类，便可实现代码复用。**

定义的扩展父类名称通常以**Mixin结尾**。

举例如下：

```python
class ListModelMixin(object):
    """
    list扩展类
    """
    def list(self, request, *args, **kwargs):
        ...

class CreateModelMixin(object):
    """
    create扩展类
    """
    def create(self, request, *args, **kwargs):
        ...

class BooksView(CreateModelMixin, ListModelMixin, View):
    """
    同时继承两个扩展类，复用list和create方法
    """
    def get(self, request):
        self.list(request)
        ...

    def post(self, request):
        self.create(request)
        ...

class SaveOrderView(CreateModelMixin, View):
    """
    继承CreateModelMixin扩展类，复用create方法
    """
    def post(self, request):
        self.create(request)
        ...
```

> 补充 **多继承**  探讨:
>
> 不同爷爷(View1和View2)--深度优先;  相同爷爷(最后一层,同一个爷爷View)-- 广度优先.
>
> ![不同爷爷](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E4%B8%8D%E5%90%8C%E7%88%B7%E7%88%B7%E5%9E%82%E7%9B%B4%E9%A1%BA%E5%BA%8F.png)
>
> ![相同爷爷](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E7%9B%B8%E5%90%8C%E7%88%B7%E7%88%B7%E6%B0%B4%E5%B9%B3%E9%A1%BA%E5%BA%8F.png)
>
> 思考2:
>
> 为什么要将 `django` 提供的原本的 `view` 作为爷爷放在多继承的最后, 因为同一个爷爷在python中是 **广度优先** , 保证前面所有的 view 都执行完需要的装饰之后再执行 原来的 view. 
>
> 而 如果是 **深度优先** 那么可能在部分需要 **扩展的view** 执行之前原来的 view 率先执行, 则达不到需要的效果.



#### 4.2 中间件

Django中的中间件是一个**轻量级、底层的**插件系统，可以**介入Django的请求和响应处理过程**，修改Django的输入或输出。中间件的设计为开发者提供了一种无侵入式的开发方式，增强了Django框架的健壮性。

我们可以使用中间件，在Django处理视图的不同阶段对输入或输出进行干预。

*<u>注: 关于使用 类视图装饰器和中间件是一个选择问题, 结合需求来处理. 如果是更普遍通用的功能需求更加推荐中间件.</u>*

**对所有的 视图函数 生效 !  相对 类视图装饰器 更加广泛**

##### 4.2.1 中间件的定义方法

**定义一个中间件工厂函数，然后返回一个可以被调用的中间件。**

中间件工厂函数需要接收一个可以调用的`get_response对象`。

返回的中间件也是一个可以被调用的对象，并且像视图一样需要接收一个request对象参数，返回一个response对象。

```python
def simple_middleware(get_response):
    # 此处编写的代码仅在Django第一次配置和初始化的时候执行一次。
    # 可以类比 Flask 中的  before_first_request 请求钩子的代码

    def middleware(request):
        # 此处编写的代码会在每个请求处理视图前被调用。
        # 可类比 Flask 中的 before_request 请求钩子的代码

        response = get_response(request)

        # 此处编写的代码会在每个请求处理视图之后被调用。
        # 类比 Flask 的 after_rqeust 请求钩子

        return response

    return middleware
```

例如，在**users应用**中新建一个`middleware.py`文件，

```python
def my_middleware(get_response):
    print('init 被调用')
    def middleware(request):
        print('before request 被调用')
        response = get_response(request)
        print('after response 被调用')
        return response
    return middleware
```

**定义好中间件后，需要在settings.py 文件中添加注册中间件**

```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    # 'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'users.middleware.my_middleware',  # 添加中间件
]
```

定义一个视图进行测试

```python
def demo_view(request):
    print('view 视图被调用')
    return HttpResponse('OK')
```

执行结果

![中间件测试](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/middleware_demo.png)

**注意：Django运行在调试模式下，中间件init部分有可能被调用两次。** 生产模式一次

##### 4.2.2 执行流程

![中间件执行流程](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E4%B8%AD%E9%97%B4%E4%BB%B6%E6%89%A7%E8%A1%8C%E6%B5%81%E7%A8%8B.png)

##### 4.2.3 多个中间件的执行顺序

- 在请求视图被处理**前**，中间件**由上至下**依次执行
- 在请求视图被处理**后**，中间件**由下至上**依次执行

![中间件顺序](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/middleware_sequence.png)

示例：

定义两个中间件

```python
def my_middleware(get_response):
    print('init 被调用')
    def middleware(request):
        print('before request 被调用')
        response = get_response(request)
        print('after response 被调用')
        return response
    return middleware

def my_middleware2(get_response):
    print('init2 被调用')
    def middleware(request):
        print('before request 2 被调用')
        response = get_response(request)
        print('after response 2 被调用')
        return response
    return middleware
```

注册添加两个中间件

```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    # 'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'users.middleware.my_middleware',  # 添加
    'users.middleware.my_middleware2',  # 添加
]
```

执行结果

```python
init2 被调用
init 被调用
before request 被调用
before request 2 被调用
view 视图被调用
after response 2 被调用
after response 被调用
```

执行结果小结:

```python
# 1. 初始化的情况下, 定义在下面的 中间件反而 先执行;
# 2.1多个不同的中间件有一个 "从上往下, 从下往上"的执行顺序; 
# 2.2而同一个中间件内部也有自身的执行顺序, "初始化, 视图之前, 视图自身, 视图之后"

最贴切的比喻是:  用竹签穿过一只洋葱.
```





### 5. 数据库

#### 5.0 介绍

##### ORM框架

O是object，也就**类对象**的意思，R是relation，翻译成中文是关系，也就是关系数据库中**数据表**的意思，M是mapping，是**映射**的意思。在ORM框架中，它帮我们把类和数据表进行了一个映射，可以让我们**通过类和类对象就能操作它所对应的表格中的数据**。ORM框架还有一个功能，它可以**根据我们设计的类自动帮我们生成数据库中的表格**，省去了我们自己建表的过程。

django中**内嵌了ORM框架**，不需要直接面向数据库编程，而是定义模型类，通过模型类和对象完成数据表的增删改查操作。

> **使用django进行数据库开发的步骤如下：**
>
> 1. **配置数据库连接信息**
> 2. **在models.py中定义模型类**
> 3. **迁移**
> 4. **通过类和对象完成数据增删改查操作**

```python
关于ORM的理解:
    提供一个"框架", 让我们可以 直接操作类来转化成 原生的SQL语句;
    django(程序)和数据库之间通信,采用的是 tcp 通信网络链接, 需要依赖数据库驱动,才能将原生的SQL语句从 框架(程序)端传递给 关系型数据库. 我们需要进行配置ip和port等.
    在Flask中,我们除了需要 sqlalchemy , 我们还需要依赖 flask-mysqldb
    在 django 中框架 只认 mysqldb 库,但是其只支持 python2 的版本. 而python3不再支持 mysqldb, 所以需要安装  pymsql
# 代码如下:
import pymysql
pymysql.install_as_MySQLdb()
```



##### **ORM作用**

![orm](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/orm.png)

![orm](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/orm2.png)



#### 5.1 配置

在settings.py中保存了数据库的连接配置信息，Django默认初始配置使用**sqlite**数据库。

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
```

1. 使用**MySQL**数据库首先需要安装驱动程序

   ```shell
   pip install PyMySQL
   ```

2. 在Django的工程同名子目录的`__init__.py`文件中添加如下语句,在初始化进行配置

   ```python
   from pymysql import install_as_MySQLdb
   
   install_as_MySQLdb()
   ```

   作用是让Django的ORM能以mysqldb的方式来调用PyMySQL。

3. 修改**DATABASES**配置信息

   ```python
   DATABASES = {
       'default': {
           'ENGINE': 'django.db.backends.mysql',
           'HOST': '127.0.0.1',  # 数据库主机
           'PORT': 3306,  # 数据库端口
           'USER': 'root',  # 数据库用户名
           'PASSWORD': 'mysql',  # 数据库用户密码
           'NAME': 'django_demo'  # 数据库名字
       }
   }
   ```

4. 在MySQL中创建数据库

   ```mysql
   create database django_demo default charset=utf8;
   ```



#### 5.2 定义模型类

- 模型类被定义在"应用的`models.py`"文件中。
- 模型类必须继承自Model类，位于`包django.db.models`中。

接下来首先以"图书-英雄"管理为例进行演示。

##### 1 定义

创建应用book，在models.py 文件中定义模型类。

> 补充知识:
>
> - `django`中 模型类的字段在表中是真实存在的, 包括 **relationship 字段**, 这个和 Flask中是有区别的.
> - 不需要我们去主动创建 数据库实例, 直接通过 类的继承 即可. 不同于 Flask. ==待补充==
> - `django` 会自动生成主键, 并且是自增的, 不需要我们自己去创建和指明. 如果我们想**设置自己的主键**, 那么在**某个字段**选项指明为主键即可, 默认的主键则自动生效并且不会被创建.  而且可以直接去 通过 `模型类.id`来进行查询等操作.

```python
from django.db import models  # 导包 和 继承

#定义图书模型类BookInfo
class BookInfo(models.Model):
    title = models.CharField(max_length=20, verbose_name='名称')
    pub_date = models.DateField(verbose_name='发布日期')
    read = models.IntegerField(default=0, verbose_name='阅读量')
    comment = models.IntegerField(default=0, verbose_name='评论量')
    is_delete = models.BooleanField(default=False, verbose_name='逻辑删除')

    class Meta:
        db_table = 'tb_books'  # 指明数据库表名
        verbose_name = '图书'  # 在admin站点中显示的名称
        verbose_name_plural = verbose_name  # 显示的复数名称

    def __str__(self):
        """定义每个数据对象的显示信息"""
        return self.title

#定义英雄模型类HeroInfo
class HeroInfo(models.Model):
    GENDER_CHOICES = (  # 枚举类型, 元组包裹, 其内部的元素也是元组
        (0, 'male'),  # 第一个元素是: 数据库中的value, 第二个对应的注释.
        (1, 'female')
    )
    name = models.CharField(max_length=20, verbose_name='名称') 
    gender = models.SmallIntegerField(choices=GENDER_CHOICES, default=0, verbose_name='性别')  # SmallIntegerField 小整数字段, 枚举
    comment = models.CharField(max_length=200, null=True, verbose_name='描述信息')  # null 可以为空 
    book = models.ForeignKey(BookInfo, on_delete=models.CASCADE, verbose_name='图书')  # 外键
    # 第一个参数是关联的模型类.然后自动将模型类的主键作为该 字段 的约束, 该字段的类型也就确定为 IntegerField.
    # 级联. 第二个参数: 来指明"一"和"多"删除操作的时候的不同选项.从django1.9之后都建议指明.  参考下面的选项.
    # 该属性的显示信息, 区别: 在 django中是 模型对象, 而在Flask中是对应的值. 
    # 会自动在数据库表中保存为 hbook_id
    is_delete = models.BooleanField(default=False, verbose_name='逻辑删除')

    class Meta:
        db_table = 'tb_heroes'
        verbose_name = '英雄'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.hname
```

**1） 数据库表名**

模型类如果未指明表名，Django默认以 `**小写app应用名_小写模型类名**` 为数据库表名。

可通过**db_table** 指明数据库表名。

**2） 关于主键**

django会为表创建自动增长的主键列，每个模型只能有一个主键列，如果使用选项设置某属性为主键列后django不会再创建自动增长的主键列。

默认创建的主键列属性为id，可以使用pk代替，pk全拼为primary key。

**3） 属性命名限制**

- 不能是python的保留关键字。

- 不允许使用连续的下划线，这是由django的查询方式决定的。

- 定义属性时需要指定字段类型，通过字段类型的参数指定选项，语法如下：

  ```python
  属性=models.字段类型(选项)
  ```

**4）字段类型**

| 类型              | 说明                                                         |
| ----------------- | ------------------------------------------------------------ |
| AutoField         | 自动增长的IntegerField，通常不用指定，不指定时Django会自动创建属性名为id的自动增长属性. 和我们自己指定的某些id无关. |
| BooleanField      | 布尔字段，值为True或False                                    |
| NullBooleanField  | 支持Null、True、False三种值                                  |
| CharField         | 字符串，参数max_length表示最大字符个数, max_length参数必填.  |
| TextField         | 大文本字段，一般超过4000个字符时使用                         |
| SmallIntegerField | 小整数, 搭配 枚举类型 使用                                   |
| IntegerField      | 整数                                                         |
| DecimalField      | 十进制浮点数， 参数max_digits表示总位数， 参数decimal_places表示小数位数 |
| FloatField        | 浮点数                                                       |
| DateField         | 日期， 参数auto_now表示每次保存对象时，自动设置该字段为当前时间，用于"最后一次修改"的时间戳，它总是使用当前日期，默认为False； 参数auto_now_add表示当对象第一次被创建时自动设置当前时间，用于创建的时间戳，它总是使用当前日期，默认为False; 参数auto_now_add和auto_now是相互排斥的，组合将会发生错误<br /><u>*友情提示: 需要在django的settings.py文件中做好 时区 配置, 否则保存在数据库中的时间要比当前时间慢8h.</u>* |
| TimeField         | 时间，参数同DateField                                        |
| DateTimeField     | 日期时间，参数同DateField                                    |
| FileField         | 上传文件字段                                                 |
| ImageField        | 继承于FileField，对上传的内容进行校验，确保是有效的图片      |

**5） 选项**

| 选项        | 说明                                                         |
| ----------- | ------------------------------------------------------------ |
| null        | 如果为True，表示允许为空(不填)，默认值是False                |
| blank       | 如果为True，则该字段允许为空白，默认值是False                |
| db_column   | 字段的名称，如果未指定，则使用属性的名称. (模型类的属性名和数据库具体字段名可以不相同, 可以对字段名进行设置.) |
| db_index    | 若值为True, 则在表中会为此字段创建索引，默认值是False        |
| default     | 默认                                                         |
| primary_key | 若为True，则该字段会成为模型的主键字段，默认值是False，一般作为AutoField的选项使用 |
| unique      | 如果为True, 这个字段在表中必须有唯一值，默认值是False        |

**null是数据库范畴的概念，blank是表单验证范畴的**

> 具体解释:
>
> null是数据库表的 概念, 来控制写入数据表的字段是否可以为空;
>
> blank 是 **表单和模板** 的概念, 具体提交的字段是否 **可以不填, 或者填空白字符.** 一般很少涉及到.

**6） 外键**

在设置外键时，需要通过**on_delete**选项指明主表删除数据时，对于外键引用表数据如何处理，在django.db.models中包含了可选常量：

- **CASCADE** 级联，删除主表数据时连通一起删除外键表中数据

- **PROTECT** 保护，通过抛出**ProtectedError**异常，来阻止删除主表中被外键应用的数据

- **SET_NULL** 设置为NULL，仅在该字段null=True允许为null时可用

- **SET_DEFAULT** 设置为默认值，仅在该字段设置了默认值时可用

- **SET()** 设置为特定值或者调用特定方法，如

  ```python
  from django.conf import settings
  from django.contrib.auth import get_user_model
  from django.db import models
  
  def get_sentinel_user():
      return get_user_model().objects.get_or_create(username='deleted')[0]
  
  class MyModel(models.Model):
      user = models.ForeignKey(
          settings.AUTH_USER_MODEL,
          on_delete=models.SET(get_sentinel_user),
      )
  ```

- **DO_NOTHING** 不做任何操作，如果数据库前置指明级联性，此选项会抛出**IntegrityError**异常

##### 2 迁移

将模型类同步到数据库中。需要说明: 这里的数据库迁移比Flask数据库迁移要简单.

**1）生成迁移文件**

```python
python manage.py makemigrations
```

**2）同步到数据库中**

```python
python manage.py migrate
```

##### 3 添加测试数据

```mysql
insert into tb_books(title,pub_date,`read`,comment,is_delete) values
('射雕英雄传','1980-5-1',12,34,0),
('天龙八部','1986-7-24',36,40,0),
('笑傲江湖','1995-12-24',20,80,0),
('雪山飞狐','1987-11-11',58,24,0);

-- 坑: read 是mysql的关键字, 这里需要 `` 包裹.

insert into tb_heros(name,gender,book_id,comment,is_delete) values
('郭靖',1,1,'降龙十八掌',0),
('黄蓉',0,1,'打狗棍法',0),
('黄药师',1,1,'弹指神通',0),
('欧阳锋',1,1,'蛤蟆功',0),
('梅超风',0,1,'九阴白骨爪',0),
('乔峰',1,2,'降龙十八掌',0),
('段誉',1,2,'六脉神剑',0),
('虚竹',1,2,'天山六阳掌',0),
('王语嫣',0,2,'神仙姐姐',0),
('令狐冲',1,3,'独孤九剑',0),
('任盈盈',0,3,'弹琴',0),
('岳不群',1,3,'华山剑法',0),
('东方不败',0,3,'葵花宝典',0),
('胡斐',1,4,'胡家刀法',0),
('苗若兰',0,4,'黄衣',0),
('程灵素',0,4,'医术',0),
('袁紫衣',0,4,'六合拳',0);
```

#### 5.3 shell工具使用及mysql数据库日志动态展示

##### 1 shell工具

Django的manage工具提供了**shell**命令，帮助我们**配置好当前工程的运行环境（如连接好数据库等）**，以便可以直接在终端中执行测试python语句。

通过如下命令进入shell

```python
python manage.py shell
```

![django shell](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/django_shell.png)

> 二、重要提示:
>
> - 在  `test.py` 文件中写命令, 会有提示且方便修改.
> - 如果发生模型类的修改, 需要先 `quit()` 退出交互终端, 重新进入.
> - 模型类中有些处理比较模糊, 比如 id=1 和 id="1"都会有效,  date(1999,1,1) 和 '1999-1-1' 也都有效.

导入两个模型类，以便后续使用

```python
from booktest.models import BookInfo, HeroInfo
```

##### 2 查看MySQL数据库日志

*<u>**注: 可以通过动态查看来观察 django 如何通过 orm 来写出 sql语句**</u>*

查看mysql数据库日志可以查看对数据库的操作记录。 mysql日志文件默认没有产生，需要做如下配置：

```shell
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
```

![mysql 日志](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/mysql_log.png)

把68，69行前面的#去除，然后保存并使用如下命令重启mysql服务。

```shell
sudo service mysql restart
```

使用如下命令打开mysql日志文件。

```shell
tail -f /var/log/mysql/mysql.log  # 可以实时查看数据库的日志内容
# 如提示需要sudo权限，执行
# sudo tail -f /var/log/mysql/mysql.log
```

#### 5.4 数据库操作—增、删、改、查

##### 1 增加

增加数据有两种方法。

**1）save**

通过创建模型类对象，执行对象的save()方法保存到数据库中。

> - 1.实例模型类对象
> - 2.赋值 (==注意: 赋值操作, key就不要加 引号 否则会报错; 而且这里直接是用`等号`赋值操作的,不用冒号.==)
> - 3.调用实例的 save() 方法

```python
>>> from datetime import date
>>> book = BookInfo(
    title='西游记',  
    pub_date=date(1988,1,1),
    read=10,
    comment=10
)
>>> book.save()  # 执行这一步才会保存到数据库
>>> hero = HeroInfo(
    name='孙悟空',
    gender=0,
    book=book  # 外键关联, 这里是方式之一, 可以直接传递对象. 因为上面正好有查询过 book 模型对象.
)
>>> hero.save()
>>> hero2 = HeroInfo(
    name='猪八戒',
    gender=0,
    book_id=book.id  # 方式之二, 可以这几使用django自动创建的 hbook_id 字段, 然后将 关联的 book.id 赋值给它.
)
>>> hero2.save()
```

**2）create**

通过模型类的objects属性的create()保存。  `模型类.objects.create()`

```python
>>> HeroInfo.objects.create(
    hname='沙悟净',
    gender=0,
    hbook=book
)
<HeroInfo: 沙悟净>  # 该方法有返回值.   创建好的模型对象
```

> 小结:
>
> 一、创建两种方式:
>
> - 1.save  三步走
> - 2.create .. 
>   - 关注:  外键关联字段,  传入对象  或  id

##### 2 查询

###### 2.1 基本查询

**get** 查询单一结果，如果不存在会抛出**`模型类.DoesNotExist`**异常。返回是 **对象**  

- 1.不同于 Flask 返回None;   所以需要 **异常捕获**
- 2.Flask中get只能传递 **id** , 而Django中不局限于id,且可以同时传递多个条件.
- 1. 如果存在多个结果, 则会报 `models.MultipleObjectsReturned` 错误

**all** 查询多个结果。   注: 不能传递条件

**count** 查询结果数量。

== 疑问:  为何没有提  `first()` 方法呢? ==

```python
>>> BookInfo.objects.all()
<QuerySet [<BookInfo: 射雕英雄传>, <BookInfo: 天龙八部>, <BookInfo: 笑傲江湖>, <BookInfo: 雪山飞狐>, <BookInfo: 西游记>]>
>>> book = BookInfo.objects.get(title='西游记')
>>> book.id
5

>>> BookInfo.objects.get(id=3)
<BookInfo: 笑傲江湖>
>>> BookInfo.objects.get(pk=3)
<BookInfo: 笑傲江湖>
>>> BookInfo.objects.get(id=100)
Traceback (most recent call last):
  File "<console>", line 1, in <module>
  File "/Users/delron/.virtualenv/dj/lib/python3.6/site-packages/django/db/models/manager.py", line 85, in manager_method
    return getattr(self.get_queryset(), name)(*args, **kwargs)
  File "/Users/delron/.virtualenv/dj/lib/python3.6/site-packages/django/db/models/query.py", line 380, in get
    self.model._meta.object_name
db.models.DoesNotExist: BookInfo matching query does not exist.

>>> BookInfo.objects.count()
6
```

###### 2.2 过滤查询

实现SQL中的where功能，包括

- **filter** 过滤出多个结果
  - 返回查询集, 即使只有一个结果也是查询集的形式, 可以用 `first`方法提取出来,再进行`save()`等操作, 防止报错.
- **exclude** 排除掉符合条件剩下的结果
- **get** 过滤单一结果          <u>*注: 不可聚合, 不可排序*</u>

对于过滤条件的

使用，上述三个方法相同，故仅以**filter**进行讲解。

过滤条件的表达语法如下：

```python
属性名称__比较运算符=值
# 属性名称和比较运算符间使用两个下划线，所以属性名不能包括多个下划线
```

**1）相等**

**exact：表示判等。**

例：查询编号为1的图书。

```django
BookInfo.objects.filter(id__exact=1)
可简写为：
BookInfo.objects.filter(id=1)
```

**2）模糊查询**

**contains：是否包含。**

> 说明：如果要包含%无需转义，直接写即可。

例：查询书名包含'传'的图书。

```python
BookInfo.objects.filter(title__contains='传')   # %传%
```

**startswith、endswith：以指定值开头或结尾。**

例：查询书名以'部'结尾的图书

```python
BookInfo.objects.filter(title__endswith='部')
```

> 以上运算符都区分大小写，在这些运算符前加上i表示不区分大小写，如iexact、icontains、istartswith、iendswith.

**3） 空查询**

**isnull：是否为null。**

例：查询书名不为空的图书。

```python
BookInfo.objects.filter(title__isnull=False)
```

**4） 范围查询**

**in：是否包含在范围内。**

例：查询编号为1或3或5的图书

```python
BookInfo.objects.filter(id__in=[1, 3, 5])  # 容器对象都可以, 不限列表
```

**5）比较查询**

- **gt** 大于 (greater then)
- **gte** 大于等于 (greater then equal)
- **lt** 小于 (less then)
- **lte** 小于等于 (less then equal)

例：查询编号大于3的图书

```python
BookInfo.objects.filter(id__gt=3)
```

**不等于的运算符，使用exclude()过滤器。**

例：查询编号不等于3的图书

```python
BookInfo.objects.exclude(id=3)
```

**6）日期查询**

**year、month、day、week_day、hour、minute、second：对日期时间类型的属性进行运算。**

例：查询1980年发表的图书。

```python
BookInfo.objects.filter(pub_date__year=1980)
```

例：查询1980年1月1日后发表的图书。

```python
BookInfo.objects.filter(pub_date__gt=date(1990, 1, 1))
```

###### F对象

> 提示:
>
> 多用于 update 场景

之前的查询都是**对象的属性与常量值比较**，两个属性怎么比较呢？ 答：使用F对象，被定义在`django.db.models`中。 

语法如下：

```
F(属性名)

```

例：查询阅读量大于等于评论量的图书。

```python
from django.db.models import F  #  filter -- F对象

BookInfo.objects.filter(read__gte=F('comment'))
```

**可以在F对象上使用算数运算。**

例：查询阅读量大于2倍评论量的图书。

```python
BookInfo.objects.filter(read__gt=F('comment') * 2)
```

###### Q对象

> 提示:
>
> `from django.db.models import Q`
>
> 实际上就是 `Query 类`,   然后多用于  查询条件比较复杂的场景可以来使用.如
>
> - `qs = Q(条件1)`  和 `qs2 = Q(条件2)` 等, 然后 `filter( qs | qs2)`

**多个过滤器逐个调用表示逻辑与关系，同sql语句中where部分的and关键字。**

例：查询阅读量大于20，并且编号小于3的图书。

```python
BookInfo.objects.filter(read__gt=20,id__lt=3)
或
BookInfo.objects.filter(read__gt=20).filter(id__lt=3)
```

**如果需要实现逻辑或or的查询，需要使用Q()对象结合|运算符**，Q对象被义在django.db.models中。

语法如下：

```
Q(属性名__运算符=值)

```

例：查询阅读量大于20的图书，改写为Q对象如下。

```python
from django.db.models import Q

BookInfo.objects.filter(Q(read__gt=20))
```

`Q对象可以使用&、|连接，&表示逻辑与，|表示逻辑或。`

例：查询阅读量大于20，或编号小于3的图书，只能使用Q对象实现

```python
BookInfo.objects.filter(Q(read__gt=20) | Q(pk__lt=3))
```

`Q对象前可以使用~操作符，表示非not`。

例：查询编号不等于3的图书。

```python
BookInfo.objects.filter(~Q(pk=3))
```

###### 聚合函数

使用aggregate()过滤器调用聚合函数。聚合函数包括：**Avg** 平均，**Count** 数量，**Max** 最大，**Min** 最小，**Sum** 求和，被定义在django.db.models中。

例：查询图书的总阅读量。

```python
from django.db.models import Sum

BookInfo.objects.aggregate(Sum('read'))
```

注意aggregate的返回值是一个**字典类型**，格式如下：

```python
  {'属性名__聚合方法小写':值}
  如:{'read__sum':3}
```

使用count时一般不使用aggregate()过滤器。

例：查询图书总数。

```python
BookInfo.objects.count()
```

注意count函数的返回值是一个数字。

###### 2.3 排序

使用**order_by**对结果进行排序

```python
BookInfo.objects.all().order_by('read')  # 升序
BookInfo.objects.all().order_by('-read', 'id')  # 降序
# 可以传入多个字段的排序.
```

###### 2.4 关联查询

由一到多的访问语法：

`一对应的模型类对象.多对应的模型类名小写_set` 例：

```python
b = BookInfo.objects.get(id=1)
b.heroinfo_set.all()
```

由多到一的访问语法:

`多对应的模型类对象.多对应的模型类中的关系类属性名` 例：

```python
h = HeroInfo.objects.get(id=1)
h.hbook
```

访问一对应的模型类关联对象的id语法:

`多对应的模型类对象.关联类属性_id`

例：

```python
h = HeroInfo.objects.get(id=1)
h.hbook_id
```

###### 关联过滤查询

**由多模型类条件查询一模型类数据**:

语法如下：

```python
关联模型类名小写__属性名__条件运算符=值
```

**注意：如果没有"__运算符"部分，表示等于。**

例：

查询图书，要求图书英雄为"孙悟空"

```python
BookInfo.objects.filter(heroinfo__hname='孙悟空')
```

查询图书，要求图书中英雄的描述包含"八"

```python
BookInfo.objects.filter(heroinfo__hcomment__contains='八')
```

**由一模型类条件查询多模型类数据**:

语法如下：

```python
一模型类关联属性名__一模型类属性名__条件运算符=值
# 备注一下:
一模型类关联属性名 指代的是 多模型类中的外键关联(一模型类)的那个属性
```

**注意：如果没有"__运算符"部分，表示等于。**

例：

查询书名为“天龙八部”的所有英雄。

```python
HeroInfo.objects.filter(hbook__title='天龙八部')
```

查询图书阅读量大于30的所有英雄

```python
HeroInfo.objects.filter(hbook__read__gt=30)
```

> 小结:
>
> ​	通俗的记忆就是, 一对多 或 多对一 在语法上都是**一个模型类作为"查询的基准"**,另外一个作为过滤条件. 其中,  如果**过滤条件**可以写`外键关联属性`的用属性, 没有外键关联的属性的就用 `模型类小写`

##### 3 修改

修改更新有两种方法

**1）save**

**修改模型类对象的属性，然后执行save()方法**

```python
hero = HeroInfo.objects.get(hname='猪八戒')
hero.hname = '猪悟能'
hero.save()
```

**2）update**

**使用模型类.objects.filter().update()**，会返回受影响的行数

```python
HeroInfo.objects.filter(hname='沙悟净').update(hname='沙僧', id=100)  # 支持多个同时修改, 联系原生的 sql 语句 理解.
```

> 小结:
>
> `save`方法中使用的是 `get` 过滤, 因为get返回的是单个模型类对象,使用 `filter` 返回的是 **QuerySet** 会报错;  当然可以在 `filter()`方法后面再接`first()` 方法即可.
>
> `update` 方法中使用 `filter`过滤, 返回查询结果集, 所以会返回受影响的行数.
>
> 注:
>
> 第一种方式**进行了两次操作:先查询再修改**,  所以更多的时候 更加推荐 第二种.

> 重要补充:
>
> #### 更新  与  F  (F对象实现数据批量修改)
>
> `BookInfo.objects.all().update(read = F('read') + 1000 )` 将每本书的阅读量增加 1000.
>
> 这里可以使用  `for q in qs: `来实现, 但是 性能太差.

##### 4 删除

删除有两种方法

**1）模型类对象.delete**

```python
hero = HeroInfo.objects.get(id=13)
hero.delete()  # 其实可以直接链式操作.
```

**2）模型类.objects.filter().delete()**

```python
HeroInfo.objects.filter(id=14).delete()
```

> 小结:
>
> 返回的都是:   `(1, {'booktest.HeroInfo': 1})`  影响的行数是1 

##### 5 补充`__str__`方法

> 使得返回的查询集结果更加人性化,  使得admin站点中的查询结果更加人性化

```python
class BookInfo(models.Model):
    ...
    ...
    def __str__(self):
        return self.title
```



#### 5.5 查询集 `QuerySet`

##### 1 概念

Django的ORM中存在查询集的概念。

查询集，也称查询结果集、`QuerySet`，表示从数据库中获取的对象集合。

**当调用如下过滤器方法时，Django会返回查询集（而不是简单的列表）：**

> - all()：返回所有数据。
> - filter()：返回满足条件的数据。
> - exclude()：返回满足条件之外的数据。
> - order_by()：对结果进行排序。

对查询集可以再次调用过滤器进行过滤，如

```python
BookInfo.objects.filter(read__gt=30).order_by('pub_date')
```

也就意味着查询集可以含有零个、一个或多个过滤器。过滤器基于所给的参数限制查询的结果。

**从SQL的角度讲，查询集与select语句等价，过滤器像where、limit、order by子句。**

**判断某一个查询集中是否有数据**：

- exists()：判断查询集中是否有数据，如果有则返回True，没有则返回False。

##### 2 两大特性

###### 1）惰性执行

**创建查询集不会访问数据库，直到调用数据时，才会访问数据库，调用数据的情况包括迭代、序列化、与if合用**

例如，当执行如下语句时，并未进行数据库查询，只是创建了一个查询集qs

```python
qs = BookInfo.objects.all()
```

继续执行遍历迭代操作后，才真正的进行了数据库的查询

```python
for book in qs:
    print(book.title)
```

###### 2）缓存

**使用同一个查询集，第一次使用时会发生数据库的查询，然后Django会把结果缓存下来，再次使用这个查询集时会使用缓存的数据，减少了数据库的查询次数。**

**情况一**：如下是两个查询集，无法重用缓存，每次查询都会与数据库进行一次交互，增加了数据库的负载。

```python
from booktest.models import BookInfo
[book.id for book in BookInfo.objects.all()]
[book.id for book in BookInfo.objects.all()]
```

![两个查询集](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/queryset_uncache.png)

![两次查询](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/queyrset_uncache_result.png)

**情况二**：**经过存储后**，可以重用查询集，第二次使用缓存中的数据。

```python
qs=BookInfo.objects.all()
[book.id for book in qs]
[book.id for book in qs]
```

![一个查询集](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/queryset_cache.png)

![一次查询](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/queryset_cache_result.png)

##### 3 限制查询集

可以对查询集进行取下标或切片操作，等同于sql中的limit和offset子句。

> 注意：不支持负数索引。

**对查询集进行切片后返回一个新的查询集，不会立即执行查询。**

如果获取一个对象，直接使用[0]，等同于[0:1].get()，但是如果没有数据，[0]引发IndexError异常，[0:1].get()如果没有数据引发DoesNotExist异常。

示例：获取第1、2项，运行查看。

```python
qs = BookInfo.objects.all()[0:2]
```



#### 5.6 管理器Manager

管理器是Django的模型进行数据库操作的接口，Django应用的每个模型类都拥有至少一个管理器。

我们在通过模型类的**objects**属性提供的方法操作数据库时，即是在使用一个管理器对象objects。当没有为模型类定义管理器时，Django会为每一个模型类生成一个名为objects的管理器，它是**models.Manager**类的对象。即, `objects = models.Manager()` 

##### 自定义管理器

我们可以自定义管理器，并应用到我们的模型类上。

**注意：一旦为模型类指明自定义的过滤器后，Django不再生成默认管理对象objects。**

自定义管理器类主要用于两种情况：

**1. 修改原始查询集，重写all()方法。**

a）打开booktest/models.py文件，定义类BookInfoManager

```python
#图书管理器
class BookInfoManager(models.Manager):
    def all(self):
        #默认查询未删除的图书信息
        #调用父类的成员语法为：super().方法名
        return super().filter(is_delete=False)
```

b）在模型类BookInfo中定义管理器

```
class BookInfo(models.Model):
    ...
    books = BookInfoManager()

```

c）使用方法

```python
BookInfo.books.all()
```

**2. 在管理器类中补充定义新的方法**

a）打开booktest/models.py文件，定义方法create。

```python
class BookInfoManager(models.Manager):
    #创建模型类，接收参数为属性赋值
    def create_book(self, title, pub_date):
        #创建模型类对象self.model可以获得模型类
        book = self.model()
        book.title = title
        book.pub_date = pub_date
        book.read=0
        book.bcommet=0
        book.is_delete = False
        # 将数据插入进数据表
        book.save()
        return book
```

b）为模型类BookInfo定义管理器books语法如下

```
class BookInfo(models.Model):
      ...
    books = BookInfoManager()

```

c）调用语法如下：

```python
book=BookInfo.books.create_book("abc",date(1980,1,1))
```





------



### 6. 模板使用

#### 1 配置

在工程中创建模板目录templates, 如果是在pycharm中还可以配置模板目录。

在settings.py配置文件中修改**TEMPLATES**配置项的DIRS值：

```python
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],  # 此处修改模板目录
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
```

#### 2 定义模板

在templates目录中新建一个模板文件，如index.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <h1>{{ city }}</h1>
</body>
</html>
```

#### 3 模板渲染

调用模板分为两步：

1. **找到模板** loader.get_template(**模板文件在模板目录中的相对路径**) -> 返回模板对象
2. **渲染模板** 模板对象.render(context=None, request=None) -> 返回渲染后的html文本字符串 context 为模板变量字典，默认值为None request 为请求对象，默认值为None

例如，定义一个视图

```python
from django.http import HttpResponse
from django.template import loader

def index(request):
    # 1.获取模板
    template=loader.get_template('index.html')  # 相对路径
	
    context={'city': '北京'}
    # 2.渲染模板
    return HttpResponse(template.render(context))
---
存疑:  两个版本, 下面是分为三步的:
---
def index(request):
    # 1.获取模板
    template = loader.get_template("booktest/index.html")
    # 2.定义上下文
    context = RequestContext(request, {'city': '北京'})
    # 3.渲染模板
    return HttpResponse(template.render(context))
```

**Django提供了一个函数render可以简写上述代码。**

render(request对象, 模板文件路径, 模板数据字典)

```python
from django.shortcuts import render

def index(request):
    context={'city': '北京'}
    return render(request,'index.html',context)
```

#### 4 模板语法

##### 4.1 模板变量

变量名必须由字母、数字、下划线（不能以下划线开头）和点组成。

语法如下：

```python
{{变量}}
```

模板变量可以使python的内建类型，也可以是对象。

```python
def index(request):
    context = {
        'city': '北京',
        'adict': {
            'name': '西游记',
            'author': '吴承恩'
        },
        'alist': [1, 2, 3, 4, 5]
    }
    return render(request, 'index.html', context)
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <h1>{{ city }}</h1>
    <h1>{{ adict }}</h1>
    <h1>{{ adict.name }}</h1>  注意字典的取值方法
    <h1>{{ alist }}</h1>  
    <h1>{{ alist.0 }}</h1>  注意列表的取值方法
</body>
</html>
```

##### 4.2 模板语句

**1）for循环：**

```python
{% for item in 列表 %}

循环逻辑
{{forloop.counter}}表示当前是第几次循环，从1开始
{%empty%} 列表为空或不存在时执行此逻辑

{% endfor %}
```

**2）if条件：**

```python
{% if ... %}
逻辑1
{% elif ... %}
逻辑2
{% else %}
逻辑3
{% endif %}
```

比较运算符如下：

```
==
!=
<
>
<=
>=

```

布尔运算符如下：

```
and
or
not

```

**注意：运算符左右两侧不能紧挨变量或常量，必须有空格。**

```python
{% if a == 1 %}  # 正确
{% if a==1 %}  # 错误
```

##### 4.3 过滤器

语法如下:

- 使用管道符号|来应用过滤器，用于进行计算、转换操作，可以使用在变量、标签中。

- 如果过滤器需要参数，则使用冒号:传递参数。

  ```python
  变量|过滤器:参数
  ```

列举几个如下：

- **safe**，禁用转义，告诉模板这个变量是安全的，可以解释执行

- **length**，长度，返回字符串包含字符的个数，或列表、元组、字典的元素个数。

- **default**，默认值，如果变量不存在时则返回默认值。

  ```
  data|default:'默认值'
  
  ```

- **date**，日期，用于对日期类型的值进行字符串格式化，常用的格式化字符如下：

  - Y表示年，格式为4位，y表示两位的年。
  - m表示月，格式为01,02,12等。
  - d表示日, 格式为01,02等。
  - j表示日，格式为1,2等。
  - H表示时，24进制，h表示12进制的时。
  - i表示分，为0-59。
  - s表示秒，为0-59。

  ```
  value|date:"Y年m月j日  H时i分s秒"
  
  ```

##### 4.4 注释

1）单行注释语法如下：

```
{#...#}

```

2）多行注释使用comment标签，语法如下：

```python
{% comment %}
...
{% endcomment %}
```

##### 4.5 模板继承

模板继承和类的继承含义是一样的，主要是为了提高代码重用，减轻开发人员的工作量。

**父模板**

如果发现在多个模板中某些内容相同，那就应该把这段内容定义到父模板中。

标签block：用于在父模板中预留区域，留给子模板填充差异性的内容，名字不能相同。 为了更好的可读性，建议给endblock标签写上名字，这个名字与对应的block名字相同。父模板中也可以使用上下文中传递过来的数据。

```python
{% block 名称 %}
预留区域，可以编写默认内容，也可以没有默认内容
{% endblock  名称 %}
```

**子模板**

标签extends：继承，写在子模板文件的第一行。

```
{% extends "父模板路径"%}

```

子模版不用填充父模版中的所有预留区域，如果子模版没有填充，则使用父模版定义的默认值。

填充父模板中指定名称的预留区域。

```
{% block 名称 %}
实际填充内容
{{ block.super }}用于获取父模板中block的内容
{% endblock 名称 %}

```



### 7. 表单 使用

Django提供对表单处理的原生支持，可以简化并自动化大部分的表单处理工作。

#### 7.1 定义表单类

**表单系统的核心部分是Django 的Form类。** Django 的数据库模型描述一个对象的逻辑结构、行为以及展现给我们的方式，与此类似，Form类描述一个表单并决定它如何工作和展现。

> 个人理解: 类似drf框架的序列化器的验证的思路, 可以进行相应的校验.

假如我们想在网页中创建一个表单，用来获取用户想保存的图书信息，可能类似的html 表单如下：

```html
<form action="" method="post">
    <input type="text" name="title">
    <input type="date" name="pub_date">
    <input type="submit">
</form>
```

我们可以据此来创建一个Form类来描述这个表单。

新建一个**forms.py**文件，编写Form类。

```python
from django import forms

class BookForm(forms.Form):  # 继承自 Form 类
    title = forms.CharField(label="书名", required=True, max_length=50)
    pub_date = forms.DateField(label='出版日期', required=True)

# 类比  序列化器
```

注：[表单字段类型参考资料连接](https://yiyibooks.cn/xx/Django_1.11.6/ref/forms/fields.html)

#### 7.2 视图中使用表单类

```python
from django.shortcuts import render
from django.views.generic import View
from django.http import HttpResponse

from .forms import BookForm

class BookView(View):
    def get(self, request):
        form = BookForm()
        return render(request, 'book.html', {'form': form})

    def post(self, request):
        form = BookForm(request.POST)
        if form.is_valid():  # 验证表单数据
            print(form.cleaned_data)  # 获取验证后的表单数据
            return HttpResponse("OK")
        else:  # 如果验证不通过, 那么渲染返回的时候也会有错误信息
            return render(request, 'book.html', {'form': form})
```

- form.is_valid() 验证表单数据的合法性
- form.cleaned_data 验证通过的表单数据

#### 7.3 模板中使用表单类

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>书籍</title>
</head>
<body>
    <form action="" method="post">
        {% csrf_token %}
        {{ form }}  # 直接接收表单实例, 可以自动处理.
        <input type="submit">  // 这一行需要自己补充
    </form>
</body>
</html>

// 浏览器自己也带验证功能, 对于表单的字段也是必须提交.这个时候的验证并未发送POST请求.
```

- csrf_token 用于添加CSRF防护的字段
- form 快速渲染表单字段的方法

> #### 表单优点:
>
> - 1.可以定义表单类, 并进行表单的验证操作.
> - 2.简化语法: 在 模板中 只需要插入 `{ form }` 即可实现表单.

#### 7.4 模型类表单

如果表单中的数据与模型类对应，可以通过继承**forms.ModelForm**更快速的创建表单。

```python
class BookForm(forms.ModelForm):   # 类比: 序列化器
    class Meta:
        model = BookInfo
        fields = ('title', 'pub_date')
```

- model 指明从属于哪个模型类
- fields 指明向表单中添加模型类的哪个字段



### 8. admin 站点

#### 8.1 使用Admin站点

假设我们要设计一个新闻网站，我们需要编写展示给用户的页面，网页上展示的新闻信息是从哪里来的呢？**是从数据库中查找到新闻的信息，然后把它展示在页面上**。但是我们的网站上的新闻每天都要更新，这就意味着对数据库的增、删、改、查操作，那么我们需要每天写sql语句操作数据库吗? 如果这样的话，是不是非常繁琐，所以我们可以设计一个页面，通过对这个页面的操作来实现对新闻数据库的增删改查操作。那么问题来了，老板说我们需要在建立一个新网站，是不是还要设计一个页面来实现对新网站数据库的增删改查操作，但是这样的页面具有一个很大的重复性，那有没有一种方法能够让我们很快的生成管理数据库表的页面呢？**有，那就是我们接下来要给大家讲的Django的后台管理**。Django能够根据定义的模型类自动地生成管理页面。

**使用Django的管理模块，需要按照如下步骤操作：**

1. **管理界面本地化**
2. **创建管理员**
3. **注册模型类**
4. **自定义管理页面**

##### 1 管理界面本地化

在settings.py中设置语言和时区

```python
LANGUAGE_CODE = 'zh-hans' # 使用中国语言
TIME_ZONE = 'Asia/Shanghai' # 使用中国上海时间
```

##### 2 创建超级管理员

创建管理员的命令如下，按提示输入用户名、邮箱、密码。

```shell
python manage.py createsuperuser
```

打开浏览器，在地址栏中输入如下地址后回车。

```html
http://127.0.0.1:8000/admin/
```

输入前面创建的用户名、密码完成登录。

登录成功后界面如下，但是并没有我们自己应用模型的入口，接下来进行第三步操作。

##### 3 注册模型类

登录后台管理后，默认没有我们创建的应用中定义的模型类，需要在自己应用中的admin.py文件中注册，才可以在后台管理中看到，并进行增删改查操作。

打开booktest/admin.py文件，编写如下代码：

```python
from django.contrib import admin
from booktest.models import BookInfo,HeroInfo

admin.site.register(BookInfo)
admin.site.register(HeroInfo)
```

到浏览器中刷新页面，可以看到模型类BookInfo和HeroInfo的管理了。

![注册成功](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/register_success.png)

点击类名称"BookInfo"（图书）可以进入列表页，默认只有一列。

![列表页](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/admin_list.png)

在列表页中点击"增加"可以进入增加页，Django会根据模型类的不同，生成不同的表单控件，按提示填写表单内容后点击"保存"，完成数据创建，创建成功后返回列表页。

![添加页](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/admin_add.png)

在列表页中点击某行的第一列可以进入修改页。

![修改页1](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/admin_update_enter.png)

按照提示进行内容的修改，修改成功后进入列表页。在修改页点击“删除”可以删除一项。

![修改页2](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/admin_update.png)

删除：在列表页勾选想要删除的复选框，可以删除多项。

![删除1](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/admin_delete.png)

点击执行后进入确认页面，删除后回来列表页面。

![删除2](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/admin_delete_check.png)

##### 4 定义与使用Admin管理类

Django提供的Admin站点的展示效果可以通过自定义**ModelAdmin**类来进行控制。

定义管理类需要继承自**admin.ModelAdmin**类，如下

```python
from django.contrib import admin

class BookInfoAdmin(admin.ModelAdmin):
    pass
```

使用管理类有两种方式：

- 注册参数

  ```python
  admin.site.register(BookInfo,BookInfoAdmin)  # admin.site 对象指向了 admin的管理界面
  ```

- 装饰器

  ```python
  @admin.register(BookInfo)
  class BookInfoAdmin(admin.ModelAdmin):
      pass
  ```





#### 8.2 调整列表页展示

##### 1 页大小

每页中显示多少条数据，默认为每页显示100条数据，属性如下：

```python
list_per_page=100
```

1）打开booktest/admin.py文件，修改AreaAdmin类如下：

```python
class BookInfoAdmin(admin.ModelAdmin):
    list_per_page = 2
```

2）在浏览器中查看区域信息的列表页面，效果如下图：

![列表页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/list_option.png)

##### 2 "操作选项"的位置

顶部显示的属性，设置为True在顶部显示，设置为False不在顶部显示，默认为True。

```python
actions_on_top=True
```

底部显示的属性，设置为True在底部显示，设置为False不在底部显示，默认为False。

```python
actions_on_bottom=False
```

1）打开booktest/admin.py文件，修改BookInfoAdmin类如下：

```python
class BookInfoAdmin(admin.ModelAdmin):
    ...
    actions_on_top = True
    actions_on_bottom = True
```

2）在浏览器中刷新效果如下图：

![列表页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/list_option_top.png)

##### 3 列表中的列

属性如下：

```
list_display=[模型字段1,模型字段2,...]

```

1）打开booktest/admin.py文件，修改BookInfoAdmin类如下：

```python
class BookInfoAdmin(admin.ModelAdmin):
    ...
    list_display = ['id','title']
```

2）在浏览器中刷新效果如下图：

![列表页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/list_option_col.png)

**点击列头可以进行升序或降序排列。**

##### 4 将方法作为列

列可以是模型字段，还可以是模型方法，要求方法有返回值。

**通过设置short_description属性，可以设置在admin站点中显示的列名。**

1）打开booktest/models.py文件，修改BookInfo类如下：

```python
class BookInfo(models.Model):
    ...
    def pub_date(self):
        return self.pub_date.strftime('%Y年%m月%d日')

    pub_date.short_description = '发布日期'  # 设置方法字段在admin中显示的标题
```

2）打开booktest/admin.py文件，修改BookInfoAdmin类如下：

```python
class BookInfoAdmin(admin.ModelAdmin):
    ...
    list_display = ['id','atitle','pub_date']
```

3）在浏览器中刷新效果如下图：

![列表页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/list_option_method_col.png)

方法列是不能排序的，如果需要排序需要为方法指定排序依据。

```
admin_order_field=模型类字段

```

1）打开booktest/models.py文件，修改BookInfo类如下：

```python
class BookInfo(models.Model):
    ...
    def pub_date(self):
        return self.pub_date.strftime('%Y年%m月%d日')

    pub_date.short_description = '发布日期'
    pub_date.admin_order_field = 'pub_date'
```

2）在浏览器中刷新效果如下图：

![列表页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/admin_order_filed.png)

##### 5 关联对象

无法直接访问关联对象的属性或方法，可以在模型类中封装方法，访问关联对象的成员。

1）打开booktest/models.py文件，修改HeroInfo类如下：

```python
class HeroInfo(models.Model):
    ...
    def read(self):
        return self.hbook.read

    read.short_description = '图书阅读量'
```

2）打开booktest/admin.py文件，修改HeroInfoAdmin类如下：

```python
class HeroInfoAdmin(admin.ModelAdmin):
    ...
    list_display = ['id', 'hname', 'hbook', 'read']
```

3）在浏览器中刷新效果如下图：

![列表页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/list_relate_obj.png)

##### 6 右侧栏过滤器

属性如下，只能接收字段，会将对应字段的值列出来，用于快速过滤。一般用于有重复值的字段。

```
list_filter=[]

```

1）打开booktest/admin.py文件，修改HeroInfoAdmin类如下：

```python
class HeroInfoAdmin(admin.ModelAdmin):
    ...
    list_filter = ['hbook', 'hgender']
```

2）在浏览器中刷新效果如下图：

![列表页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/admin_filter.png)

##### 7 搜索框

属性如下，用于对指定字段的值进行搜索，支持模糊查询。列表类型，表示在这些字段上进行搜索。

```
search_fields=[]

```

1）打开booktest/admin.py文件，修改HeroInfoAdmin类如下：

```python
class HeroInfoAdmin(admin.ModelAdmin):
    ...
    search_fields = ['hname']
```

2）在浏览器中刷新效果如下图：

![列表页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/list_search.png)



#### 8.3 调整编辑页展示

##### 1. 显示字段

属性如下：

```
fields=[]

```

1）点击某行ID的链接，可以转到修改页面，默认效果如下图：

![编辑页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/edit_default.png)

2）打开booktest/admin.py文件，修改BookInfoAdmin类如下：

```python
class BookInfoAdmin(admin.ModelAdmin):
    ...
    fields = ['title', 'pub_date']
```

3）刷新浏览器效果如下图：

![编辑页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/edit_result.png)

##### 2. 分组显示

属性如下：

```
fieldset=(
    ('组1标题',{'fields':('字段1','字段2')}),
    ('组2标题',{'fields':('字段3','字段4')}),
)

```

1）打开booktest/admin.py文件，修改BookInfoAdmin类如下：

```python
class BookInfoAdmin(admin.ModelAdmin):
    ...
    # fields = ['title', 'pub_date']
    fieldsets = (
        ('基本', {'fields': ['title', 'pub_date']}),
        ('高级', {
            'fields': ['read', 'comment'],
            'classes': ('collapse',)  # 是否折叠显示
        })
    )
```

2）刷新浏览器效果如下图：

![编辑页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/display_group.png)

> 说明：fields与fieldsets两者选一使用。

##### 3. 关联对象

在一对多的关系中，可以在一端的编辑页面中编辑多端的对象，嵌入多端对象的方式包括表格、块两种。

- 类型InlineModelAdmin：表示在模型的编辑页面嵌入关联模型的编辑。
- 子类TabularInline：以表格的形式嵌入。
- 子类StackedInline：以块的形式嵌入。

1）打开booktest/admin.py文件，创建HeroInfoStackInline类。

```python
class HeroInfoStackInline(admin.StackedInline):
    model = HeroInfo  # 要编辑的对象
    extra = 1  # 附加编辑的数量
```

2）打开booktest/admin.py文件，修改BookInfoAdmin类如下：

```python
class BookInfoAdmin(admin.ModelAdmin):
    ...
    inlines = [HeroInfoStackInline]
```

3）刷新浏览器效果如下图：

![编辑页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/relate_obj.png)

可以用表格的形式嵌入。

1）打开booktest/admin.py文件，创建HeroInfoTabularInline类。

```python
class HeroInfoTabularInline(admin.TabularInline):
    model = HeroInfo
    extra = 1
```

2）打开booktest/admin.py文件，修改BookInfoAdmin类如下：

```python
class BookInfoAdmin(admin.ModelAdmin):
    ...
    inlines = [HeroInfoTabularInline]
```

3）刷新浏览器效果如下图：

![编辑页选项](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/relate_table.png)



#### 8.4 调整站点信息

Admin站点的名称信息也是可以自定义的。

未调整前如下图：

![原始admin站点](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/origin_site.png)

- **admin.site.site_header** 设置网站页头
- **admin.site.site_title** 设置页面标题
- **admin.site.index_title** 设置首页标语

在booktest/admin.py文件中添加一下信息

```python
from django.contrib import admin

admin.site.site_header = '传智书城'
admin.site.site_title = '传智书城MIS'
admin.site.index_title = '欢迎使用传智书城MIS'
```

刷新网站，效果如下

![调整后的admin站点](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/modified_admin_site.png)



#### 8.5 上传图片

Django有提供文件系统支持，在Admin站点中可以轻松上传图片。

使用Admin站点保存图片，需要安装Python的图片操作包

```python
pip install Pillow
```

##### 1 配置

默认情况下，Django会将上传的图片保存在本地服务器上，需要配置保存的路径。

我们可以将上传的文件保存在静态文件目录中，如我们之前设置的static_files目录中在settings.py 文件中添加如下上传保存目录信息

```python
MEDIA_ROOT=os.path.join(BASE_DIR,"static_files/media")
```

##### 2 为模型类添加ImageField字段

我们为之前的BookInfo模型类添加一个ImageFiled

```python
class BookInfo(models.Model):
    ...
    image = models.ImageField(upload_to='booktest', verbose_name='图片', null=True)
```

- upload_to 选项指明该字段的图片保存在MEDIA_ROOT目录中的哪个子目录

进行数据库迁移操作

```python
python manage.py makemigrations
python manage.py migrate
```

##### 3 使用Admin站点上传图片

进入Admin站点的图书管理页面，选择一个图书，能发现多出来一个上传图片的字段

![admin站点图片字段](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/admin_image.png)

选择一张图片并保存后，图片会被保存在**static_files/media/booktest/**目录下。

在数据库中，我们能看到image字段被设置为图片的路径

![图片字段](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/image_field_data.png)



------



## 七 Django REST framework

### 一、引入Django REST framework

#### 1.1. web应用模式

在开发Web应用中，有两种应用模式：

- 前后端不分离
- 前后端分离

##### 1 前后端不分离

![前后端不分离](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/depended_frontend_backend.png)

在前后端不分离的应用模式中，前端页面看到的效果都是由后端控制，由后端渲染页面或重定向，也就是后端需要控制前端的展示，前端与后端的耦合度很高。

这种应用模式比较适合纯网页应用，但是当后端对接App时，App可能并不需要后端返回一个HTML网页，而仅仅是数据本身，所以后端原本返回网页的接口不再适用于前端App应用，为了对接App后端还需再开发一套接口。

##### 2 前后端分离

![前后端分离](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/indepent_frontend_backend.png)

在前后端分离的应用模式中，后端仅返回前端所需的数据，不再渲染HTML页面，不再控制前端的效果。至于前端用户看到什么效果，从后端请求的数据如何加载到前端中，都由前端自己决定，网页有网页的处理方式，App有App的处理方式，但无论哪种前端，所需的数据基本相同，后端仅需开发一套逻辑对外提供数据即可。

在前后端分离的应用模式中 ，前端与后端的耦合度相对较低。

在前后端分离的应用模式中，我们通常将后端开发的每个视图都称为一个**接口**，或者**API**，前端通过访问接口来对数据进行增删改查。

#### 1.2. 认识RESTful

**在前后端分离的应用模式里，后端API接口如何定义？**

例如对于后端数据库中保存了商品的信息，前端可能需要对商品数据进行增删改查，那相应的每个操作后端都需要提供一个API接口：

1. POST /add-goods 增加商品
2. POST /delete-goods 删除商品
3. POST /update-goods 修改商品
4. GET /get-goods 查询商品信息

对于接口的请求方式与路径，每个后端开发人员可能都有自己的定义方式，风格迥异。

是否存在一种统一的定义方式，被广大开发人员接受认可的方式呢？

这就是被普遍采用的API的RESTful设计风格。

##### 1. 起源

REST这个词，是[Roy Thomas Fielding](http://en.wikipedia.org/wiki/Roy_Fielding)在他2000年的[博士论文](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm)中提出的。

![REST作者](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/REST%E4%BD%9C%E8%80%85.jpg)

Fielding是一个非常重要的人，他是HTTP协议（1.0版和1.1版）的主要设计者、Apache服务器软件的作者之一、Apache基金会的第一任主席。所以，他的这篇论文一经发表，就引起了关注，并且立即对互联网开发产生了深远的影响。

##### 2. 名称

Fielding将他对互联网软件的架构原则，定名为**REST**，即**Representational State Transfer**的缩写。维基百科称其为“**具象状态传输**”，国内大部分人理解为“**表现层状态转化**”。

**RESTful是一种开发理念**。维基百科说：**REST是设计风格而不是标准**。 REST描述的是在网络中client和server的一种交互形式；REST本身不实用，实用的是如何设计 RESTful API（REST风格的网络接口）,一种万维网软件架构风格。

我们先来具体看下RESTful风格的url,比如我要查询商品信息，那么

> 非REST的url：**http://.../queryGoods?id=1001&type=t01**
>
> REST的url: **http://.../t01/goods/1001**

可以看出**REST特点：url简洁，将参数通过url传到服务器，**而传统的url比较啰嗦，而且现实中浏览器地址栏会拼接一大串字符，想必你们都见过吧。但是采用REST的风格就会好很多，现在很多的网站已经采用这种风格了，这也是潮流方向，典型的就是url的短化转换。

**那么，到底什么是RESTFul架构： 如果一个架构符合REST原则，就称它为RESTful架构。**

要理解RESTful架构，理解Representational State Transfer这三个单词的意思。

- **具象的**，就是指表现层，要表现的对象也就是“资源”，什么是资源呢？网站就是资源共享的东西，客户端（浏览器）访问web服务器，所获取的就叫资源。比如html，txt，json，图片，视频等等。

- **表现**，比如，文本可以用txt格式表现，也可以用HTML格式、XML格式、JSON格式表现，甚至可以采用二进制格式；图片可以用JPG格式表现，也可以用PNG格式表现。

  浏览器通过URL确定一个资源，但是如何确定它的具体表现形式呢？应该在HTTP请求的头信息中用Accept和Content-Type字段指定，这两个字段才是对"表现层"的描述。

- **状态转换，** 就是客户端和服务器互动的一个过程，在这个过程中, 势必涉及到数据和状态的变化, 这种变化叫做状态转换。

  互联网通信协议HTTP协议，客户端访问必然使用HTTP协议**，如果客户端想要操作服务器，必须通过某种手段，让服务器端发生"状态转化"（State Transfer）。**

  HTTP协议实际上含有4个表示操作方式的动词，分别是 GET,POST,PUT,DELETE,他们分别对应四种操作。GET用于获取资源，POST用于新建资源，PUT用于更新资源，DElETE用于删除资源。GET和POST是表单提交的两种基本方式，比较常见，而PUT和DElETE不太常用。

  而且HTTP协议是一种无状态协议，这样就必须把所有的状态都保存在服务器端**。**因此，如果客户端想要操作服务器，必须通过某种手段，让服务器端发生"状态转化"（State Transfer）

##### 3. 总结

**综合上面的解释，RESTful架构就是：**

- **每一个URL代表一种资源；**
- **客户端和服务器之间，传递这种资源的某种表现层；**
- **客户端通过四个HTTP动词，对服务器端资源进行操作，实现"表现层状态转化"。**

#### 1.3. RESTful设计方法

##### 1. 域名

应该尽量将API部署在专用域名之下。

```http
https://api.example.com
```

如果确定API很简单，不会有进一步扩展，可以考虑放在主域名下。

```http
https://example.org/api/
```

##### 2. 版本（Versioning）

应该将API的版本号放入URL。

```http
http://www.example.com/app/1.0/foo

http://www.example.com/app/1.1/foo

http://www.example.com/app/2.0/foo
```

另一种做法是，将版本号放在HTTP头信息中，但不如放入URL方便和直观。[Github](https://developer.github.com/v3/media/#request-specific-version)采用这种做法。

因为不同的版本，可以理解成同一种资源的不同表现形式，所以应该采用同一个URL。版本号可以在HTTP请求头信息的Accept字段中进行区分（参见[Versioning REST Services](http://www.informit.com/articles/article.aspx?p=1566460)）：

```http
Accept: vnd.example-com.foo+json; version=1.0

Accept: vnd.example-com.foo+json; version=1.1

Accept: vnd.example-com.foo+json; version=2.0
```

##### 3. 路径（Endpoint）

路径又称"终点"（endpoint），表示API的具体网址，每个网址代表一种资源（resource）

**(1) 资源作为网址，只能有名词，不能有动词，而且所用的名词往往与数据库的表名对应。**

举例来说，以下是不好的例子:

```http
/getProducts
/listOrders
/retreiveClientByOrder?orderId=1
```

对于一个简洁结构，你应该始终用名词。 此外，利用的HTTP方法可以分离网址中的资源名称的操作。

```http
GET /products ：将返回所有产品清单
POST /products ：将产品新建到集合
GET /products/4 ：将获取产品 4
PATCH（或）PUT /products/4 ：将更新产品 4
```

**(2) API中的名词应该使用复数。无论子资源或者所有资源。**

举例来说，获取产品的API可以这样定义

```http
获取单个产品：http://127.0.0.1:8080/AppName/rest/products/1
获取所有产品: http://127.0.0.1:8080/AppName/rest/products
```

##### 3. HTTP动词

对于资源的具体操作类型，由HTTP动词表示。

常用的HTTP动词有下面四个（括号里是对应的SQL命令）。

- GET（SELECT）：从服务器取出资源（一项或多项）。
- POST（CREATE）：在服务器新建一个资源。
- PUT（UPDATE）：在服务器更新资源（客户端提供改变后的完整资源）。
- DELETE（DELETE）：从服务器删除资源。

还有三个不常用的HTTP动词。

- PATCH（UPDATE）：在服务器更新(更新)资源（客户端提供改变的属性）。
- HEAD：获取资源的元数据。
- OPTIONS：获取信息，关于资源的哪些属性是客户端可以改变的。

下面是一些例子。

```http
GET /zoos：列出所有动物园
POST /zoos：新建一个动物园（上传文件）
GET /zoos/ID：获取某个指定动物园的信息
PUT /zoos/ID：更新某个指定动物园的信息（提供该动物园的全部信息）
PATCH /zoos/ID：更新某个指定动物园的信息（提供该动物园的部分信息）
DELETE /zoos/ID：删除某个动物园
GET /zoos/ID/animals：列出某个指定动物园的所有动物
DELETE /zoos/ID/animals/ID：删除某个指定动物园的指定动物
```

##### 4. 过滤信息（Filtering）

如果记录数量很多，服务器不可能都将它们返回给用户。API应该提供参数，过滤返回结果。

下面是一些常见的参数。

```http
?limit=10：指定返回记录的数量
?offset=10：指定返回记录的开始位置。
?page=2&per_page=100：指定第几页，以及每页的记录数。
?sortby=name&order=asc：指定返回结果按照哪个属性排序，以及排序顺序。
?animal_type_id=1：指定筛选条件
```

参数的设计允许存在冗余，即允许API路径和URL参数偶尔有重复。比如，GET /zoos/ID/animals 与 GET /animals?zoo_id=ID 的含义是相同的。

##### 6. 状态码（Status Codes）

服务器向用户返回的状态码和提示信息，常见的有以下一些（方括号中是该状态码对应的HTTP动词）。

> - 200 OK - [GET]：服务器成功返回用户请求的数据
> - 201 CREATED - [POST/PUT/PATCH]：用户新建或修改数据成功。
> - 202 Accepted - [*]：表示一个请求已经进入后台排队（异步任务）
> - 204 NO CONTENT - [DELETE]：用户删除数据成功。
> - 400 INVALID REQUEST - [POST/PUT/PATCH]：用户发出的请求有错误，服务器没有进行新建或修改数据的操作
> - 401 Unauthorized - [*]：表示用户没有权限（令牌、用户名、密码错误）。
> - 403 Forbidden - [*] 表示用户得到授权（与401错误相对），但是访问是被禁止的。
> - 404 NOT FOUND - [*]：用户发出的请求针对的是不存在的记录，服务器没有进行操作，该操作是幂等的。
> - 406 Not Acceptable - [GET]：用户请求的格式不可得（比如用户请求JSON格式，但是只有XML格式）。
> - 410 Gone -[GET]：用户请求的资源被永久删除，且不会再得到的。
> - 422 Unprocesable entity - [POST/PUT/PATCH] 当创建一个对象时，发生一个验证错误。
> - 500 INTERNAL SERVER ERROR - [*]：服务器发生错误，用户将无法判断发出的请求是否成功。

状态码的完全列表参见[这里](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)或[这里](https://zh.wikipedia.org/wiki/HTTP%E7%8A%B6%E6%80%81%E7%A0%81)。

##### 7. 错误处理（Error handling）

如果状态码是4xx，服务器就应该向用户返回出错信息。一般来说，返回的信息中将error作为键名，出错信息作为键值即可。

```json
{
    error: "Invalid API key"
}
```

##### 8. 返回结果

针对不同操作，服务器向用户返回的结果应该符合以下规范。

- GET /collection：返回资源对象的列表（数组）
- GET /collection/resource：返回单个资源对象
- POST /collection：返回新生成的资源对象
- PUT /collection/resource：返回完整的资源对象
- PATCH /collection/resource：返回完整的资源对象
- DELETE /collection/resource：返回一个空文档

##### 9. 超媒体（Hypermedia API）

RESTful API最好做到Hypermedia（即返回结果中提供链接，连向其他API方法），使得用户不查文档，也知道下一步应该做什么。

比如，Github的API就是这种设计，访问[api.github.com](https://api.github.com/)会得到一个所有可用API的网址列表。

```json
{
"current_user_url": "https://api.github.com/user",
"authorizations_url": "https://api.github.com/authorizations",
// ...
}
```

从上面可以看到，如果想获取当前用户的信息，应该去访问[api.github.com/user](https://api.github.com/user)，然后就得到了下面结果。

```json
{
  "message": "Requires authentication",
  "documentation_url": "https://developer.github.com/v3"
}
```

上面代码表示，服务器给出了提示信息，以及文档的网址。

##### 10. 其他

服务器返回的数据格式，应该尽量使用JSON，避免使用XML。



#### 1.4. 使用Django开发REST接口

我们以在Django框架中使用的图书英雄案例来写一套支持图书数据增删改查的REST API接口，来理解REST API的开发。

在此案例中，前后端均发送**JSON格式**数据。

> 总结: 
>
> - 1. json格式数据:  body中获取
>   2. 

```python
# views.py

from datetime import datetime

class BooksAPIVIew(View):
    """
    查询所有图书、增加图书
    """
    def get(self, request):
        """
        查询所有图书
        路由：GET /books/
        """
        books = BookInfo.objects.all()
        book_list = []
        for book in books:
            book_list.append({
                'id': book.id,
                'title': book.title,
                'pub_date': book.pub_date.strftime("%Y-%m-%d"),
                'read': book.read,
                'comment': book.comment,
                'image': book.image.url if book.image else ''
            })
        return JsonResponse(book_list, safe=False)
    # 返回的数据如果是 数组 类型, 也属于json格式. 但是在django中如果不是 k:V 的形式则认为是不安全的 json 格式数据. 所以需要  safe=False 关闭.

    def post(self, request):
        """
        新增图书
        路由：POST /books/ 
        """
        json_bytes = request.body
        json_str = json_bytes.decode()
        book_dict = json.loads(json_str)

        # 此处详细的校验参数省略

        book = BookInfo.objects.create(  # 两种创建方式
            title=book_dict.get('title'),
            pub_date=datetime.strptime(book_dict.get('pub_date'), '%Y-%m-%d').date()  # 把前端传递过来的字符串转换成date()类型. 因为date没有strptime方法, 所以需要借助datetime
        )
        
        # 转换: 将query对象序列化成字典(json)才能返回给前端.
        book_dict = {
            'id': book.id,
            'title': book.title,
            'pub_date': book.pub_date,
            'read': book.read,
            'comment': book.comment,
            'image': book.image.url if book.image else ''
        }

        return JsonResponse(book_dict, status=201)  # 状态码是201


class BookAPIView(View):
    def get(self, request, pk):
        """
        获取单个图书信息
        路由： GET  /books/<pk>/
        """
        try:
            book = BookInfo.objects.get(pk=pk)
        except BookInfo.DoesNotExist:
            return HttpResponse(status=404)

        return JsonResponse({
            'id': book.id,
            'title': book.title,
            'pub_date': book.pub_date,
            'read': book.read,
            'comment': book.comment,
            'image': book.image.url if book.image else ''
        })

    def put(self, request, pk):
        """
        修改图书信息
        路由： PUT  /books/<pk>
        """
        try:
            book = BookInfo.objects.get(pk=pk)
        except BookInfo.DoesNotExist:
            return HttpResponse(status=404)

        json_bytes = request.body
        json_str = json_bytes.decode()
        book_dict = json.loads(json_str)

        # 此处详细的校验参数省略

        book.title = book_dict.get('title')
        book.pub_date = datetime.strptime(book_dict.get('pub_date'), '%Y-%m-%d').date()
        book.save()

        return JsonResponse({
            'id': book.id,
            'title': book.title,
            'pub_date': book.pub_date,
            'read': book.read,
            'comment': book.comment,
            'image': book.image.url if book.image else ''
        })

    def delete(self, request, pk):
        """
        删除图书
        路由： DELETE /books/<pk>/
        """
        try:
            book = BookInfo.objects.get(pk=pk)
        except BookInfo.DoesNotExist:
            return HttpResponse(status=404)

        book.delete()

        return HttpResponse(status=204)
# urls.py

urlpatterns = [
    url(r'^books/$', views.BooksAPIVIew.as_view()),
    url(r'^books/(?P<pk>\d+)/$', views.BookAPIView.as_view())
]
```

#### 测试

使用Postman测试上述接口

1） 获取所有图书数据

GET 方式访问 <http://127.0.0.1:8000/books/，> 返回状态码200，数据如下

```json
[
    {
        "id": 1,
        "title": "射雕英雄传",
        "pub_date": "1980-05-01",
        "read": 12,
        "comment": 34,
        "image": ""
    },
    {
        "id": 2,
        "title": "天龙八部",
        "pub_date": "1986-07-24",
        "read": 36,
        "comment": 40,
        "image": ""
    },
    {
        "id": 3,
        "title": "笑傲江湖",
        "pub_date": "1995-12-24",
        "read": 20,
        "comment": 80,
        "image": ""
    },
    {
        "id": 4,
        "title": "雪山飞狐",
        "pub_date": "1987-11-11",
        "read": 58,
        "comment": 24,
        "image": ""
    },
    {
        "id": 5,
        "title": "西游记",
        "pub_date": "1988-01-01",
        "read": 10,
        "comment": 10,
        "image": "booktest/xiyouji.png"
    },
    {
        "id": 6,
        "title": "水浒传",
        "pub_date": "1992-01-01",
        "read": 10,
        "comment": 11,
        "image": ""
    },
    {
        "id": 7,
        "title": "红楼梦",
        "pub_date": "1990-01-01",
        "read": 0,
        "comment": 0,
        "image": ""
    }
]
```

2）获取单一图书数据

GET 访问 <http://127.0.0.1:8000/books/5/> ，返回状态码200， 数据如下

```json
{
    "id": 5,
    "title": "西游记",
    "pub_date": "1988-01-01",
    "read": 10,
    "comment": 10,
    "image": "booktest/xiyouji.png"
}
```

GET 访问<http://127.0.0.1:8000/books/100/，返回状态码404>

3）新增图书数据

POST 访问<http://127.0.0.1:8000/books/，发送JSON数据：>

```json
{
    "title": "三国演义",
    "pub_date": "1990-02-03"
}
```

返回状态码201，数据如下

```json
{
    "id": 8,
    "title": "三国演义",
    "pub_date": "1990-02-03",
    "read": 0,
    "comment": 0,
    "image": ""
}
```

4）修改图书数据

PUT 访问<http://127.0.0.1:8000/books/8/，发送JSON数据：>

```json
{
    "title": "三国演义（第二版）",
    "pub_date": "1990-02-03"
}
```

返回状态码200，数据如下

```json
{
    "id": 8,
    "title": "三国演义（第二版）",
    "pub_date": "1990-02-03",
    "read": 0,
    "comment": 0,
    "image": ""
}
```

5）删除图书数据

DELETE 访问<http://127.0.0.1:8000/books/8/，返回204状态码>

> **总结**:
>
> **<u>这一节很重要, 从原理上阐述了 django 框架如何进行 REST 风格的接口开发, 这里深刻的理解 4步 过程, 对后面的drf框架是很有帮助的.</u>**



#### 1.5. 明确REST接口开发的核心

分析一下上节的案例，可以发现，在开发REST API接口时，视图中做的最主要有三件事：

- 将请求的数据（如JSON格式）转换为模型类对象
- 操作数据库
- 将模型类对象转换为响应的数据（如JSON格式）

##### 序列化Serialization

[维基百科](https://zh.wikipedia.org/wiki/%E5%BA%8F%E5%88%97%E5%8C%96)中对于序列化的定义：

**序列化**（serialization）在计算机科学的资料处理中，是指将数据结构或物件状态转换成可取用格式（例如存成档案，存于缓冲，或经由网络中传送），以留待后续在相同或另一台计算机环境中，能恢复原先状态的过程。依照序列化格式重新获取字节的结果时，可以利用它来产生与原始物件相同语义的副本。对于许多物件，像是使用大量参照的复杂物件，这种序列化重建的过程并不容易。面向对象中的物件序列化，并不概括之前原始物件所关联的函式。这种过程也称为物件编组（marshalling）。从一系列字节提取数据结构的反向操作，是反序列化（也称为解编组, deserialization, unmarshalling）。

**序列化**在计算机科学中通常有以下定义:

 在数据储存与传送的部分是指将一个[对象](https://zh.wikipedia.org/wiki/%E5%AF%B9%E8%B1%A1_(%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A7%91%E5%AD%A6))存储至一个[储存媒介](https://zh.wikipedia.org/w/index.php?title=%E5%84%B2%E5%AD%98%E5%AA%92%E4%BB%8B&action=edit&redlink=1)，例如[档案](https://zh.wikipedia.org/wiki/%E6%AA%94%E6%A1%88)或是[记亿体缓冲](https://zh.wikipedia.org/w/index.php?title=%E8%A8%98%E5%84%84%E9%AB%94%E7%B7%A9%E8%A1%9D&action=edit&redlink=1)等，或者透过网络传送资料时进行编码的过程，可以是[字节](https://zh.wikipedia.org/wiki/%E5%AD%97%E8%8A%82)或是[XML](https://zh.wikipedia.org/wiki/XML)等格式。而[字节](https://zh.wikipedia.org/wiki/%E5%AD%97%E8%8A%82)的或[XML](https://zh.wikipedia.org/wiki/XML)编码格式可以还原完全相等的[对象](https://zh.wikipedia.org/wiki/%E5%AF%B9%E8%B1%A1_(%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A7%91%E5%AD%A6))。这程序被应用在不同[应用程序](https://zh.wikipedia.org/wiki/%E6%87%89%E7%94%A8%E7%A8%8B%E5%BC%8F)之间传送[对象](https://zh.wikipedia.org/wiki/%E5%AF%B9%E8%B1%A1_(%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A7%91%E5%AD%A6))，以及服务器将[对象](https://zh.wikipedia.org/wiki/%E5%AF%B9%E8%B1%A1_(%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A7%91%E5%AD%A6))储存到[档案](https://zh.wikipedia.org/wiki/%E6%AA%94%E6%A1%88)或[数据库](https://zh.wikipedia.org/wiki/%E8%B3%87%E6%96%99%E5%BA%AB)。相反的过程又称为[**反序列化**](https://zh.wikipedia.org/w/index.php?title=%E5%8F%8D%E5%BA%8F%E5%88%97%E5%8C%96&action=edit&redlink=1)。

简而言之，我们可以将**序列化**理解为：

**将程序中的一个数据结构类型转换为其他格式（字典、JSON、XML等），例如将Django中的模型类对象装换为JSON字符串，这个转换过程我们称为序列化。**

如：

```python
queryset = BookInfo.objects.all()
book_list = []
# 序列化
for book in queryset:
    book_list.append({
        'id': book.id,
        'title': book.title,
        'pub_date': book.pub_date,
        'read': book.read,
        'comment': book.comment,
        'image': book.image.url if book.image else ''
    })
return JsonResponse(book_list, safe=False)
```

**反之，将其他格式（字典、JSON、XML等）转换为程序中的数据，例如将JSON字符串转换为Django中的模型类对象，这个过程我们称为反序列化。**

如：

```python
json_bytes = request.body
json_str = json_bytes.decode()

# 反序列化
book_dict = json.loads(json_str)
book = BookInfo.objects.create(
    title=book_dict.get('title'),
    pub_date=datetime.strptime(book_dict.get('pub_date'), '%Y-%m-%d').date()
)
```

我们可以看到，**在开发REST API时，视图中要频繁的进行序列化与反序列化的编写。**

##### 总结

在开发REST API接口时，我们在**视图**中需要做的最核心的事是：

- **将数据库数据序列化为前端所需要的格式，并返回；**
- **将前端发送的数据反序列化为模型类对象，并保存到数据库中。**



#### 1.6. DjangoRESTframework简介

1. 在序列化与反序列化时，虽然操作的数据不尽相同，但是执行的过程却是相似的，也就是说这部分代码是可以复用简化编写的。
2. 在开发REST API的视图中，虽然每个视图具体操作的数据不同，但增、删、改、查的实现流程基本套路化，所以这部分代码也是可以复用简化编写的：
   - **增**：校验请求数据 -> 执行反序列化过程 -> 保存数据库 -> 将保存的对象序列化并返回
   - **删**：判断要删除的数据是否存在 -> 执行数据库删除
   - **改**：判断要修改的数据是否存在 -> 校验请求的数据 -> 执行反序列化过程 -> 保存数据库 -> 将保存的对象序列化并返回
   - **查**：查询数据库 -> 将数据序列化并返回

**Django REST framework可以帮助我们简化上述两部分的代码编写，大大提高REST API的开发速度。**

##### 认识Django REST framework

![drf_logo](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/drf_logo.png)

Django REST framework 框架是一个用于构建Web API 的强大而又灵活的工具。

通常简称为DRF框架 或 REST framework。

DRF框架是建立在Django框架基础之上，由Tom Christie大牛二次开发的开源项目。

##### 特点

- 提供了定义序列化器Serializer的方法，可以快速根据 Django ORM 或者其它库自动序列化/反序列化；
- 提供了丰富的类视图、Mixin扩展类，简化视图的编写；
- 丰富的定制层级：函数视图、类视图、视图集合到自动生成 API，满足各种需要；
- 多种身份认证和权限认证方式的支持；
- 内置了限流系统；
- 直观的 API web 界面；
- 可扩展性，插件丰富

资料：

- [官方文档](http://www.django-rest-framework.org/)
- [Github源码](https://github.com/encode/django-rest-framework/tree/master)











### 二、DRF工程搭建

#### 2.1. 环境安装与配置

DRF需要以下依赖：

- Python (2.7, 3.2, 3.3, 3.4, 3.5, 3.6)
- Django (1.10, 1.11, 2.0)

**DRF是以Django扩展应用的方式提供的，所以我们可以直接利用已有的Django环境而无需从新创建。（若没有Django环境，需要先创建环境安装Django）**

##### 1. 安装DRF

```shell
pip install djangorestframework
```

##### 2. 添加rest_framework应用

我们利用在Django框架学习中创建的demo工程，在**settings.py**的**INSTALLED_APPS**中添加'rest_framework'。

```python
INSTALLED_APPS = [
    ...
    'rest_framework',
]
```

接下来就可以使用DRF进行开发了。



#### 2.2. DRF魅力

我们仍以在学习Django框架时使用的图书英雄为案例，使用Django REST framework快速实现图书的REST API。

##### 1. 创建序列化器

在booktest应用中新建serializers.py用于保存该应用的序列化器。

创建一个BookInfoSerializer用于序列化与反序列化。

```python
class BookInfoSerializer(serializers.ModelSerializer):
    """图书数据序列化器"""
    class Meta:
        model = BookInfo
        fields = '__all__'
```

- **model** 指明该序列化器处理的数据字段从模型类BookInfo参考生成
- **fields** 指明该序列化器包含模型类中的哪些字段，'__all__'指明包含所有字段

##### 2. 编写视图

在booktest应用的views.py中创建视图BookInfoViewSet，这是一个视图集合。

```python
from rest_framework.viewsets import ModelViewSet
from .serializers import BookInfoSerializer
from .models import BookInfo

class BookInfoViewSet(ModelViewSet):
    queryset = BookInfo.objects.all()
    serializer_class = BookInfoSerializer
```

- **queryset** 指明该视图集在查询数据时使用的查询集
- **serializer_class** 指明该视图在进行序列化或反序列化时使用的序列化器

###### 3. 定义路由

在booktest应用的urls.py中定义路由信息。

```python
from . import views
from rest_framework.routers import DefaultRouter

urlpatterns = [
    ...
]

router = DefaultRouter()  # 可以处理视图的路由器
router.register(r'books', views.BookInfoViewSet)  # 向路由器中注册视图集

urlpatterns += router.urls  # 将路由器中的所以路由信息追到到django的路由列表中
```

###### 4. 运行测试

运行当前程序（与运行Django一样）

```shell
python manage.py runserver
```

在浏览器中输入网址127.0.0.1:8000，可以看到DRF提供的API Web浏览页面：

![图书接口Web浏览页面](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E5%9B%BE%E4%B9%A6%E6%8E%A5%E5%8F%A3Web%E6%B5%8F%E8%A7%88%E9%A1%B5%E9%9D%A2.png)

1）点击链接127.0.0.1:8000/books/ 可以访问**获取所有数据的接口**，呈现如下页面：

![查询所有图书信息1](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E6%9F%A5%E8%AF%A2%E6%89%80%E6%9C%89%E5%9B%BE%E4%B9%A6%E4%BF%A1%E6%81%AF1.png)

![查询所有图书信息2](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E6%9F%A5%E8%AF%A2%E6%89%80%E6%9C%89%E5%9B%BE%E4%B9%A6%E9%A1%B5%E9%9D%A22.png)

2）在页面底下表单部分填写图书信息，可以访问**添加新图书的接口**，保存新书：

![保存新图书](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E4%BF%9D%E5%AD%98%E6%96%B0%E5%9B%BE%E4%B9%A6%E4%BF%A1%E6%81%AF.png)

点击POST后，返回如下页面信息：

![保存图书返回信息](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E4%BF%9D%E5%AD%98%E5%9B%BE%E4%B9%A6%E8%BF%94%E5%9B%9E%E4%BF%A1%E6%81%AF.png)

3）在浏览器中输入网址127.0.0.1:8000/books/1/，可以访问**获取单一图书信息的接口**（id为1的图书），呈现如下页面：

![获取单一图书信息](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E8%8E%B7%E5%8F%96%E5%8D%95%E4%B8%80%E5%9B%BE%E4%B9%A6%E4%BF%A1%E6%81%AF.png)

4）在页面底部表单中填写图书信息，可以访问**修改图书的接口**：

![修改图书信息](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E4%BF%AE%E6%94%B9%E5%9B%BE%E4%B9%A6%E4%BF%A1%E6%81%AF.png)

点击PUT，返回如下页面信息：

![修改图书返回信息](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E4%BF%AE%E6%94%B9%E5%9B%BE%E4%B9%A6%E8%BF%94%E5%9B%9E%E4%BF%A1%E6%81%AF.png)

5）点击DELETE按钮，可以访问**删除图书的接口**：

![删除图书](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E5%88%A0%E9%99%A4%E5%9B%BE%E4%B9%A6.png)

返回，如下页面：

![删除图书返回信息](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/%E5%88%A0%E9%99%A4%E8%BF%94%E5%9B%9E%E4%BF%A1%E6%81%AF.png)

至此，是不是发现Django REST framework很好用！



### 三、Serializer序列化器

#### 3.1. 定义Serializer

##### 1.定义方法

Django REST framework中的Serializer使用类来定义，须继承自rest_framework.serializers.Serializer。

例如，我们已有了一个数据库模型类BookInfo

```python
class BookInfo(models.Model):
    title = models.CharField(max_length=20, verbose_name='名称')
    pub_date = models.DateField(verbose_name='发布日期', null=True)
    read = models.IntegerField(default=0, verbose_name='阅读量')
    comment = models.IntegerField(default=0, verbose_name='评论量')
    image = models.ImageField(upload_to='booktest', verbose_name='图片', null=True)
```

我们想为这个模型类提供一个序列化器，可以定义如下：

```python
class BookInfoSerializer(serializers.Serializer):
    """图书数据序列化器"""
    id = serializers.IntegerField(label='ID', read_only=True)
    title = serializers.CharField(label='名称', max_length=20)
    pub_date = serializers.DateField(label='发布日期', required=False)
    read = serializers.IntegerField(label='阅读量', required=False)
    comment = serializers.IntegerField(label='评论量', required=False)
    image = serializers.ImageField(label='图片', required=False)
```

**注意：serializer不是只能为数据库模型类定义，也可以为非数据库模型类的数据定义。**serializer是独立于数据库之外的存在。

> **总结:**
>
> - 1.序列化和反序列化是一对儿**逆向**过程, 用于数据结构之间的转换.
> - 2**.单独拿 DRF 框架**来说:
>   - **反序列化**:  前端数据 ->  python中的字典对象;
>   - **序列化**: 数据库模型类 -> 字典(返回给前端)      注: 如果是列表 safe=Fasle
> - 3.搞清楚 原生django的特点,存在需要**改进**的地方, 以及 DRF 是如何二次封装的.
>   - 最主要是大大简化了需要套路的  **序列化和反序列化** 操作
>   - 以及对常见的 `2种url和5种请求情况` 进行了 **面向对象** 的高级封装. 形成了一个通用的 **视图集**, 以及各种中间各种组合的**视图类**.
>   - 针对序列化和反序列化的过程,  **DRF** 还进行了整合, 通过 `read_only=True` 等选项的设置使得 这一对儿过程可以进行合并, 而不用分别写一个序列化器.

##### 2. 字段与选项

**常用字段类型**：

| 字段                    | 字段构造方式                                                 |
| ----------------------- | ------------------------------------------------------------ |
| **BooleanField**        | BooleanField()                                               |
| **NullBooleanField**    | NullBooleanField()                                           |
| **CharField**           | CharField(max_length=None, min_length=None, allow_blank=False, trim_whitespace=True) |
| **EmailField**          | EmailField(max_length=None, min_length=None, allow_blank=False) |
| **RegexField**          | RegexField(regex, max_length=None, min_length=None, allow_blank=False) |
| **SlugField**           | SlugField(max*length=50, min_length=None, allow_blank=False) 正则字段，验证正则模式 [a-zA-Z0-9*-]+ |
| **URLField**            | URLField(max_length=200, min_length=None, allow_blank=False) |
| **UUIDField**           | UUIDField(format='hex_verbose')  format:  1) `'hex_verbose'` 如`"5ce0e9a5-5ffa-654b-cee0-1238041fb31a"`  2） `'hex'` 如 `"5ce0e9a55ffa654bcee01238041fb31a"`  3）`'int'` - 如: `"123456789012312313134124512351145145114"`  4）`'urn'` 如: `"urn:uuid:5ce0e9a5-5ffa-654b-cee0-1238041fb31a"` |
| **IPAddressField**      | IPAddressField(protocol='both', unpack_ipv4=False, **options) |
| **IntegerField**        | IntegerField(max_value=None, min_value=None)                 |
| **FloatField**          | FloatField(max_value=None, min_value=None)                   |
| **DecimalField**        | DecimalField(max_digits, decimal_places, coerce_to_string=None, max_value=None, min_value=None) max_digits: 最多位数 decimal_palces: 小数点位置 |
| **DateTimeField**       | DateTimeField(format=api_settings.DATETIME_FORMAT, input_formats=None) |
| **DateField**           | DateField(format=api_settings.DATE_FORMAT, input_formats=None) |
| **TimeField**           | TimeField(format=api_settings.TIME_FORMAT, input_formats=None) |
| **DurationField**       | DurationField()                                              |
| **ChoiceField**         | ChoiceField(choices) choices与Django的用法相同               |
| **MultipleChoiceField** | MultipleChoiceField(choices)                                 |
| **FileField**           | FileField(max_length=None, allow_empty_file=False, use_url=UPLOADED_FILES_USE_URL) |
| **ImageField**          | ImageField(max_length=None, allow_empty_file=False, use_url=UPLOADED_FILES_USE_URL) |
| **ListField**           | ListField(child=, min_length=None, max_length=None)          |
| **DictField**           | DictField(child=)                                            |

**选项参数：**

| 参数名称            | 作用             |
| ------------------- | ---------------- |
| **max_length**      | 最大长度         |
| **min_lenght**      | 最小长度         |
| **allow_blank**     | 是否允许为空     |
| **trim_whitespace** | 是否截断空白字符 |
| **max_value**       | 最小值           |
| **min_value**       | 最大值           |

**通用参数：**

| 参数名称           | 说明                                          |
| ------------------ | --------------------------------------------- |
| **read_only**      | 表明该字段仅用于序列化输出，默认False         |
| **write_only**     | 表明该字段仅用于反序列化输入，默认False       |
| **required**       | 表明该字段在反序列化时必须输入，默认True      |
| **default**        | 反序列化时使用的默认值                        |
| **allow_null**     | 表明该字段是否允许传入None，默认False         |
| **validators**     | 该字段使用的验证器                            |
| **error_messages** | 包含错误编号与错误信息的字典                  |
| **label**          | 用于HTML展示API页面时，显示的字段名称         |
| **help_text**      | 用于HTML展示API页面时，显示的字段帮助提示信息 |

##### 3. 创建Serializer对象

定义好Serializer类后，就可以创建Serializer对象了。

Serializer的构造方法为：

```python
Serializer(instance=None, data=empty, **kwarg)
```

说明：

1）用于序列化时，将模型类对象传入**instance**参数

2）用于反序列化时，将要被反序列化的数据传入**data**参数

3）除了instance和data参数外，在构造Serializer对象时，还可通过**context**参数额外添加数据，如

```python
serializer = AccountSerializer(account, context={'request': request})
```

**通过context参数附加的数据，可以通过Serializer对象的context属性获取。**



#### 3.2. 序列化使用

我们在django shell中来学习序列化器的使用。

```shell
python manage.py shell
```

##### 1 基本使用

1） 先查询出一个图书对象

```python
from booktest.models import BookInfo

book = BookInfo.objects.get(id=2)
```

2） 构造序列化器对象

```python
from booktest.serializers import BookInfoSerializer

serializer = BookInfoSerializer(book)
```

3）获取序列化数据

通过data属性可以获取序列化后的数据

```python
serializer.data
# {'id': 2, 'title': '天龙八部', 'pub_date': '1986-07-24', 'read': 36, 'comment': 40, 'image': None}
```

4）如果要被序列化的是包含多条数据的查询集QuerySet，可以通过添加**many=True**参数补充说明

```python
book_qs = BookInfo.objects.all()
serializer = BookInfoSerializer(book_qs, many=True)
serializer.data
# [OrderedDict([('id', 2), ('title', '天龙八部'), ('pub_date', '1986-07-24'), ('read', 36), ('comment', 40), ('image', N]), OrderedDict([('id', 3), ('title', '笑傲江湖'), ('pub_date', '1995-12-24'), ('read', 20), ('comment', 80), ('image'ne)]), OrderedDict([('id', 4), ('title', '雪山飞狐'), ('pub_date', '1987-11-11'), ('read', 58), ('comment', 24), ('ima None)]), OrderedDict([('id', 5), ('title', '西游记'), ('pub_date', '1988-01-01'), ('read', 10), ('comment', 10), ('im', 'booktest/xiyouji.png')])]
```

##### 2 关联对象嵌套序列化

如果需要序列化的数据中包含有其他关联对象，则对关联对象数据的序列化需要指明。

例如，在定义英雄数据的序列化器时，外键hbook（即所属的图书）字段如何序列化？

我们先定义HeroInfoSerialzier除外键字段外的其他部分

```python
class HeroInfoSerializer(serializers.Serializer):
    """英雄数据序列化器"""
    GENDER_CHOICES = (
        (0, 'male'),
        (1, 'female')
    )
    id = serializers.IntegerField(label='ID', read_only=True)
    hname = serializers.CharField(label='名字', max_length=20)
    hgender = serializers.ChoiceField(choices=GENDER_CHOICES, label='性别', required=False)
    hcomment = serializers.CharField(label='描述信息', max_length=200, required=False, allow_null=True)
```

对于关联字段，可以采用以下几种方式：

#### 1） PrimaryKeyRelatedField

此字段将被序列化为关联对象的主键。

```python
hbook = serializers.PrimaryKeyRelatedField(label='图书', read_only=True)
或
hbook = serializers.PrimaryKeyRelatedField(label='图书', queryset=BookInfo.objects.all())
```

指明字段时需要包含read_only=True或者queryset参数：

- 包含read_only=True参数时，该字段将不能用作反序列化使用
- 包含queryset参数时，将被用作反序列化时参数校验使用

使用效果：

```python
from booktest.serializers import HeroInfoSerializer
from booktest.models import HeroInfo
hero = HeroInfo.objects.get(id=6)
serializer = HeroInfoSerializer(hero)
serializer.data
# {'id': 6, 'hname': '乔峰', 'hgender': 1, 'hcomment': '降龙十八掌', 'hbook': 2}
```

#### 2) StringRelatedField

此字段将被序列化为关联对象的字符串表示方式（即__str__方法的返回值）

```python
hbook = serializers.StringRelatedField(label='图书')
```

使用效果

```python
{'id': 6, 'hname': '乔峰', 'hgender': 1, 'hcomment': '降龙十八掌', 'hbook': '天龙八部'}
```

#### 3）HyperlinkedRelatedField

此字段将被序列化为获取关联对象数据的接口链接

```python
hbook = serializers.HyperlinkedRelatedField(label='图书', read_only=True, view_name='books-detail')
```

必须指明view_name参数，以便DRF根据视图名称寻找路由，进而拼接成完整URL。

使用效果

```python
{'id': 6, 'hname': '乔峰', 'hgender': 1, 'hcomment': '降龙十八掌', 'hbook': 'http://127.0.0.1:8000/books/2/'}
```

我们暂时还没有定义视图，此方式不再演示。

#### 4）SlugRelatedField

此字段将被序列化为关联对象的指定字段数据

```python
hbook = serializers.SlugRelatedField(label='图书', read_only=True, slug_field='pub_date')
```

slug_field指明使用关联对象的哪个字段

使用效果

```python
{'id': 6, 'hname': '乔峰', 'hgender': 1, 'hcomment': '降龙十八掌', 'hbook': datetime.date(1986, 7, 24)}
```

#### 5）使用关联对象的序列化器

```python
hbook = BookInfoSerializer()
```

使用效果

```python
{'id': 6, 'hname': '乔峰', 'hgender': 1, 'hcomment': '降龙十八掌', 'hbook': OrderedDict([('id', 2), ('title', '天龙八部')te', '1986-07-24'), ('read', 36), ('comment', 40), ('image', None)])}
```

#### 6） 重写to_representation方法

序列化器的每个字段实际都是由该字段类型的to_representation方法决定格式的，可以通过重写该方法来决定格式。

**注意，to_representations方法不仅局限在控制关联对象格式上，适用于各个序列化器字段类型。**

自定义一个新的关联字段：

```python
class BookRelateField(serializers.RelatedField):
    """自定义用于处理图书的字段"""
    def to_representation(self, value):
        return 'Book: %d %s' % (value.id, value.title)
```

指明hbook为BookRelateField类型

```python
hbook = BookRelateField(read_only=True)
```

使用效果

```python
{'id': 6, 'hname': '乔峰', 'hgender': 1, 'hcomment': '降龙十八掌', 'hbook': 'Book: 2 天龙八部'}
```

#### many参数

如果关联的对象数据不是只有一个，而是包含多个数据，如想序列化图书BookInfo数据，每个BookInfo对象关联的英雄HeroInfo对象可能有多个，此时关联字段类型的指明仍可使用上述几种方式，只是在声明关联字段时，多补充一个many=True参数即可。

此处仅拿PrimaryKeyRelatedField类型来举例，其他相同。

在BookInfoSerializer中添加关联字段：

```python
class BookInfoSerializer(serializers.Serializer):
    """图书数据序列化器"""
    id = serializers.IntegerField(label='ID', read_only=True)
    title = serializers.CharField(label='名称', max_length=20)
    pub_date = serializers.DateField(label='发布日期', required=False)
    read = serializers.IntegerField(label='阅读量', required=False)
    comment = serializers.IntegerField(label='评论量', required=False)
    image = serializers.ImageField(label='图片', required=False)
    heroinfo_set = serializers.PrimaryKeyRelatedField(read_only=True, many=True)  # 新增
```

使用效果：

```python
from booktest.serializers import BookInfoSerializer
from booktest.models import BookInfo
book = BookInfo.objects.get(id=2)
serializer = BookInfoSerializer(book)
serializer.data
# {'id': 2, 'title': '天龙八部', 'pub_date': '1986-07-24', 'read': 36, 'bc
```





### 四、视图







### 五、其他功能





#### 5.9 自动生成接口文档

> 1.drf 可以自动生成API文档, 并以**网页**形式展现
>
> 2.能生成的是继承 `APIView` 及其子类的视图



























































































































### 2. 业务逻辑(模块)





#### 1.用户

##### 1.1注册

- 图片验证码
  - 业务描述
- 短信验证码
  - 业务描述
  - 技术: redis管道
  - 技术: celery异步任务
- 用户名是否存在判断
- 手机号是否存在判断
- 注册保存用户数据
  - 技术:序列化器获取视图对象
    - self.context[request] 
    - self.context[ view] 
    - self.context[format] 
  - 技术:视图对象中的方法--获取视图参数
    - self.request
    - self.args  `/demo/(\d+)/`
    - self.kwargs  `/demo/(?P<order_id>\d+)/`
  - 保存用户的登陆状态:
    - session
    - jwt
      - token机制
      - token机制的流程
        - 签发
        - 验证
      - 构成
        - 头部  header
        - 载荷  payload
        - 签名  sign
      - 优点和注意事项
        - 优点: ?????
        - 注意: payload不放敏感数据
      - 适用的场景:    `前后端分离的场景`
      - drf中的实现:   引入扩展`djangorestframework-jwt`扩展

##### 1.2登陆

- 登陆
  - 技术: `djangorestframework-jwt`扩展提供了登陆处理视图
  - 技术: django中多种账号类型的登陆:
    - 构造 `ModelBackend` 的子类
    - 实现 `authenticate` 

##### 1.3找回密码

##### 1.4三方登录(QQ登陆)

- 业务:实现QQ登录的处理时序图能够描述清楚

- 技术: 工具类的封装: `SDK`  

  - 类的构造实现 
    - 思路: 1.先考虑使用场景; 2.用什么就添加什么
    - 属性和方法的选择 

- 技术: urllib

  - 1.python标准模块

  - 2.作用: 主要用python程序向外发送 http请求

  - 3.常用模块

    ```python
    urllib.parse.urlencode
    urllib.parse.parse_qs
    urllib.request.urlopen
    ```

```
- 技术:itsdangerous

##### 1.5个人中心

- 展示个人信息
- 邮箱验证
  - 业务
    -  保存邮箱并发送邮件
    - 邮箱验证链接
  - 技术
    - 发送邮件
      - 流程:  依赖邮箱服务器
      - django发送邮件的方法:  `send_mail`
    - 生成验证链接
      - 使用itsdangerous模块生成验证链接参数(包含用户的身份)
    - 使用celery异步发送邮件

##### 1.6邮件发送与认证

##### 1.7用户地址

- 业务  
  - 省市区三级联动
  - 用户地址管理
    - 增删改查
    - 默认地址
    - 地址标题
- 技术
  - 省市区可以用一张自关联的表保存
  - django中如何实现自关联(models.Model  -> ForeignKey  -> 'self')
  - 缓存
    - 作用: 减少数据库的查询次数
    - 原理: 1.先查询缓存; 2.如果缓存中没有数据查询数据库,并保存到缓存中; 3.如果缓存中有数据,直接读取并返回; 4. ==注意:== 缓存要设置有效期
    - drf使用缓存的方法:  (引入: `drf-extensions扩展` )
      - 装饰器
      - 扩展类继承
  - drf视图集的使用

##### 1.8用户浏览记录

- 业务
  - 浏览商品详情页记录浏览历史
  - 个人中心   产看浏览历史
- 技术
  - redis数据类型的选择
    - str  单一的数据
    - list  一组数据  有顺序  无去重
    - set  一组数据  无序  去重
    - hash  一组键值对数据
      - 不同于python中的字典
      - 键和值都是字符串
  - 浏览历史纪录   使用 list 保存

##### 1.9修改密码



#### 2.商品

##### <u>商品--前台部分--给消费者用户使用</u>

##### 2.1 首页广告

- 业务:广告数据
- 技术:页面静态化

##### 2.2 商品详情页

- 业务: 一部分静态化,一部分动态请求
- 技术: admin站点数据修改时静态化
  - django中如何向admin站点保存数据时添加自定义地逻辑
    - 自定义admin管理器
    - save_model
    - delete_model
  - 使用celery执行静态化地异步任务

##### 2.3 列表页

- 业务
- 技术
  - drf的列表视图中如何实现排序和分页

##### 2.4 搜索页

- 业务
- 技术: 搜索引擎

##### <u>商品--后台部分--公司内部运营人员使用</u>

##### 2.5 商品数据管理

- 技术
  - 概念:  SPU  SKU
  - 数据库的设计思路
    - 分析产品的原型图,明确要保存哪些数据
    - 分析中心(核心)数据
    - 确定中心数据需要保存哪些字段
    - 分析要保存的字段中,哪些可以保存到中心数据表中,哪些不合适保存到当前表,需要另建表保存.
    - 在确定了表和关系之后,确定了保存的基本数据,还要考虑使用数据库的查询方便与否
    - 考虑数据库在编程的时候的应用场景,是否可以通过添加冗余字段,减少数据库的查询时间
  - FastDFS  -- 图片保存

#### 3.购物车

- 业务
  - 3.1 登陆与未登陆的数据(状态)保存
  - 3.2 增
  - 3.3 删
  - 3.4 改
  - 3.5 查
  - 3.6 全选|反选
  - 3.6 合并购物车
- 技术
  - 登录   redis   
    - hash  数量
    - set  勾选状态
  - 未登录  cookie
    - 将购物车数据转换成字符串保存到cookie中
    - pickle
      - dumps
      - loads
    - base64
      - b64encode
      - b64decode
  - 登录合并
    - 修改jwt扩展提供的登录视图,补充合并逻辑



#### 4.订单

业务

- 4.1 订单结算(确认提交订单页面)
  - 数据来源于购物车redis的查询

- 4.2 保存订单

- 4.3 我的订单

- 4.4 订单评论

技术

- 事务
  - 作用
    - 保证数据的完整性,一些列相关的数据库操作一起成功或失败
    - Django当中的使用方式:  
      - 提供`transaction模块`
      - atomic
        - 装饰器
        - with
      - save_point
- 并发请求
  - 现象: 商品超卖(超库存)
  - 原因: 多个请求同时修改同一数据资源(资源竞争)
  - 解决方法
    - 悲观锁  :  数据库中真实存在的数据锁   -  死锁
    - 乐观锁  :  在更新时增加判断的逻辑
    - 任务队列  :  强制排队,将并行的请求串行化
- 数据库事务隔离级别
  - read  uncommit  读未提交
  - read   commited   读取已提交
  - repeated  read  可重复读
  - serialize  串行化
  - 解决: 在一个事务中读取的数据是否受到其它事务修改的影响



#### 5.支付

##### 5.1 第三方支付(支付宝支付)

业务

获取支付链接

保存支付结果

技术

调用支付宝的支付接口流程

#### 6.运营后台

技术

xadmin

- 增强了django原生的admin功能
- 使用方法

用户权限控制

- 作用: 不同的用户在admin站点中可以读取或修改哪些数据
- django的认证系统自带实现
- 用户权限 = 组权限 +  用户特有权限
- 借鉴意义: 通过6张表实现





### 技术选型

##### redis管道

- 1.减少程序与redis之间通信的网络消耗

- 2.管道收集了redis的命令,一次性发送给redis服务器执行

- 3.使用方法:

  ```python
  pl = pipeline()
  pl.xxx  # 命令同redis命令   那种类型的命令???
  pl.execute()   
  # 管道其实有点类似: '事务'

```

##### 跨域请求及解决

- 定义: 不同的域发起的请求
- `域(源)`的概念:
  - 域名  或  ip
  - 端口号
  - 协议  http   https
- 后端解决方式 `CORS` 
  - 具体思路:
    - 1.浏览器会先发送option请求,询问后端是否支持当前域名的跨域请求
    - 2.后端支持处理option请求,返回'同意'的响应
    - 3.思考如何在 Flask 项目中实现???
  - django的解决方式:
    - 1.在中间键中 处理option 
    - 2.使用  `django-cors-headers` 扩展来实现

##### JWT

##### itsdangerous(不用反映在简历中）

- 作用:生成token, 在token中保存隐藏一些数据,如果前端修改了token中的数据,可以通过校验识别错误的token
- `token`中包含了 **有效期** 和 **签名**
- 使用方法:
  - 创建对象
  - dumps
  - loads
- 应用场景: 1. 需要传递一些数据到前端,而且这些数据我们期望隐藏传递; 2.并且前端如果对这些数据进行了修改,我们还能通过校验发现.

```python
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer  # 注意:别名
from django.conf import settings

# serializer = Serializer(秘钥, 有效期秒)
serializer = Serializer(settings.SECRET_KEY, 300)
# serializer.dumps(数据), 返回bytes类型
token = serializer.dumps({'mobile': '18512345678'})
token = token.decode()  # bytes 解码

# 检验token
# 验证失败，会抛出itsdangerous.BadData异常
serializer = Serializer(settings.SECRET_KEY, 300)
try:
    data = serializer.loads(token)  # 字符串来解析成token, 过程中会进行校验
except BadData:
    return None
```



##### 第三方登录

##### 发送邮件与邮件激活

##### 缓存

##### Celery

- 作用: 将耗时任务交给celery执行, 减少视图响应时间
- 构成: client(任务发布程序), broker(任务队列), worker(任务执行者)
- 工作流程(运行原理)
- 使用方式
  - 定义任务   `@celery_app.task`   
  - 发布任务   `delay(可以传递参数)`
  - 启动worker   `celery -A  celery入口文件  -i worker 执行文件`
- 什么时候使用:  有需要将耗时任务从主程序剥离的时候,可以交给celery执行

```python
# celery 构成  -- "生产者 消费者模型"设计模式
1. 客户端(client) 任务发送方 - 谁调用,谁实现
2. 任务队列(broker)  解耦合
3. 任务执行者(worker)  多进程\多协程
# Celery就是一个用python写的并行分布式框架, 用来 异步 处理任务.
- Celery的架构
Celery的架构由三部分组成，消息中间件（message broker），任务执行单元（worker）和任务执行结果存储（task result store）组成。
- 消息中间件
Celery本身不提供消息服务，但是可以方便的和第三方提供的消息中间件集成，包括，RabbitMQ,Redis,MongoDB等，这里我先去了解RabbitMQ,Redis。
- 任务执行单元
Worker是Celery提供的任务执行的单元，worker并发的运行在分布式的系统节点中

----------------------------python中使用--------------------------
# 0. 创建独立的 包; 目录结构如下:
celery_tasks
├── config.py  # 必须添加配置文件,用来配置 消息中间件
├── email  # celery用来处理: email发送任务; html静态化任务; sms短信验证码任务;
│   ├── __init__.py
│   └── tasks.py  # 每一个具体任务的客户端, 文件命名必须是 tasks
├── html  # celery用来处理: html静态化任务;
│   ├── __init__.py
│   └── tasks.py
├── __init__.py
├── main.py  # celery 执行的入口
└── sms  # celery用来处理: sms短信验证码任务;
    ├── __init__.py
    ├── tasks.py
    └── utils
        ├── __init__.py
        └── yuntongxun
            ├── CCPRestSDK.py
            ├── __init__.py
            ├── sms.py

# 具体使用:
-----------在main.py文件中-------------
1. from celery import Celery    # 安装第三方的 celery(芹菜) 包
# 2.创建 celery_app
celery_app = Celery('celery名字')  # 可以给celery取一个项目相关的名字
	- Celery第一个参数是给其设定一个名字， 
    - 第二参数我们设定一个中间人broker
# 3.添加配置文件
celery_app.config_from_object("celery_tasks.config")  # 注意路径起始位置
# 4.自动注册
celery_app.autodiscover_tasks(['celery_tasks.sms', 'celery_tasks.email', 'celery_tasks.html'])  # 注意点:1.列表; 2.路径只需要写到 包 名即可, 自动取查找包里面的 tasks.py

-------------在 具体的 tasks.py 文件中----------------
# 5.1 通过装饰器的形式,指明worker任务.
@celery_app.task(name='send_sms_code')  # 装饰器传递参数,任务的名字; task是单数
def send_sms_code(mobile, code, expires):
    pass
# 5.2 注意要配置环境,以防任务中用到 django 的环境变量,因为 celery 是可以独立执行的.

--------------------在 views.py 中----------
6.对应的视图函数中, 通过 `任务名.delay()` ,还可以传递参数来执行
sms_tasks.send_sms_code.delay(mobile, sms_code, sms_code_expires)

注: 除了 delay,还可以使用更加复杂的 apply_async() 等函数

```

![celery说明](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/celery%E8%AF%B4%E6%98%8E.png)



##### SKU  SPU 概念  

##### FastDFS 图片存储

- 原因(优势)
  - 文件名与文件内容的对应关系
  - 扩展灵活
  - 备份方便
- 背景: 淘宝开源出来的适用于电商的图片文件存储系统
- 构成角色:
  - tracker服务器   
    - 调度协调
  - storage服务器
    - 文件存储
    - 会一起安装nginx, 直接向外提供文件
  - **Tracker**: 管理集群，tracker 也可以实现集群。每个 tracker 节点地位平等。收集 Storage 集群的状态。
  - **Storage**: 实际保存文件， Storage 分为多个组，每个组之间保存的文件是不同的。每 个组内部可以有多个成员，组成员内部保存的内容是一样的，组成员的地位是一致的，没有 主从的概念。
- Django的文件存储系统
  - django默认实现了文件存储`ImageField`
  - 默认图片保存在django运行的服务器本机中
  - 对接FastDFS, 需要修改默认的文件存储系统
  - 修改文件存储的方法
    - 构造 Storage 类的子类
- 扩展阅读
  - [分布式文件系统FastDFS详解](./技术专题--FastDFS.md)

```python
# 分布式文件系统的引入 - 解决图片存储的问题
- 1.文件命名和内容重复问题:
	- 1.1 不同用户,文件名相同,但是文件内容不同;
    - 1.2 文件名不同,但是文件内容相同.
- 2.灵活 扩展 备份 问题
	- 2.0 django的admin模块中自带 Image 支持,但是不能满足需求
	- 2.1 传统的解决思路: 增加磁盘,使用磁盘阵列(磁盘阵列是由很多价格较便宜的磁盘，组合成一个容量巨大的磁盘组)
        -2.1.1 存在问题一: 没有冗余功能，如果一个磁盘（物理）损坏，则所有的数据都无法使用。
        -2.1.2 存在问题二: 磁盘的利用率较低.
    - 2.2 磁盘阵列扩展,需要停机更新.
- 3.七牛云等平台 -- 成本问题

# 解决思路: 自主搭建 FastDFS 
1. 通过 加密算法(sha1, sha256, md5等) 计算出  计算机文件指纹, 然后解决 问题一;
2. 通过 FastDFS的特点,解决问题二和问题三;

# 应用场景:
    特别适合以中小文件（建议范围：4KB  file_size 500MB）为载体的在线服务，如相册网站、视频网站等等。

# 原理细节
1.分布式系统,肯定是一个 '服务器集群' 的概念. 三个部分构成,包括两个服务器+一个客户端.
2.tracker 调度服务器;  只负责调度
3.storage 存储服务器.  上传操作,先通过tracker(返回storage的ip和port)之后,然后然后上传给storage服务器, storage 保存,并对上传的内容进行 '加密算法' 处理, 生成的 'file_id' 保证文件的唯一性,然后将 'file_id'返回.  
4.文件下载需要通过 '网络请求, http协议', 是通过 FastDFS系统自动安装的 'Nginx' 实现的, storage服务器不擅长处理.
5.关于storage,其本身是按照 '群(卷)' 来划分, 同一个卷内部的 服务器 保存相同的内容, 但是没有主从的概念,主要用来备份; 不同卷的服务器保存的内容不同,用来扩展.

# 上传文件的流程:


# 优点：
- 扩展能力: 毫无疑问，扩展能力是一个分布式文件系统最重要的特点；
- 高可用性: 在分布式文件系统中，高可用性包含两层，一是整个文件系统的可用性，二是数据的完整和一致性；
- 弹性存储: 可以根据业务需要灵活地增加或缩减数据存储以及增删存储池中的资源，而不需要中断系统运行
# 缺点：
- 系统复杂度稍高，需要更多服务器

# 安装
1. 安装起来很复杂,一般由 运维 执行.
2. 方便: 引入 Docker

# 拓展思考
1.类比处理动态数据是: web服务器--web程序--数据库
2.图片属于静态文件是: nginx服务器 -- storage服务器
```



##### Docker

- 作用
  - 以容器的技术来实现"虚拟机",提供一个独立隔离的程序运行环境.
- 使用场景
  - 通常用来进行程序的部署安装,一次构建镜像,多次创建容器运行.
- 概念
  - 仓库
    - 共有仓库    `docker  hub`
    - 私有仓库    `公司会搭建私有仓库`: 在一台服务器中运行docker官方的仓库镜像即可.
  - 镜像 :  包括运行环境的程序
  - 容器 :  在独立空间运行起来的程序(进程)和其配套的资源 
- 基本操作
  - 镜像
  - 容器

```python
# Docker 和 虚拟机(虚拟系统) 的区别
Docker -- 容器技术
虚拟机 -- 虚拟化技术
其它对比,见下图

# Docker 适合搭载的操作系统:
1. Linux(ubuntu等)
2. windows
3. mac(原因: 对网络限制的比较多, 对于需要联网操作的话会有很大限制.)

# Docker 安装与使用(部分细节)
- 权限问题, 注销重新登录
- C/S架构
```

![Docker和虚拟机对比](C:/Users/richard/Desktop/2019%E5%B9%B4/MAIN/Knowledge_of_Python/img_django/container%E4%B8%8Evms%E5%AF%B9%E6%AF%942.png)

```python
# 使用Docker安装 FastDFS
1. 安装包含FastDFS的Docker镜像
- 1.1 通过 利用已有的FastDFS Docker镜像
- 1.2 通过 本地文件安装
2. 运行 tracker 服务器 (启动)   注:必须要先启动 tracker , 后启动 storage
3. 运行 storage 服务器 (启动)
--------------------
4.安装 python版本的FastDFS客户端
注:python版本的FastDFS客户端使用说明参考https://github.com/jefforeilly/fdfs_client-py
4.1 需要安装 github 最新的源码;
4.2 还需要安装两个 依赖 包: 'mutagen'  'requests'

5.需要修改配置文件,并将配置文件放置在 客户端文件 的目录中.
'''
base_path=FastDFS客户端存放日志文件的目录
tracker_server=运行tracker服务的机器ip:22122
'''
6.上传文件需要先创建fdfs_client.client.Fdfs_client的对象，并指明配置文件，也是有直接封装好的类,如
'''
from fdfs_client.client import Fdfs_client  
client = Fdfs_client('meiduo_mall/utils/fastdfs/client.conf')
'''
7.通过创建的客户端对象执行上传文件的方法
'''
# 指定文件路径上传
client.upload_by_filename(文件名)
 # 指定文件内容上传，注意
 # client.upload_by_buffer(文件bytes数据)
'''
------------------------------
8.自定义Django文件存储系统
(Django自带文件存储系统，但是默认文件存储在本地，在本项目中，我们需要将文件保存到FastDFS服务器上，所以需要自定义文件存储系统。)
1) 需要继承自django.core.files.storage.Storage，如
from django.core.files.storage import Storage

class FastDFSStorage(Storage):
    ...

2)支持Django不带任何参数来实例化存储类，也就是说任何设置都应该从django.conf.settings中获取
对应  __init__()方法

3)存储类中必须实现_open()和_save()方法，以及任何后续使用中可能用到的其他方法。

4)需要为存储类添加django.utils.deconstruct.deconstructible装饰器

# 代码如下
from django.conf import settings
from django.core.files.storage import Storage
from django.utils.deconstruct import deconstructible
from fdfs_client.client import Fdfs_client

@deconstructible  # 必须使用装饰器
class FastDFSStorage(Storage):
    def __init__(self, base_url=None, client_conf=None):
		"""用来添加配置文件和信息"""

    def _open(self, name, mode='rb'):  # 必须实现的方法之一
        """
        用不到打开文件，所以省略
        """
        pass

    def _save(self, name, content):   # 必须实现的方法之一
        """
        在FastDFS中保存文件
        :param name: 传入的文件名
        :param content: 文件内容
        :return: 保存到数据库中的FastDFS的文件名
        """
        client = Fdfs_client(self.client_conf)
        ret = client.upload_by_buffer(content.read())
        if ret.get("Status") != "Upload successed.":
            raise Exception("upload file failed")
        file_name = ret.get("Remote file_id")
        return file_name

    def url(self, name):
        """
        返回文件的完整URL路径
        :param name: 数据库中保存的文件名
        :return: 完整的URL
        """
        return self.base_url + name

    def exists(self, name):
        """
        判断文件是否存在，FastDFS可以自行解决文件的重名问题
        所以此处返回False，告诉Django上传的都是新文件
        :param name:  文件名
        :return: False
        """
        return False

说明: django 自动将 _save() 返回的数据(即这里是文件路径)保存到数据库,所以...
-------------------------------
9.最后 Django的 dev.py 文件中配置
# django文件存储
DEFAULT_FILE_STORAGE = 'buyfree.utils.fastdfs.fdfs_storage.FastDFSStorage'
# FastDFS
FDFS_URL = 'http://image.buyfree.site:8888/'    # 配置域名的形式,因为专门的服务器.
FDFS_CLIENT_CONF = os.path.join(BASE_DIR, 'utils/fastdfs/client.conf')
10. 在/etc/hosts中添加访问FastDFS storage服务器的域名 '127.0.0.1   image.buyfree.site'
```





##### 富文本编辑器

- 作用
  - 提供给前端的输入框支持格式编辑的功能;
  - CKEditer      `django-ckeditor` 

##### 页面静态化

- 作用: 提升服务器响应速度,减少动态接口的执行和数据库查询的次数
- 原理: 提前查询数据库,将数据渲染到模板中,写到静态的html文件中
- 说明: 页面静态化并不是全部页面都要静态化,可以一部分数据静态化,另一部分数据进行动态请求.
- 触发时机: 1.定时任务;  2.数据修改后生成
- 在django中使用定时任务完成

##### 定时任务

- django-crontab  
- ==|== 可以适当地扩展...

##### redis数据结构的设计

##### 列表页 分页

##### 搜索   全文检索

- 原因: 传统的sql查询,需要构造复杂的查询,模糊查询效率很低
- 原理: 维护索引数据(**分词**),通过将关键词在索引数据中检索,来提升查询速度.
- elasticsearch
  - java
  - rest API
- django中使用对接工具 haystack
- haystack的使用方法
  - 创建索引数据
  - 实现视图查询关键词
- 技术专题链接:  [技术专题](./技术专题--检索技术(elasticsearch).md)



##### 购物车

##### 订单保存

##### 支付宝的支付

##### xadmin

##### 权限控制

##### 数据库的读写分离

##### 部署相关

- 数据库
  - 主从分离
    - 作用: 备份, 分散数据库的压力
    - 配置方法
  - 读写分离
    - 通过程序代码分开控制数据库的读写
    - django中实现:  定义数据库的读写路由器类
      - db_for_read
      - db_for_write
- 部署
  - 静态文件处理  
    - django中需要收集静态文件
      - collectstatic
      - 收集目录  STATIC_ROOT
    - nginx提供
  - 动态程序的运行
    - uwsgi的使用方法
    - nginx转发
  - 项目的服务器结构

