## 课堂:

### django的 `View`  

> View源码中的部分方法功能复习:
>
> ```python
> as_view方法,返回的是view方法的引用  # 用于  url装饰器  
> 	as_view内部封装了 view方法  # 
>     	view方法 返回的是 dispatch(request)方法的调用   实现了通过请求方式和视图method方法的关联       
> ```
>
> django的view的**<u>用法</u>**:
>
> ```python
> class BookView(View):  # step1 继承View
>     def get(request, *args, **kwrags):  # step2:自定义get|post...等方法
>         ...  # 接收请求
>         return HTTPResponse('ok')  # step3: 接收请求,(处理请求),返回响应    
> ```
>
> 

### APIView

注:`APIView`是REST framework提供的所有视图的基类，继承自Django的`View`父类。 

相比于 Django开发的`自定义APIView` 接口(继承View类)如BooksAPIView等, `rest_framework` 框架在views.py中定义了标准的 `APIView` 接口:

#### APIVIew 设计优势 

> 下面是按照**重要性**排序,而不是源码的处理顺序排序: 
>
> 1. **提供**了 rest 的 `request` 代替 Django的 HttpRequest 方法
>
> 2. **建议**返回rest 的 `response` 代替Django的 HttpResponse 方法
>
> 3. 在调用视图方法的时候,会进行`异常捕获` 并返回合适的响应(比如处理成json格式而不是原来的Django格式)
>
> 4. 在调用视图方法之前,会进行用户 `身份确认, 权限校验,限流校验`
>
> 5. 提供`CSRF` 免除 (解释: 在发起post请求时, 关闭对csrf_token的校验)
>
>    <u>注: 还是需要自定义 get post put... 等视图方法</u>

**关键词: 1. Request ;  2. Response;  3. 异常捕获;  4. 身份认证\权限校验\限流校验;  5. csrf免除**

> 源码的处理顺序:  ==提示: APIView重写了dispatch方法,所以被装饰之后的view方法依然先调用的是APIview的dispatch的方法而不是父类的该方法,在重写的dispatch方法中实现了功能优化==
>
> ![1536286769722](C:\Users\XIEG2\AppData\Local\Temp\1536286769722.png)
>
> ```python
> # 源码-- rest_frame 的 views.py中的 APIView类的dispatch方法
> def dispatch(self, request, *args, **kwargs):
>         """
>         `.dispatch()` is pretty much the same as Django's regular dispatch,
>         but with extra hooks for startup, finalize, and exception handling.
>         """
>         self.args = args
>         self.kwargs = kwargs
>         # request 优化
>         request = self.initialize_request(request, *args, **kwargs)  
>         self.request = request
>         self.headers = self.default_response_headers  # deprecate?
> 
>         try:  
>             self.initial(request, *args, **kwargs)  # 权限校验
> 
>             # Get the appropriate handler method
>             if request.method.lower() in self.http_method_names:
>                 handler = getattr(self, request.method.lower(),
>                                   self.http_method_not_allowed)
>             else:
>                 handler = self.http_method_not_allowed
> 
>             response = handler(request, *args, **kwargs)
> 
>         except Exception as exc:
>             response = self.handle_exception(exc)  # 异常捕获处理
> 		# 建议response 优化
>         self.response = self.finalize_response(request, response, *args, **kwargs)
>         return self.response
> ```
>
> ```python
> # 源码-- APIView类的dispatch方法 中 封装的权限校验方法initial方法
> def initial(self, request, *args, **kwargs):
>         .................
> 
>         # Ensure that the incoming request is permitted
>         self.perform_authentication(request)  # 身份确认
>         self.check_permissions(request)  # 权限校验
>         self.check_throttles(request)  # 限流校验
> ```
>
> #### 总结:源码对应关系
>
> ```python
> dispatch方法封装
> 	1. initialize_request  # request
>     2. finalize_response  # response
>     3. handle_exception  # 异常捕获
>     4. initial  # 权限校验
> 5. as_view   # csrf免除
> 
> ```

#### 补充: request 和response

> <u>**HttpRequest**</u>  
>
> POST(表单形式提交的请求体)        GET(请求url相关)       body(其它请求体, 接收的是bytes形式)
>
> <u>**Request**</u>
>
> .quert_params     =  GET    (这个可以通过源码容易看出来)
>
> .data  >= POST  (获取的不限于表单格式的请求体,可以是json等格式,最后获取的是字典的子类QuerySet )
>
> **<u>Response</u>**
>
> Response(data, status=None, template_name=None, headers=None, content_type=None)  
>
> 进行了适当的扩展; 这里的data只需要传入`字典格式数据`即可,不用再向以前一样传入其它类型数据
>
> **<u>序列化器</u>**
>
> 传入的都是已经转化成字典的数据; 然后传出的也是字典类型数据.
>
> 通俗: 吃字典吐字典
>
> **<u>四种获取数据的形式</u>**
>
> kwargs 字典
>
> GET/query_params 字典(QueryDict)
>
> data  字典 (通过postman测试,传递过来json格式对应dict; 传递过来普通表单(www...)对应QueryDict是字典的子类)
>
> META 字典



### GenericAPIView

继承自`APIVIew`，增加了对于 <u>列表视图</u>和 <u>详情视图</u> 可能用到的**通用支持方法**。通常使用时，可搭配一个或多个Mixin扩展类。 

#### GenericAPIView 设计优势
> 1. 为 查询, 修改, 删除 提供数据集的功能;	==>>  get_object | get_queryset
>
> 2. 提供序列化器功能;                                        ==>>  get_serializer
>
> 3. 提供列表过滤功能;                                        ==>>  filter_queryset
>
> 4. 提供列表分页功能;                                        ==>>  paginate_queryset
>   **关键词： 1.数据；  2.序列化器； 3.过滤； 4.分页**
>
>   <u>注: 可以直接调用GenericAPIView提供的方法(见下面)</u>

#### GenericAPIView 用法

> 1.使用提供数据的方法 比如`get_queryset`、`get_object`，需要我们提供类属性`queryset` 
> 2.使用提供序列化器对象的方法：`get_serializer`，需要我们提供类属性`serializer_class`
> 3.使用提供的过滤或者分页功能(不重要)

#### GenericAPIView源码

```python
# 提供了两个序列化方法:获取序列化类和序列化实例; 

class GenericAPIView(views.APIView):
    """
    Base class for all other generic views.
    """
    # You'll need to either set these attributes,
    # or override `get_queryset()`/`get_serializer_class()`.
    # If you are overriding a view method, it is important that you call
    # `get_queryset()` instead of accessing the `queryset` property directly,
    # as `queryset` will get evaluated only once, and those results are cached
    # for all subsequent requests.
    queryset = None
    serializer_class = None

    # If you want to use object lookups other than pk, set 'lookup_field'.
    # For more complex lookup requirements override `get_object()`.
    lookup_field = 'pk'
    lookup_url_kwarg = None

    # The filter backend classes to use for queryset filtering
    filter_backends = api_settings.DEFAULT_FILTER_BACKENDS

    # The style to use for queryset pagination.
    pagination_class = api_settings.DEFAULT_PAGINATION_CLASS

    def get_queryset(self):
        """
        Get the list of items for this view.
        This must be an iterable, and may be a queryset.
        Defaults to using `self.queryset`.

        This method should always be used rather than accessing `self.queryset`
        directly, as `self.queryset` gets evaluated only once, and those results
        are cached for all subsequent requests.

        You may want to override this if you need to provide different
        querysets depending on the incoming request.

        (Eg. return a list of items that is specific to the user)
        """
        assert self.queryset is not None, (
            "'%s' should either include a `queryset` attribute, "
            "or override the `get_queryset()` method."
            % self.__class__.__name__
        )

        queryset = self.queryset
        if isinstance(queryset, QuerySet):
            # Ensure queryset is re-evaluated on each request.
            queryset = queryset.all()
        return queryset

    def get_object(self):
        """
        Returns the object the view is displaying.

        You may want to override this if you need to provide non-standard
        queryset lookups.  Eg if objects are referenced using multiple
        keyword arguments in the url conf.
        """
        queryset = self.filter_queryset(self.get_queryset())

        # Perform the lookup filtering.
        lookup_url_kwarg = self.lookup_url_kwarg or self.lookup_field

        assert lookup_url_kwarg in self.kwargs, (
            'Expected view %s to be called with a URL keyword argument '
            'named "%s". Fix your URL conf, or set the `.lookup_field` '
            'attribute on the view correctly.' %
            (self.__class__.__name__, lookup_url_kwarg)
        )

        filter_kwargs = {self.lookup_field: self.kwargs[lookup_url_kwarg]}
        obj = get_object_or_404(queryset, **filter_kwargs)

        # May raise a permission denied
        self.check_object_permissions(self.request, obj)

        return obj

    def get_serializer(self, *args, **kwargs):
        """
        Return the serializer instance that should be used for validating and
        deserializing input, and for serializing output.
        """
        serializer_class = self.get_serializer_class()
        kwargs['context'] = self.get_serializer_context()  # 获得值是 字典
        return serializer_class(*args, **kwargs)  # 返回一个实例对象

    def get_serializer_class(self):
        """
        Return the class to use for the serializer.
        Defaults to using `self.serializer_class`.

        You may want to override this if you need to provide different
        serializations depending on the incoming request.

        (Eg. admins get full serialization, others get basic serialization)
        """
        assert self.serializer_class is not None, (
            "'%s' should either include a `serializer_class` attribute, "
            "or override the `get_serializer_class()` method."
            % self.__class__.__name__
        )

        return self.serializer_class

    def get_serializer_context(self):
        """
        Extra context provided to the serializer class.
        """
        return {
            'request': self.request,
            'format': self.format_kwarg,
            'view': self
        }

    def filter_queryset(self, queryset):
        """
        Given a queryset, filter it with whichever filter backend is in use.

        You are unlikely to want to override this method, although you may need
        to call it either from a list view, or from a custom `get_object`
        method if you want to apply the configured filtering backend to the
        default queryset.
        """
        for backend in list(self.filter_backends):
            queryset = backend().filter_queryset(self.request, queryset, self)
        return queryset

    @property
    def paginator(self):
        """
        The paginator instance associated with the view, or `None`.
        """
        if not hasattr(self, '_paginator'):
            if self.pagination_class is None:
                self._paginator = None
            else:
                self._paginator = self.pagination_class()
        return self._paginator

    def paginate_queryset(self, queryset):
        """
        Return a single page of results, or `None` if pagination is disabled.
        """
        if self.paginator is None:
            return None
        return self.paginator.paginate_queryset(queryset, self.request, view=self)

    def get_paginated_response(self, data):
        """
        Return a paginated style `Response` object for the given output data.
        """
        assert self.paginator is not None
        return self.paginator.get_paginated_response(data)
```

#### 通过GenericAPIView源码分析,使用的时候注意事项:

> 1.==必须==要在子类中`配置`(重写)两个类属性: **`queryset`** 和 **`serializer_class`** , 否则断言"不能为空"就会报错.
>
> 2.如果是操作单个对象潜在要求:  url规则中必须写成:  **`(?P<pk>...)`**
>
> 3.==可以==配置类属性: `filter_backends`   -->列表过滤   和     `pagination_class`  --> 列表分页
>
>   注: 可以在 rest_framework的settings.py中找到 对应的`DEFAULT_PAGINATION_CLASS` 和 `DEFAULT_FILTER_BACKENDS`   分别是 None  和  ( ) .         所以最终的功能还是需要自己去实现.

#### GenericAPIView 如何同 序列化器进行关联呢?

> 前置知识 --  <u>**序列化器**</u>实现 method 方法中对数据进行校验
>
> 在此基础上进行  `继承`  和`部分code函数调用`的修改
>
> ```python
> # 为了提高复用性,可以在自定义的XxView中设置 [类属性]
> serializer_class = BookInfoSerializer / HeroInfoSerializer
> quesryser = BookInfo / HeroInfo .objects.all()
> 
> # class BookView(APIView):
> # 继承的类变成  GenericAPIView
> class BookView(GenericAPIView):  
>     # 增加 单个 
>     def post(self, request):
>         # s = XxSerializer(data=request.data)
>         s = get_serializer(data=request.data)
>         s.is_valid(raise_exception=True)
>         s.save()
>         return Response(data=s.data, status=201)
> 
>     # 查多个
>     def get(self, request, *args, **kwargs):
>         # queryset = BookInfo.objects.all()
>         queryset = get_query_set()
>         s = XxSerializer(instance=queryset, many=True)
>         return Response(data=s.data)
> 
>     # 查单个
>     def get(self, request, *args, **kwargs):
>         # book = BookInfo.object.all().filter(pk=pk).get()
>         book = self.get_object()
>         s = XxSerializer(instance=book)
>         return Response(data=s.data)
> 
>     # 改单个
>     def put(self, request, *args, **kwargs):
>         book = BookInfo.object.all().filter(pk=kwargs['pk']).get()
>         s = XxSerializer(instance=book,data=request.data)
>         s.is_valid(raise_exception=True)
>         s.save()
>         return Response(data=s.data)
> 
>     # 删单个
>     def delete(self, request, pk):
>         book = BookInfo.object.all().filter(pk=pk).get()
>         book.delete()
>         return Response(status=204)
>     
>     def get_object(self):
>         try:
>             return BookInfo.objects.all().filter(pk=self.kwargs['pk']).get()
>         except BookInfo.DoesNotExist:
>             raise Http404('图书不存在')
> ```
>
> 但是, 以上仍然比较繁琐,  于是考虑继承 `mixin的扩展类` , 再结合 `GenericAPIView` 的思路



#### <u>Mixin功能:</u>

1. 提供了==标准==的增删改查方法(见下面的源码)

2. 需要`多继承`于`mixin`和`GenericAPIView` 一起使用,     (单继承 -->> 多继承)

   1. ①配置类属性(queryset, serializer_classs) 
   2. ②视图方法中调用对用的`mixin`提供的`action` 方法

   关键字:  1. 标准 增删改查    2. 多继承  类属性  视图方法 `action` 方法 

==补充:  什么是action方法????和 视图方法 method (get, post 等)区别????==

> action方法包括：
>
> **create		list		retrieve		update		partial_update		destroy**
>
> 视图方法(methods)方法：
>
> **get		post	put		patch	 delete		...**

#### mixins.py的源码

> ```python
> class CreateModelMixin(object):
>     """
>     Create a model instance.
>     """
>     def create(self, request, *args, **kwargs):
>         serializer = self.get_serializer(data=request.data)
>         serializer.is_valid(raise_exception=True)
>         self.perform_create(serializer)
>         headers = self.get_success_headers(serializer.data)
>         return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
> 
>     def perform_create(self, serializer):
>         serializer.save()
> 
>     def get_success_headers(self, data):
>         try:
>             return {'Location': str(data[api_settings.URL_FIELD_NAME])}
>         except (TypeError, KeyError):
>             return {}
> 
> 
> class ListModelMixin(object):
>     """
>     List a queryset.
>     """
>     def list(self, request, *args, **kwargs):
>         queryset = self.filter_queryset(self.get_queryset())
> 
>         page = self.paginate_queryset(queryset)
>         if page is not None:
>             serializer = self.get_serializer(page, many=True)
>             return self.get_paginated_response(serializer.data)
> 
>         serializer = self.get_serializer(queryset, many=True)
>         return Response(serializer.data)
> 
> 
> class RetrieveModelMixin(object):
>     """
>     Retrieve a model instance.
>     """
>     def retrieve(self, request, *args, **kwargs):
>         instance = self.get_object()
>         serializer = self.get_serializer(instance)
>         return Response(serializer.data)
> 
> 
> class UpdateModelMixin(object):
>     """
>     Update a model instance.
>     """
>     def update(self, request, *args, **kwargs):
>         partial = kwargs.pop('partial', False)
>         instance = self.get_object()
>         serializer = self.get_serializer(instance, data=request.data, partial=partial)
>         serializer.is_valid(raise_exception=True)
>         self.perform_update(serializer)
> 
>         if getattr(instance, '_prefetched_objects_cache', None):
>             # If 'prefetch_related' has been applied to a queryset, we need to
>             # forcibly invalidate the prefetch cache on the instance.
>             instance._prefetched_objects_cache = {}
> 
>         return Response(serializer.data)
> 
>     def perform_update(self, serializer):
>         serializer.save()
> 
>     def partial_update(self, request, *args, **kwargs):
>         kwargs['partial'] = True
>         return self.update(request, *args, **kwargs)
> 
> 
> class DestroyModelMixin(object):
>     """
>     Destroy a model instance.
>     """
>     def destroy(self, request, *args, **kwargs):
>         instance = self.get_object()
>         self.perform_destroy(instance)
>         return Response(status=status.HTTP_204_NO_CONTENT)
> 
>     def perform_destroy(self, instance):
>         instance.delete()
> ```
>
> **<u>总结: 提供了5个ModelMixin类</u>**

#### 我们的code

> ```python
> # views_mixin_generic.py
> 
> class BooksAPIView(GenericAPIView, CreateModelMixin, ListModelMixin):
>     queryset = BookInfo.objects.all()
>     serializer_class = BookInfoSerializer
> 
>     def get(self, request, *args, **kwargs):
>         return self.list(request)
> 
>     def post(self, request, *args, **kwargs):
>         return self.create(request)
> 
> 
> class BookAPIView(GenericAPIView, RetrieveModelMixin, UpdateModelMixin, DestroyModelMixin):
>     queryset = BookInfo.objects.all()
>     serializer_class = BookInfoSerializer
> 
>     def get(self, request, *args, **kwargs):
>         return self.retrieve(request, *args, **kwargs)
> 
>     def put(self, request, *args, **kwargs):
>         return self.update(request, *args, **kwargs)
> 
>     def patch(self, request, *args, **kwargs):
>         return self.partial_update(request, *args, **kwargs)
> 
>     def delete(self, request, *args, **kwargs):
>         return self.destroy(request, *args, **kwargs)
> ```
>
> 



### <u>XXAPIView:</u>

#### XxAPIView用法:

> 1.**自带**多继承于 `Mixin的扩展类` 和 `GenericAPIView` 
>
> 2.**只需要**配置类属性(queryset, serializer_class)即可,视图方法调 `action` 方法已经完成 

####  ==标准写法== :

> ```python
> # 下面是generics.py的源码, 是多继承于 GenericAPIView类 和 Mixin扩展类 
> 
> class CreateAPIView(mixins.CreateModelMixin,
>                     GenericAPIView):
>     """
>     Concrete view for creating a model instance.
>     """
>     def post(self, request, *args, **kwargs):
>         return self.create(request, *args, **kwargs)
> 
> class ListAPIView(mixins.ListModelMixin,
>                   GenericAPIView):
>     """
>     Concrete view for listing a queryset.
>     """
>     def get(self, request, *args, **kwargs):
>         return self.list(request, *args, **kwargs)
> 
> class RetrieveAPIView(mixins.RetrieveModelMixin,
>                       GenericAPIView):
>     """
>     Concrete view for retrieving a model instance.
>     """
>     def get(self, request, *args, **kwargs):
>         return self.retrieve(request, *args, **kwargs)
> 
> class DestroyAPIView(mixins.DestroyModelMixin,
>                      GenericAPIView):
>     """
>     Concrete view for deleting a model instance.
>     """
>     def delete(self, request, *args, **kwargs):
>         return self.destroy(request, *args, **kwargs)
> 
> class UpdateAPIView(mixins.UpdateModelMixin,
>                     GenericAPIView):
>     """
>     Concrete view for updating a model instance.
>     """
>     def put(self, request, *args, **kwargs):
>         return self.update(request, *args, **kwargs)
> 
>     def patch(self, request, *args, **kwargs):
>         return self.partial_update(request, *args, **kwargs)
> 
> class ListCreateAPIView(mixins.ListModelMixin,
>                         mixins.CreateModelMixin,
>                         GenericAPIView):
>     """
>     Concrete view for listing a queryset or creating a model instance.
>     """
>     def get(self, request, *args, **kwargs):
>         return self.list(request, *args, **kwargs)
> 
>     def post(self, request, *args, **kwargs):
>         return self.create(request, *args, **kwargs)
> 
> class RetrieveUpdateAPIView(mixins.RetrieveModelMixin,
>                             mixins.UpdateModelMixin,
>                             GenericAPIView):
>     """
>     Concrete view for retrieving, updating a model instance.
>     """
>     def get(self, request, *args, **kwargs):
>         return self.retrieve(request, *args, **kwargs)
> 
>     def put(self, request, *args, **kwargs):
>         return self.update(request, *args, **kwargs)
> 
>     def patch(self, request, *args, **kwargs):
>         return self.partial_update(request, *args, **kwargs)
> 
> class RetrieveDestroyAPIView(mixins.RetrieveModelMixin,
>                              mixins.DestroyModelMixin,
>                              GenericAPIView):
>     """
>     Concrete view for retrieving or deleting a model instance.
>     """
>     def get(self, request, *args, **kwargs):
>         return self.retrieve(request, *args, **kwargs)
> 
>     def delete(self, request, *args, **kwargs):
>         return self.destroy(request, *args, **kwargs)
> 
> class RetrieveUpdateDestroyAPIView(mixins.RetrieveModelMixin,
>                                    mixins.UpdateModelMixin,
>                                    mixins.DestroyModelMixin,
>                                    GenericAPIView):
>     """
>     Concrete view for retrieving, updating or deleting a model instance.
>     """
>     def get(self, request, *args, **kwargs):
>         return self.retrieve(request, *args, **kwargs)
> 
>     def put(self, request, *args, **kwargs):
>         return self.update(request, *args, **kwargs)
> 
>     def patch(self, request, *args, **kwargs):
>         return self.partial_update(request, *args, **kwargs)
> 
>     def delete(self, request, *args, **kwargs):
>         return self.destroy(request, *args, **kwargs)
> ```
>
> 我们可以自定义 XxxAPIView(继承于`XxxModelMixin`类,` GenericAPIView`类), 其中`XxxModelMixin`类提供了各种  `action`方法(用来操作数据库)   ;  `GenericAPIView`类提供了各种 `methods`方法(用来处理不同的请求类型.)
>
> 上面的源码 自己封装了 `更加规范的 方法` ,且其方法自身还进一步进行了更好的"抽取"; 我们使用的时候可以直接继承该现成的方法即可.

#### 我们的code:

> ```python
> class BooksAPIView(ListCreateAPIView):
>     queryset = BookInfo.objects.all()
>     serializer_class = BookInfoSerializer
> 
> 
> class BookAPIView(RetrieveUpdateDestroyAPIView):
>     queryset = BookInfo.objects.all()
>     serializer_class = BookInfoSerializer
> ```
> **<u>总结: 显然上面的代码还有冗余,有没有新的解决方案? 视图集诞生了...</u>**





### 视图集<u>ViewSetMixin</u>

> 1.重写了` as_view` 方法, 进行了方法 `映射` 把 `actions` 方法映射为`视图(methods)`方法
>
> 2.(自己补充:)**实现了一个视图类 对应多个 url**
>
> ?	 **注: 1.必须给 urls中设置  as_view(actions={k:V})**
>
> ?	       **2.必须继承ViewSetMixin类 ,尤其还要注意：其位置必须在 GenericAPIView 之前** 

#### 我们的code:

> ```python
> 
> # views_viewset.py
> class BookViewSet(CreateModelMixin,
>                   ListModelMixin,
>                   RetrieveModelMixin,
>                   UpdateModelMixin,
>                   DestroyModelMixin,
>                   ViewSetMixin,  # 顺序
>                   GenericAPIView):
>     
>     queryset = BookInfo.objects.all()
>     serializer_class = BookInfoSerializer
> 
> # 关于请求方式: get post put patch delete  都没有
> # 但是 它有   retrieve  list   create  update  partial_update  destroy
> # 去修改url;  同时理解它如何重写dispatch方法
> # 注意点:必须导入ViewSetMixin，　尤其还要注意：其位置必须在 GenericAPIView 之前,因为其重写 dispatch方法, 保证它的dispatch方法先于GenericAPIView的dispatch方法被调用.
> 
> -------------------------------------------------------------------------------------
> 重写 dispatch方法的几个关键源码如下:
>     ...
>     for method, action in actions.items():
>         handler = getattr(self, action)
>         setattr(self, method, handler)
>      ...
>     # actions 需要我们自己传递,否则不能通过抛出异常验证.
> ```
>
> **<u>总结: 我们发现我们自定义的`BookViewSet`类和 框架中的viewsets.py中的`ModelViewSet` 类很相似,所以我们继续标准化</u>**



### <u>**XxMixin:**</u>

> 1.提供了所有功能的 ` ModelViewSet` 
>
> 2.提供了只读功能的 `ReadOnlyModelViewSet`

#### 优化我们的code为:

> ```python
> # views_model_viewset.py
> 
> class BookViewSet(ModelViewSet):
>     queryset = BookInfo.objects.all()
>     serializer_class = BookInfoSerializer
> 
> # class BookViewSet(ReadOnlyModelViewSet):
> #     queryset = BookInfo.objects.all()
> #     serializer_class = BookInfoSerializer
> ```
>
> **<u>总结: 提供了两个模型视图集  `ModelViewSet`  和  `ReadOnlyModelViewSet`; 但是每次都要配置比较固定的actions={}比较繁琐,于是有了下面的 url路由器</u>**



### **<u>url路由器</u>**

> 1.提供了非常简化的 url 配置方式

#### 在urls.py文件中进行配置

> ```python
> 
> # 优化每次都要写actions的问题
> # 继承关系 DefaultRouter( SimpleRouter  ( BaseRouter  ))
> # SimpleRouter 类的属性中为我们写好了 mapping={'get': 'list','post': 'create'}, 类似这种
> router = DefaultRouter()
> router.register('books', views.BookViewSet)  # 第二个参数我们自定义的视图集
> urlpatterns += router.urls  # router的urls是 BaseRouter 的一个属性.
> 
> # 推荐写下面这种
> router = SimpleRouter()
> router.register('books', views.BookViewSet)
> urlpatterns += router.urls
> ```
>
> **见下面的直观图形**:
>
> ![1536364049037](C:\Users\XIEG2\AppData\Local\Temp\1536364049037.png)

#### SimpleRouter 和 DefaultRouter 的区别:

> 参考源码 以及下面
>
> ![1536367235589](C:\Users\XIEG2\AppData\Local\Temp\1536367235589.png)
>
> ![1536367255547](C:\Users\XIEG2\AppData\Local\Temp\1536367255547.png)
>
> 可以看到 DefaultRouter 相比之下提供了 `根路由` 的访问, 和 `format` 的访问.这样可以通过url直接选择想要获取的资源类型,达到和 设置Accept请求头一样的效果,举例如下:  
>
> ```python
> http://127.0.0.1:8000/books.api/
> http://127.0.0.1:8000/books.json/
> http://127.0.0.1:8000/books.html/
> ```

#### urls路由的另外一种形式:

> 需求: 给 `模型类视图集` 自定义 一个函数
>
> ```python
> # /books/latest/   get->latest
> @action(methods=['get'], detail=False)  # detail 控制的是(?P<pk>\d+)参数
> def latest(self, request):
>     instance = self.get_queryset().order_by('-id')[0]
>     serializer = self.get_serializer(instance)
>     return Response(serializer.data)
> ```
>
> 

### 让Django支持 xml 格式的文件, 且正常显示:

> 注:参考资料 [Django rest xml](https://github.com/jpadilla/django-rest-framework-xml)
>
> - 1.去rest_framework框架中settings.py模块中 找 `REST_FRAMEWORK` 配置进行修改,对照github上的配置
> - 2.注意 `DEFAULT_RENDERER_CLASSES` 的配置顺序, 先是`api` 其次 `json` 然后才是 `xml` ,才能保证在前端界面正常反应.

### 解决json格式在浏览器出现乱码问题

> ![1536391298194](C:\Users\XIEG2\AppData\Local\Temp\1536391298194.png)
>
> 去看配置`settings.py`的源码 `类 JSONRenderer` 中 `charset=None` 是默认配置,源码是在其父类 `BaseRenderer` 中设置的` charset = 'utf-8'` 
>
> 解决思路:
>
> - 1.我们遵循不随意改动源码的原则,可以自定义一个类去继承 这个设置类, 并给它重新配置`charset` 属性.
> - 2.小tips: Pycharm键 `copy reference `
> - 3.再去修改配置的部分



### 关于序列化器一张重要的图片

> ![1536395765519](C:\Users\XIEG2\AppData\Local\Temp\1536395765519.png)
>
>  注:.........









python 强类型\动态\解释性语言

       	1. 强类型: 不同数据类型不能进行运算操作;
       	2. 动态:变量随着后面赋值的不同可以变换类型;   --> java 静态语言
       	3. 解释性语言



Django校验的时候，存在`隐式转换` , 比如数字型字符串可以自动转化成数字; 而且还会自动添加一些其它功能. 校验完的数据是字典格式:

> ![1536240743326](C:\Users\XIEG2\AppData\Local\Temp\1536240743326.png)





小细节: 在url中传递参数`pk` 时, 如果不指定 `?P=` 那么传递到 `*args`  ; 如果指定传递到 `**kwargs` ,这个在操作参数的时候,可能会有影响.



序列化器操作细节:

> ![1536241469254](C:\Users\XIEG2\AppData\Local\Temp\1536241469254.png)
>
> 其中, Response 中 data 可以等于 request.data,  s.valided_data, s.data  都一样









request.user   是request的属性之一

查询集 是惰性的 ,可以节约 数据库资源; 只有在`使用(遍历, 取值等)`的时候才会发起`查询` 

编码是 json配置中  =None







<u>关于 浏览器的Accept请求头 和 Content-Type头 , 以及在$.Ajax中`dataType` 和 `contentType` 的关系:</u>

> Accept: 代表(发送端|客户端)希望接收的数据类型;
>
> Content-Type: 代表(发送端|服务器)发送的 实体数据的数据类型
>
> **$.Ajax()**
>
> dataType:  预期服务器返回的数据类型;
>
> contentType: 发送信息至服务器时内容编码类型
>
> **<u>总结:contentType代表发送的数据类型; Accept和dataType代表期望接收的数据类型</u>**



<u>小技巧</u>:

- 1.给类指定提示类,方便开发:

(没有提示的原因是: Pycharm不知道其返回值是什么类型,所以不知道如何提示...)

> ```python
> @action(methods=['get'], detail=False)
> def latest(self, request):
>     raise DatabaseError()
>     book = BookInfo.objects.latest('id')
>     serializer = self.get_serializer(book)  # 
>     serializer.is_invid(raise_exception=True)  # 没有提示信息, 去源码中get_serializer方法后面(冒号的前面)指定" -> Serializer "
>     return Response(serializer.data)
> ```
>
> ![1536365781780](C:\Users\XIEG2\AppData\Local\Temp\1536365781780.png)
>
>  注: 要在这个类的上面导入: <u>from rest_framework import serializers</u>
>
> ![1536371498532](C:\Users\XIEG2\AppData\Local\Temp\1536371498532.png)
>
> 注: 这个例子 是在 后面写request: Request



- 2.Pycharm 按键:   Copy Reference  可以自动将某个py文件中的 类 或 函数 的引用路径复制; 这样在其它位置调用的时候 或 进行全局配置 可以降低手写产生的出错概率.
- 3.导包问题:  从app中导包的时候,如果都是导入 views 可能发生冲突   ==>> 解决思路: views as fxviews  `别名`
- 4.三个报错:

> ![1536372401010](C:\Users\XIEG2\AppData\Local\Temp\1536372401010.png)
>
> ![1536372464103](C:\Users\XIEG2\AppData\Local\Temp\1536372464103.png)
>
> ![1536372571087](C:\Users\XIEG2\AppData\Local\Temp\1536372571087.png)



存在疑问:

元组列表   可迭代   单个元素             逗号问题

数据的类型: Django 和 rest_frame的区别 



非魔法方法的装饰器 原理?

csrf免除之后如何保证安全?     部分免除,具体后面项目有场景

正向代理和反向代理

setattr

hasattr

getattr



### 贴一下自己写的源码:

>```python
># Create your views here.
>from rest_framework.viewsets import ModelViewSet, ReadOnlyModelViewSet
>
>from book_test.models import BookInfo
>from book_test.serializers import BookInfoSerializer
>
>
>class BookViewSet(ModelViewSet):
>    queryset = BookInfo.objects.all()
>    serializer_class = BookInfoSerializer
>
>
># class BookViewSet(ReadOnlyModelViewSet):
>#     queryset = BookInfo.objects.all()
>#     serializer_class = BookInfoSerializer
>
>
>'''
>class BookViewSet(CreateModelMixin,
>                  ListModelMixin,
>                  RetrieveModelMixin,
>                  UpdateModelMixin,
>                  DestroyModelMixin,
>                  ViewSetMixin,
>                  GenericAPIView):
>    queryset = BookInfo.objects.all()
>    serializer_class = BookInfoSerializer
>
>
># 关于请求方式: get post put patch delete  都没有
># 但是 它有   retrieve  list   create  update  partial_update  destroy
># 去修改url;  同时理解它如何重写dispatch方法
># 注意点:必须导入ViewSetMixin，　尤其还要注意：其位置必须在 GenericAPIView 之前,因为其重写 dispatch方法, 否则会首先调用 GenericAPIView的dispatch方法
>'''
>
>"""
>class BooksAPIView(GenericAPIView, CreateModelMixin, ListModelMixin):
>    queryset = BookInfo.objects.all()
>    serializer_class = BookInfoSerializer
>
>    def get(self, request, *args, **kwargs):
>        return self.list(request)
>
>    def post(self, request, *args, **kwargs):
>        return self.create(request)
>
>
>class BookAPIView(GenericAPIView, RetrieveModelMixin, UpdateModelMixin, DestroyModelMixin):
>    queryset = BookInfo.objects.all()
>    serializer_class = BookInfoSerializer
>
>    def get(self, request, *args, **kwargs):
>        return self.retrieve(request, *args, **kwargs)
>
>    def put(self, request, *args, **kwargs):
>        return self.update(request, *args, **kwargs)
>
>    def patch(self, request, *args, **kwargs):
>        return self.partial_update(request, *args, **kwargs)
>
>    def delete(self, request, *args, **kwargs):
>        return self.destroy(request, *args, **kwargs)
>"""
>
>"""
>class BooksAPIView(GenericAPIView):
>    queryset = BookInfo.objects.all()
>    serializer_class = BookInfoSerializer
>
>    def get(self, request, *args, **kwargs):
>        instance = self.get_queryset()
>        serializer = self.get_serializer(instance=instance, many=True)
>        return Response(data=serializer.data)
>
>    def post(self, request, *args, **kwargs):
>        serializer = self.get_serializer(data=request.data)
>        serializer.is_valid(raise_exception=True)
>        serializer.save()
>        return Response(data=serializer.data, status=201)
>
>
>class BookAPIView(GenericAPIView):
>    queryset = BookInfo.objects.all()
>    serializer_class = BookInfoSerializer
>
>    def get(self, request, *args, **kwargs):
>        book = self.get_object()
>        serializer = self.get_serializer(instance=book)
>        return Response(data=serializer.data)
>
>    def put(self, request, *args, **kwargs):
>        instance = self.get_object()
>        serializer = self.get_serializer(instance=instance, data=request.data)
>        serializer.is_valid(raise_exception=True)
>        serializer.save()
>        return Response(data=serializer.data, status=201)
>
>    def delete(self, request, *args, **kwargs):
>        instance = self.get_object()
>        instance.delete()  # 不需要引入序列化器
>        return Response(status=204)
>"""
>
>"""
>class BooksAPIView(APIView):
>    def get(self, request, *args, **kwargs):
>        instance = BookInfo.objects.all()
>        serializer = BookInfoSerializer(instance=instance, many=True)
>        return Response(data=serializer.data)
>
>    def post(self, request, *args, **kwargs):
>        serializer = BookInfoSerializer(data=request.data)
>        serializer.is_valid(raise_exception=True)
>        serializer.save()
>        return Response(data=serializer.data, status=201)
>
>
>class BookAPIView(APIView):
>    def get(self, request, *args, **kwargs):
>        book = self.get_object()
>        serializer = BookInfoSerializer(instance=book)
>        return Response(data=serializer.data)
>
>    def put(self, request, *args, **kwargs):
>        instance = self.get_object()
>        serializer = BookInfoSerializer(instance=instance, data=request.data)
>        serializer.is_valid(raise_exception=True)
>        serializer.save()
>        return Response(data=serializer.data, status=201)
>
>    def delete(self, request, *args, **kwargs):
>        instance = self.get_object()
>        instance.delete()  # 不需要引入序列化器
>        return Response(status=204)
>
>    def get_object(self):
>        try:
>            return BookInfo.objects.all().filter(pk=self.kwargs['pk']).get()
>        except BookInfo.DoesNotExist:
>            raise Http404('图书不存在')
>"""
>
>```
>
>

