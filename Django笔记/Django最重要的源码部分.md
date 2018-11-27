## ����:

### django�� `View`  

> ViewԴ���еĲ��ַ������ܸ�ϰ:
>
> ```python
> as_view����,���ص���view����������  # ����  urlװ����  
> 	as_view�ڲ���װ�� view����  # 
>     	view���� ���ص��� dispatch(request)�����ĵ���   ʵ����ͨ������ʽ����ͼmethod�����Ĺ���       
> ```
>
> django��view��**<u>�÷�</u>**:
>
> ```python
> class BookView(View):  # step1 �̳�View
>     def get(request, *args, **kwrags):  # step2:�Զ���get|post...�ȷ���
>         ...  # ��������
>         return HTTPResponse('ok')  # step3: ��������,(��������),������Ӧ    
> ```
>
> 

### APIView

ע:`APIView`��REST framework�ṩ��������ͼ�Ļ��࣬�̳���Django��`View`���ࡣ 

����� Django������`�Զ���APIView` �ӿ�(�̳�View��)��BooksAPIView��, `rest_framework` �����views.py�ж����˱�׼�� `APIView` �ӿ�:

#### APIVIew ������� 

> �����ǰ���**��Ҫ��**����,������Դ��Ĵ���˳������: 
>
> 1. **�ṩ**�� rest �� `request` ���� Django�� HttpRequest ����
>
> 2. **����**����rest �� `response` ����Django�� HttpResponse ����
>
> 3. �ڵ�����ͼ������ʱ��,�����`�쳣����` �����غ��ʵ���Ӧ(���紦���json��ʽ������ԭ����Django��ʽ)
>
> 4. �ڵ�����ͼ����֮ǰ,������û� `���ȷ��, Ȩ��У��,����У��`
>
> 5. �ṩ`CSRF` ��� (����: �ڷ���post����ʱ, �رն�csrf_token��У��)
>
>    <u>ע: ������Ҫ�Զ��� get post put... ����ͼ����</u>

**�ؼ���: 1. Request ;  2. Response;  3. �쳣����;  4. �����֤\Ȩ��У��\����У��;  5. csrf���**

> Դ��Ĵ���˳��:  ==��ʾ: APIView��д��dispatch����,���Ա�װ��֮���view������Ȼ�ȵ��õ���APIview��dispatch�ķ��������Ǹ���ĸ÷���,����д��dispatch������ʵ���˹����Ż�==
>
> ![1536286769722](C:\Users\XIEG2\AppData\Local\Temp\1536286769722.png)
>
> ```python
> # Դ��-- rest_frame �� views.py�е� APIView���dispatch����
> def dispatch(self, request, *args, **kwargs):
>         """
>         `.dispatch()` is pretty much the same as Django's regular dispatch,
>         but with extra hooks for startup, finalize, and exception handling.
>         """
>         self.args = args
>         self.kwargs = kwargs
>         # request �Ż�
>         request = self.initialize_request(request, *args, **kwargs)  
>         self.request = request
>         self.headers = self.default_response_headers  # deprecate?
> 
>         try:  
>             self.initial(request, *args, **kwargs)  # Ȩ��У��
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
>             response = self.handle_exception(exc)  # �쳣������
> 		# ����response �Ż�
>         self.response = self.finalize_response(request, response, *args, **kwargs)
>         return self.response
> ```
>
> ```python
> # Դ��-- APIView���dispatch���� �� ��װ��Ȩ��У�鷽��initial����
> def initial(self, request, *args, **kwargs):
>         .................
> 
>         # Ensure that the incoming request is permitted
>         self.perform_authentication(request)  # ���ȷ��
>         self.check_permissions(request)  # Ȩ��У��
>         self.check_throttles(request)  # ����У��
> ```
>
> #### �ܽ�:Դ���Ӧ��ϵ
>
> ```python
> dispatch������װ
> 	1. initialize_request  # request
>     2. finalize_response  # response
>     3. handle_exception  # �쳣����
>     4. initial  # Ȩ��У��
> 5. as_view   # csrf���
> 
> ```

#### ����: request ��response

> <u>**HttpRequest**</u>  
>
> POST(����ʽ�ύ��������)        GET(����url���)       body(����������, ���յ���bytes��ʽ)
>
> <u>**Request**</u>
>
> .quert_params     =  GET    (�������ͨ��Դ�����׿�����)
>
> .data  >= POST  (��ȡ�Ĳ����ڱ���ʽ��������,������json�ȸ�ʽ,����ȡ�����ֵ������QuerySet )
>
> **<u>Response</u>**
>
> Response(data, status=None, template_name=None, headers=None, content_type=None)  
>
> �������ʵ�����չ; �����dataֻ��Ҫ����`�ֵ��ʽ����`����,����������ǰһ������������������
>
> **<u>���л���</u>**
>
> ����Ķ����Ѿ�ת�����ֵ������; Ȼ�󴫳���Ҳ���ֵ���������.
>
> ͨ��: ���ֵ����ֵ�
>
> **<u>���ֻ�ȡ���ݵ���ʽ</u>**
>
> kwargs �ֵ�
>
> GET/query_params �ֵ�(QueryDict)
>
> data  �ֵ� (ͨ��postman����,���ݹ���json��ʽ��Ӧdict; ���ݹ�����ͨ��(www...)��ӦQueryDict���ֵ������)
>
> META �ֵ�



### GenericAPIView

�̳���`APIVIew`�������˶��� <u>�б���ͼ</u>�� <u>������ͼ</u> �����õ���**ͨ��֧�ַ���**��ͨ��ʹ��ʱ���ɴ���һ������Mixin��չ�ࡣ 

#### GenericAPIView �������
> 1. Ϊ ��ѯ, �޸�, ɾ�� �ṩ���ݼ��Ĺ���;	==>>  get_object | get_queryset
>
> 2. �ṩ���л�������;                                        ==>>  get_serializer
>
> 3. �ṩ�б���˹���;                                        ==>>  filter_queryset
>
> 4. �ṩ�б��ҳ����;                                        ==>>  paginate_queryset
>   **�ؼ��ʣ� 1.���ݣ�  2.���л����� 3.���ˣ� 4.��ҳ**
>
>   <u>ע: ����ֱ�ӵ���GenericAPIView�ṩ�ķ���(������)</u>

#### GenericAPIView �÷�

> 1.ʹ���ṩ���ݵķ��� ����`get_queryset`��`get_object`����Ҫ�����ṩ������`queryset` 
> 2.ʹ���ṩ���л�������ķ�����`get_serializer`����Ҫ�����ṩ������`serializer_class`
> 3.ʹ���ṩ�Ĺ��˻��߷�ҳ����(����Ҫ)

#### GenericAPIViewԴ��

```python
# �ṩ���������л�����:��ȡ���л�������л�ʵ��; 

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
        kwargs['context'] = self.get_serializer_context()  # ���ֵ�� �ֵ�
        return serializer_class(*args, **kwargs)  # ����һ��ʵ������

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

#### ͨ��GenericAPIViewԴ�����,ʹ�õ�ʱ��ע������:

> 1.==����==Ҫ��������`����`(��д)����������: **`queryset`** �� **`serializer_class`** , �������"����Ϊ��"�ͻᱨ��.
>
> 2.����ǲ�����������Ǳ��Ҫ��:  url�����б���д��:  **`(?P<pk>...)`**
>
> 3.==����==����������: `filter_backends`   -->�б����   ��     `pagination_class`  --> �б��ҳ
>
>   ע: ������ rest_framework��settings.py���ҵ� ��Ӧ��`DEFAULT_PAGINATION_CLASS` �� `DEFAULT_FILTER_BACKENDS`   �ֱ��� None  ��  ( ) .         �������յĹ��ܻ�����Ҫ�Լ�ȥʵ��.

#### GenericAPIView ���ͬ ���л������й�����?

> ǰ��֪ʶ --  <u>**���л���**</u>ʵ�� method �����ж����ݽ���У��
>
> �ڴ˻����Ͻ���  `�̳�`  ��`����code��������`���޸�
>
> ```python
> # Ϊ����߸�����,�������Զ����XxView������ [������]
> serializer_class = BookInfoSerializer / HeroInfoSerializer
> quesryser = BookInfo / HeroInfo .objects.all()
> 
> # class BookView(APIView):
> # �̳е�����  GenericAPIView
> class BookView(GenericAPIView):  
>     # ���� ���� 
>     def post(self, request):
>         # s = XxSerializer(data=request.data)
>         s = get_serializer(data=request.data)
>         s.is_valid(raise_exception=True)
>         s.save()
>         return Response(data=s.data, status=201)
> 
>     # ����
>     def get(self, request, *args, **kwargs):
>         # queryset = BookInfo.objects.all()
>         queryset = get_query_set()
>         s = XxSerializer(instance=queryset, many=True)
>         return Response(data=s.data)
> 
>     # �鵥��
>     def get(self, request, *args, **kwargs):
>         # book = BookInfo.object.all().filter(pk=pk).get()
>         book = self.get_object()
>         s = XxSerializer(instance=book)
>         return Response(data=s.data)
> 
>     # �ĵ���
>     def put(self, request, *args, **kwargs):
>         book = BookInfo.object.all().filter(pk=kwargs['pk']).get()
>         s = XxSerializer(instance=book,data=request.data)
>         s.is_valid(raise_exception=True)
>         s.save()
>         return Response(data=s.data)
> 
>     # ɾ����
>     def delete(self, request, pk):
>         book = BookInfo.object.all().filter(pk=pk).get()
>         book.delete()
>         return Response(status=204)
>     
>     def get_object(self):
>         try:
>             return BookInfo.objects.all().filter(pk=self.kwargs['pk']).get()
>         except BookInfo.DoesNotExist:
>             raise Http404('ͼ�鲻����')
> ```
>
> ����, ������Ȼ�ȽϷ���,  ���ǿ��Ǽ̳� `mixin����չ��` , �ٽ�� `GenericAPIView` ��˼·



#### <u>Mixin����:</u>

1. �ṩ��==��׼==����ɾ�Ĳ鷽��(�������Դ��)

2. ��Ҫ`��̳�`��`mixin`��`GenericAPIView` һ��ʹ��,     (���̳� -->> ��̳�)

   1. ������������(queryset, serializer_classs) 
   2. ����ͼ�����е��ö��õ�`mixin`�ṩ��`action` ����

   �ؼ���:  1. ��׼ ��ɾ�Ĳ�    2. ��̳�  ������  ��ͼ���� `action` ���� 

==����:  ʲô��action����????�� ��ͼ���� method (get, post ��)����????==

> action����������
>
> **create		list		retrieve		update		partial_update		destroy**
>
> ��ͼ����(methods)������
>
> **get		post	put		patch	 delete		...**

#### mixins.py��Դ��

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
> **<u>�ܽ�: �ṩ��5��ModelMixin��</u>**

#### ���ǵ�code

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

#### XxAPIView�÷�:

> 1.**�Դ�**��̳��� `Mixin����չ��` �� `GenericAPIView` 
>
> 2.**ֻ��Ҫ**����������(queryset, serializer_class)����,��ͼ������ `action` �����Ѿ���� 

####  ==��׼д��== :

> ```python
> # ������generics.py��Դ��, �Ƕ�̳��� GenericAPIView�� �� Mixin��չ�� 
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
> ���ǿ����Զ��� XxxAPIView(�̳���`XxxModelMixin`��,` GenericAPIView`��), ����`XxxModelMixin`���ṩ�˸���  `action`����(�����������ݿ�)   ;  `GenericAPIView`���ṩ�˸��� `methods`����(��������ͬ����������.)
>
> �����Դ�� �Լ���װ�� `���ӹ淶�� ����` ,���䷽��������һ�������˸��õ�"��ȡ"; ����ʹ�õ�ʱ�����ֱ�Ӽ̳и��ֳɵķ�������.

#### ���ǵ�code:

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
> **<u>�ܽ�: ��Ȼ����Ĵ��뻹������,��û���µĽ������? ��ͼ��������...</u>**





### ��ͼ��<u>ViewSetMixin</u>

> 1.��д��` as_view` ����, �����˷��� `ӳ��` �� `actions` ����ӳ��Ϊ`��ͼ(methods)`����
>
> 2.(�Լ�����:)**ʵ����һ����ͼ�� ��Ӧ��� url**
>
> ?	 **ע: 1.����� urls������  as_view(actions={k:V})**
>
> ?	       **2.����̳�ViewSetMixin�� ,���仹Ҫע�⣺��λ�ñ����� GenericAPIView ֮ǰ** 

#### ���ǵ�code:

> ```python
> 
> # views_viewset.py
> class BookViewSet(CreateModelMixin,
>                   ListModelMixin,
>                   RetrieveModelMixin,
>                   UpdateModelMixin,
>                   DestroyModelMixin,
>                   ViewSetMixin,  # ˳��
>                   GenericAPIView):
>     
>     queryset = BookInfo.objects.all()
>     serializer_class = BookInfoSerializer
> 
> # ��������ʽ: get post put patch delete  ��û��
> # ���� ����   retrieve  list   create  update  partial_update  destroy
> # ȥ�޸�url;  ͬʱ����������дdispatch����
> # ע���:���뵼��ViewSetMixin�������仹Ҫע�⣺��λ�ñ����� GenericAPIView ֮ǰ,��Ϊ����д dispatch����, ��֤����dispatch��������GenericAPIView��dispatch����������.
> 
> -------------------------------------------------------------------------------------
> ��д dispatch�����ļ����ؼ�Դ������:
>     ...
>     for method, action in actions.items():
>         handler = getattr(self, action)
>         setattr(self, method, handler)
>      ...
>     # actions ��Ҫ�����Լ�����,������ͨ���׳��쳣��֤.
> ```
>
> **<u>�ܽ�: ���Ƿ��������Զ����`BookViewSet`��� ����е�viewsets.py�е�`ModelViewSet` �������,�������Ǽ�����׼��</u>**



### <u>**XxMixin:**</u>

> 1.�ṩ�����й��ܵ� ` ModelViewSet` 
>
> 2.�ṩ��ֻ�����ܵ� `ReadOnlyModelViewSet`

#### �Ż����ǵ�codeΪ:

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
> **<u>�ܽ�: �ṩ������ģ����ͼ��  `ModelViewSet`  ��  `ReadOnlyModelViewSet`; ����ÿ�ζ�Ҫ���ñȽϹ̶���actions={}�ȽϷ���,������������� url·����</u>**



### **<u>url·����</u>**

> 1.�ṩ�˷ǳ��򻯵� url ���÷�ʽ

#### ��urls.py�ļ��н�������

> ```python
> 
> # �Ż�ÿ�ζ�Ҫдactions������
> # �̳й�ϵ DefaultRouter( SimpleRouter  ( BaseRouter  ))
> # SimpleRouter ���������Ϊ����д���� mapping={'get': 'list','post': 'create'}, ��������
> router = DefaultRouter()
> router.register('books', views.BookViewSet)  # �ڶ������������Զ������ͼ��
> urlpatterns += router.urls  # router��urls�� BaseRouter ��һ������.
> 
> # �Ƽ�д��������
> router = SimpleRouter()
> router.register('books', views.BookViewSet)
> urlpatterns += router.urls
> ```
>
> **�������ֱ��ͼ��**:
>
> ![1536364049037](C:\Users\XIEG2\AppData\Local\Temp\1536364049037.png)

#### SimpleRouter �� DefaultRouter ������:

> �ο�Դ�� �Լ�����
>
> ![1536367235589](C:\Users\XIEG2\AppData\Local\Temp\1536367235589.png)
>
> ![1536367255547](C:\Users\XIEG2\AppData\Local\Temp\1536367255547.png)
>
> ���Կ��� DefaultRouter ���֮���ṩ�� `��·��` �ķ���, �� `format` �ķ���.��������ͨ��urlֱ��ѡ����Ҫ��ȡ����Դ����,�ﵽ�� ����Accept����ͷһ����Ч��,��������:  
>
> ```python
> http://127.0.0.1:8000/books.api/
> http://127.0.0.1:8000/books.json/
> http://127.0.0.1:8000/books.html/
> ```

#### urls·�ɵ�����һ����ʽ:

> ����: �� `ģ������ͼ��` �Զ��� һ������
>
> ```python
> # /books/latest/   get->latest
> @action(methods=['get'], detail=False)  # detail ���Ƶ���(?P<pk>\d+)����
> def latest(self, request):
>     instance = self.get_queryset().order_by('-id')[0]
>     serializer = self.get_serializer(instance)
>     return Response(serializer.data)
> ```
>
> 

### ��Django֧�� xml ��ʽ���ļ�, ��������ʾ:

> ע:�ο����� [Django rest xml](https://github.com/jpadilla/django-rest-framework-xml)
>
> - 1.ȥrest_framework�����settings.pyģ���� �� `REST_FRAMEWORK` ���ý����޸�,����github�ϵ�����
> - 2.ע�� `DEFAULT_RENDERER_CLASSES` ������˳��, ����`api` ��� `json` Ȼ����� `xml` ,���ܱ�֤��ǰ�˽���������Ӧ.

### ���json��ʽ�������������������

> ![1536391298194](C:\Users\XIEG2\AppData\Local\Temp\1536391298194.png)
>
> ȥ������`settings.py`��Դ�� `�� JSONRenderer` �� `charset=None` ��Ĭ������,Դ�������丸�� `BaseRenderer` �����õ�` charset = 'utf-8'` 
>
> ���˼·:
>
> - 1.������ѭ������Ķ�Դ���ԭ��,�����Զ���һ����ȥ�̳� ���������, ��������������`charset` ����.
> - 2.Сtips: Pycharm�� `copy reference `
> - 3.��ȥ�޸����õĲ���



### �������л���һ����Ҫ��ͼƬ

> ![1536395765519](C:\Users\XIEG2\AppData\Local\Temp\1536395765519.png)
>
>  ע:.........









python ǿ����\��̬\����������

       	1. ǿ����: ��ͬ�������Ͳ��ܽ����������;
       	2. ��̬:�������ź��渳ֵ�Ĳ�ͬ���Ա任����;   --> java ��̬����
       	3. ����������



DjangoУ���ʱ�򣬴���`��ʽת��` , �����������ַ��������Զ�ת��������; ���һ����Զ����һЩ��������. У������������ֵ��ʽ:

> ![1536240743326](C:\Users\XIEG2\AppData\Local\Temp\1536240743326.png)





Сϸ��: ��url�д��ݲ���`pk` ʱ, �����ָ�� `?P=` ��ô���ݵ� `*args`  ; ���ָ�����ݵ� `**kwargs` ,����ڲ���������ʱ��,���ܻ���Ӱ��.



���л�������ϸ��:

> ![1536241469254](C:\Users\XIEG2\AppData\Local\Temp\1536241469254.png)
>
> ����, Response �� data ���Ե��� request.data,  s.valided_data, s.data  ��һ��









request.user   ��request������֮һ

��ѯ�� �Ƕ��Ե� ,���Խ�Լ ���ݿ���Դ; ֻ����`ʹ��(����, ȡֵ��)`��ʱ��Żᷢ��`��ѯ` 

������ json������  =None







<u>���� �������Accept����ͷ �� Content-Typeͷ , �Լ���$.Ajax��`dataType` �� `contentType` �Ĺ�ϵ:</u>

> Accept: ����(���Ͷ�|�ͻ���)ϣ�����յ���������;
>
> Content-Type: ����(���Ͷ�|������)���͵� ʵ�����ݵ���������
>
> **$.Ajax()**
>
> dataType:  Ԥ�ڷ��������ص���������;
>
> contentType: ������Ϣ��������ʱ���ݱ�������
>
> **<u>�ܽ�:contentType�����͵���������; Accept��dataType�����������յ���������</u>**



<u>С����</u>:

- 1.����ָ����ʾ��,���㿪��:

(û����ʾ��ԭ����: Pycharm��֪���䷵��ֵ��ʲô����,���Բ�֪�������ʾ...)

> ```python
> @action(methods=['get'], detail=False)
> def latest(self, request):
>     raise DatabaseError()
>     book = BookInfo.objects.latest('id')
>     serializer = self.get_serializer(book)  # 
>     serializer.is_invid(raise_exception=True)  # û����ʾ��Ϣ, ȥԴ����get_serializer��������(ð�ŵ�ǰ��)ָ��" -> Serializer "
>     return Response(serializer.data)
> ```
>
> ![1536365781780](C:\Users\XIEG2\AppData\Local\Temp\1536365781780.png)
>
>  ע: Ҫ�����������浼��: <u>from rest_framework import serializers</u>
>
> ![1536371498532](C:\Users\XIEG2\AppData\Local\Temp\1536371498532.png)
>
> ע: ������� ���� ����дrequest: Request



- 2.Pycharm ����:   Copy Reference  �����Զ���ĳ��py�ļ��е� �� �� ���� ������·������; ����������λ�õ��õ�ʱ�� �� ����ȫ������ ���Խ�����д�����ĳ������.
- 3.��������:  ��app�е�����ʱ��,������ǵ��� views ���ܷ�����ͻ   ==>> ���˼·: views as fxviews  `����`
- 4.��������:

> ![1536372401010](C:\Users\XIEG2\AppData\Local\Temp\1536372401010.png)
>
> ![1536372464103](C:\Users\XIEG2\AppData\Local\Temp\1536372464103.png)
>
> ![1536372571087](C:\Users\XIEG2\AppData\Local\Temp\1536372571087.png)



��������:

Ԫ���б�   �ɵ���   ����Ԫ��             ��������

���ݵ�����: Django �� rest_frame������ 



��ħ��������װ���� ԭ��?

csrf���֮����α�֤��ȫ?     �������,���������Ŀ�г���

�������ͷ������

setattr

hasattr

getattr



### ��һ���Լ�д��Դ��:

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
># ��������ʽ: get post put patch delete  ��û��
># ���� ����   retrieve  list   create  update  partial_update  destroy
># ȥ�޸�url;  ͬʱ����������дdispatch����
># ע���:���뵼��ViewSetMixin�������仹Ҫע�⣺��λ�ñ����� GenericAPIView ֮ǰ,��Ϊ����д dispatch����, ��������ȵ��� GenericAPIView��dispatch����
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
>        instance.delete()  # ����Ҫ�������л���
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
>        instance.delete()  # ����Ҫ�������л���
>        return Response(status=204)
>
>    def get_object(self):
>        try:
>            return BookInfo.objects.all().filter(pk=self.kwargs['pk']).get()
>        except BookInfo.DoesNotExist:
>            raise Http404('ͼ�鲻����')
>"""
>
>```
>
>

