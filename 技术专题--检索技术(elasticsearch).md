### 搜索引擎来实现全文检索

##### 1.搜索引擎原理

- 1.搜索引擎并不是直接在数据库中进行检索,而是对数据库中的数据进行预处理,**单独**建立起一份**索引结构数据**;
- 类似`字典`,  将**关键字**和 **词条的对应关系**,同时记录**词条所在的位置**.
- 实现的结果是:  `全文检索`

<u>注: 大牛文章 链接 : [Elasticsearch－基础介绍及索引原理分析](https://www.cnblogs.com/dreamroute/p/8484457.html)</u>

##### 2. [Elasticsearch ](https://www.elastic.co/) 开源,是目前的首选,底层是开源库 [Lucene](https://lucene.apache.org/). 维基百科、Stack Overflow、Github 都采用它

##### 3.java开发, 但是 ==REST API(可以发送HTTP网络请求来调用,而不是通过类或者函数的方式)==

##### 4.使用haystack对接Elasticsearch(用docker来装载它)

- <u>Haystack为Django提供了模块化的搜索。它的特点是统一的，熟悉的API，可以让你在不修改代码的情况下使用不同的搜索后端（比如 Solr, Elasticsearch, Whoosh, Xapian 等等）。</u>
- **在django中可以通过使用haystack来调用Elasticsearch搜索引擎。**

##### 5.具体使用

1) 安装

```python
pip install drf-haystack
pip install elasticsearch==2.4.1
```

2)注册应用

```python
INSTALLED_APPS = [
    ...
    'haystack',
    ...
]
```

3）配置

在配置文件中配置haystack使用的搜索引擎后端

```python
# Haystack
HAYSTACK_CONNECTIONS = {
    'default': {
        'ENGINE': 'haystack.backends.elasticsearch_backend.ElasticsearchSearchEngine',
        'URL': 'http://10.211.55.5:9200/',  # 此处为elasticsearch运行的服务器ip地址，端口号固定为9200
        'INDEX_NAME': 'buyfree',  # 指定elasticsearch建立的索引库的名称
    },
}

# 当添加、修改、删除数据时，自动生成索引
HAYSTACK_SIGNAL_PROCESSOR = 'haystack.signals.RealtimeSignalProcessor'
```

**注意：**

**HAYSTACK_SIGNAL_PROCESSOR 的配置保证了在Django运行起来后，有新的数据产生时，haystack仍然可以让Elasticsearch实时生成新数据的索引**

4）创建索引类

通过创建索引类，来指明让搜索引擎对哪些字段建立索引，也就是可以通过哪些字段的关键字来检索数据。

在goods应用中新建search_indexes.py文件，用于存放索引类

```python
from haystack import indexes

from .models import SKU


class SKUIndex(indexes.SearchIndex, indexes.Indexable):
    """
    SKU索引数据模型类
    """
    text = indexes.CharField(document=True, use_template=True)
    id = indexes.IntegerField(model_attr='id')
    name = indexes.CharField(model_attr='name')
    price = indexes.DecimalField(model_attr='price')
    default_image_url = indexes.CharField(model_attr='default_image_url')
    comments = indexes.IntegerField(model_attr='comments')

    def get_model(self):
        """返回建立索引的模型类"""
        return SKU

    def index_queryset(self, using=None):
        """返回要建立索引的数据查询集"""
        return self.get_model().objects.filter(is_launched=True)
```

在SKUIndex建立的字段，都可以借助haystack由elasticsearch搜索引擎查询。

其中text字段我们声明为document=True，表名该字段是主要进行关键字查询的字段， 该字段的索引值可以由多个数据库模型类字段组成，具体由哪些模型类字段组成，我们用use_template=True表示后续通过模板来指明。其他字段都是通过model_attr选项指明引用数据库模型类的特定字段。

在REST framework中，索引类的字段会作为查询结果返回数据的来源。

6）在templates目录中创建text字段使用的模板文件

具体在templates/search/indexes/goods/sku_text.txt文件中定义

```python
{{ object.name }}
{{ object.caption }}
{{ object.id }}
```

此模板指明当将关键词通过text参数名传递时，可以通过sku的name、caption、id来进行关键字索引查询。

7）手动生成初始索引

```python
python manage.py rebuild_index
```

8）创建序列化器

在goods/serializers.py中创建haystack序列化器

```python
from drf_haystack.serializers import HaystackSerializer

class SKUIndexSerializer(HaystackSerializer):
    """
    SKU索引结果数据序列化器
    """
    class Meta:
        index_classes = [SKUIndex]
        fields = ('text', 'id', 'name', 'price', 'default_image_url', 'comments')
```

**注意fields属性的字段名与SKUIndex类的字段对应。**

9）创建视图

在goods/views.py中创建视图

```python
from drf_haystack.viewsets import HaystackViewSet

class SKUSearchViewSet(HaystackViewSet):
    """
    SKU搜索
    """
    index_models = [SKU]

    serializer_class = SKUIndexSerializer
```

##### 注意：

- 该视图会返回搜索结果的列表数据，所以如果可以为视图增加REST framework的分页功能。
- 我们在实现商品列表页面时已经定义了全局的分页配置，所以此搜索视图会使用全局的分页配置。

返回的数据举例如下：

```json
{
    "count": 10,
    "next": "http://api.meiduo.site:8000/skus/search/?page=2&text=%E5%8D%8E",
    "previous": null,
    "results": [
        {
            "text": "华为 HUAWEI P10 Plus 6GB+64GB 钻雕金 移动联通电信4G手机 双卡双待\nwifi双天线设计！徕卡人像摄影！P10徕卡双摄拍照，低至2988元！\n9",
            "id": 9,
            "name": "华为 HUAWEI P10 Plus 6GB+64GB 钻雕金 移动联通电信4G手机 双卡双待",
            "price": "3388.00",
            "default_image_url": "http://10.211.55.5:8888/group1/M00/00/02/CtM3BVrRcUeAHp9pAARfIK95am88523545",
            "comments": 0
        },
        {
            "text": "华为 HUAWEI P10 Plus 6GB+128GB 钻雕金 移动联通电信4G手机 双卡双待\nwifi双天线设计！徕卡人像摄影！P10徕卡双摄拍照，低至2988元！\n10",
            "id": 10,
            "name": "华为 HUAWEI P10 Plus 6GB+128GB 钻雕金 移动联通电信4G手机 双卡双待",
            "price": "3788.00",
            "default_image_url": "http://10.211.55.5:8888/group1/M00/00/02/CtM3BVrRchWAMc8rAARfIK95am88158618",
            "comments": 5
        }
    ]
}
```

10）定义路由

通过REST framework的router来定义路由

```python
router = DefaultRouter()
router.register('skus/search', views.SKUSearchViewSet, base_name='skus_search')

...

urlpatterns += router.urls
```

11）测试

我们可以GET方法访问如下链接进行测试

```http
http://api.meiduo.site:8000/skus/search/?text=wifi
http://api.meiduo.site:8000/skus/search/?id=1
http://api.meiduo.site:8000/skus/search/?name=iphone
```









