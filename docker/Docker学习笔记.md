## 第一章 Docker概览

### 1.Docker简介

1.1Docker和VMare区别? 为什么有了VMware还要用Docker?

1.2Docker的革命性意义

- 更轻量
- 环境迁移

### 2.Docker整体结构了解



### 3.Docker底层技术了解



### 4.总结



---

```
docker version
sudo service docker start
```



ubuntu下存在`sudo` 权限问题



```
docker search 


Options:
  -f, --filter filter   Filter output based on conditions provided
      --format string   Pretty-print search using a Go template  (利用go的字符串)
      --limit int       Max number of search results (default 25)
      --no-trunc        Don't truncate output

命令格式：
	docker search [OPTIONS] TERM
命令参数(OPTIONS)：
	-f,  --filter filter   	根据提供的格式筛选结果
	     --format string   	利用Go语言的format格式化输出结果
	     --limit int       	展示最大的结果数，默认25个  (顺序:limit>filter)
	     --no-trunc        	内容全部显示
      

```

```shell
docker search centos # 通过镜像名进行搜索, 支持名字模糊搜索, 写cen 也可以搜索到 centos

docker search -f is-official=true cent

docker search -f is-official=true --limit 3 redis

docker search --no-trunc centos
```

![docker-search命令的演示](docker_img\docker-search.png)





#### 镜像查看

docker images  或 docker image ls

```shell
作用：
	列出本地镜像
命令格式：
	docker images [OPTIONS] [REPOSITORY[:TAG]]  
     或者  docker image ls [OPTIONS] [REPOSITORY[:TAG]]
命令参数(OPTIONS)：	
	-a, --all             		展示所有镜像 (默认隐藏底层的镜像)
	     --no-trunc        	不缩略显示
	-q, --quiet           	只显示镜像ID
```

![docker-images](docker_img/docker-images.png)



#### 镜像下载  docker pull

```shell
推荐:  docker pull -h  去查看其用法

docker pull [OPTIONS] NAME[:TAG|@DIGEST]

docker pull centos  默认 是 下载 latest  
docker pull centos:7

dockr pull ubuntu:16  是没法搜索到的,需要使用  16.04 这样完整的版本号

其实上是根据  IMAGE ID 来进行判断是否下载的, 如果在本地中有目标ID 那么不会下载, 只在本地进行引用
这个在删除的时候可以体现出来
```



#### 镜像删除  docker rmi  或 docker image rm

```
作用：
	将本地的一个或多个镜像删除  (通过名字和id都可以删除)
命令格式：
	docker rmi [OPTIONS] IMAGE [IMAGE...]
     或者  docker image rm [OPTIONS] IMAGE [IMAGE...]
命令参数(OPTIONS)：	
	-f, --force      		强制删除  (用于在本地已经创建了容器的镜像)
```

```shell
#展示两次删除的区别: 
# 第一次删除了引用
# 第二次彻底删除了文件
[root@izuf6csxy0jrgs3azvia67z ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              16.04               7e87e2b3bf7a        6 weeks ago         117MB
ubuntu              14.04               5dbc3f318ea5        6 weeks ago         188MB
centos              7                   1e1148e4cc2c        3 months ago        202MB
centos              latest              1e1148e4cc2c        3 months ago        202MB
[root@izuf6csxy0jrgs3azvia67z ~]# docker rmi centos:7
Untagged: centos:7
[root@izuf6csxy0jrgs3azvia67z ~]# docker rmi centos
Untagged: centos:latest
Untagged: centos@sha256:184e5f35598e333bfa7de10d8fb1cebb5ee4df5bc0f970bf2b1e7c7345136426
Deleted: sha256:1e1148e4cc2c148c6890a18e3b2d2dde41a6745ceb4e5fe94a923d811bf82ddb
Deleted: sha256:071d8bd765171080d01682844524be57ac9883e53079b6ac66707e192ea25956
```

```shell
#展示两个镜像是同一个ID的时候, 不能通过ID 去进行删除
[root@izuf6csxy0jrgs3azvia67z ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              16.04               7e87e2b3bf7a        6 weeks ago         117MB
ubuntu              14.04               5dbc3f318ea5        6 weeks ago         188MB
centos              7                   1e1148e4cc2c        3 months ago        202MB
centos              latest              1e1148e4cc2c        3 months ago        202MB
[root@izuf6csxy0jrgs3azvia67z ~]# docker rmi 1e11
Error response from daemon: conflict: unable to delete 1e1148e4cc2c (must be forced) - image is referenced in multiple repositories

---------------------------------
[root@izuf6csxy0jrgs3azvia67z ~]# docker rmi centos
Untagged: centos:latest
[root@izuf6csxy0jrgs3azvia67z ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              16.04               7e87e2b3bf7a        6 weeks ago         117MB
ubuntu              14.04               5dbc3f318ea5        6 weeks ago         188MB
centos              7                   1e1148e4cc2c        3 months ago        202MB
[root@izuf6csxy0jrgs3azvia67z ~]# docker rmi 1e11
Untagged: centos:7
Untagged: centos@sha256:184e5f35598e333bfa7de10d8fb1cebb5ee4df5bc0f970bf2b1e7c7345136426
Deleted: sha256:1e1148e4cc2c148c6890a18e3b2d2dde41a6745ceb4e5fe94a923d811bf82ddb
Deleted: sha256:071d8bd765171080d01682844524be57ac9883e53079b6ac66707e192ea25956
```



#### 镜像保存备份 docker save  (强烈推荐要加上版本号)

```
作用：
	将本地的一个或多个镜像打包保存成本地tar文件(输出到STDOUT)  (标准输出流,所以需重定向到 xx.tar文件)
命令格式：
	docker save [OPTIONS] IMAGE [IMAGE...]   (一个或多个同时操作, 借助名字或id均可)
命令参数(OPTIONS)：	
	-o, --output string   		指定写入的文件名和路径

```



```shell
#可以使用Name或ID来标记镜像
#会提示使用 -o 或者 > 来进行保存成文件
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              latest              47b19964fb50        4 weeks ago         88.1MB
ubuntu              16.04               7e87e2b3bf7a        6 weeks ago         117MB
ubuntu              14.04               5dbc3f318ea5        6 weeks ago         188MB
centos              7                   1e1148e4cc2c        3 months ago        202MB
centos              latest              1e1148e4cc2c        3 months ago        202MB
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker save centos ubuntu:14.04 47b1 centos:7
cowardly refusing to save to a terminal. Use the -o flag or redirect
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker save centos ubuntu:14.04 47b1 centos:7 > linux.tar
[root@izuf6csxy0jrgs3azvia67z docker_demo]# ll
total 486424
-rw-r--r-- 1 root root 498098176 Mar 10 11:52 linux.tar
[root@izuf6csxy0jrgs3azvia67z docker_demo]# ll
-rw-r--r-- 1 root root 498098176 Mar 10 11:52 linux.tar
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker save centos ubuntu:14.04 47b1 centos:7 -o linux2.tar
[root@izuf6csxy0jrgs3azvia67z docker_demo]# ll
-rw------- 1 root root 498098176 Mar 10 11:54 linux2.tar
-rw-r--r-- 1 root root 498098176 Mar 10 11:52 linux.tar
```



#### 镜像备份导入 docker load

```
作用：
	将save命令打包的镜像导入本地镜像库中
命令格式：
	docker load [OPTIONS]
命令参数(OPTIONS)：	
	-i,  --input string   	指定要打入的文件，如没有指定，默认是STDIN
	-q, --quiet          		不打印导入过程信息
```

```shell
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker rmi ubuntu:latest 7e87 5dbc 
....省略控制台输出...
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker load -h
Flag shorthand -h has been deprecated, please use --help

Usage:	docker load [OPTIONS]

Load an image from a tar archive or STDIN

Options:
  -i, --input string   Read from tar archive file, instead of STDIN
  -q, --quiet          Suppress the load output
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker load -i linux.tar 
....省略控制台输出...
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
<none>              <none>              47b19964fb50        4 weeks ago         88.1MB
ubuntu              14.04               5dbc3f318ea5        6 weeks ago         188MB
centos              7                   1e1148e4cc2c        3 months ago        202MB
centos              latest              1e1148e4cc2c        3 months ago        202MB
# 发现存在问题, 经过执行 docker save centos ubuntu:14.04 47b1 centos:7 > linux.tar 
# 对应的ubuntu latest 的REPOSITORY和TAG都变成<none>了. 和我们打包备份的时候没有指定版本号有关, 这里需要注意.
```

#### 镜像重命名 docker tag

```
作用：
	对本地镜像的NAME、TAG进行重命名，并新产生一个命名后镜像
命令格式：
	docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
命令参数(OPTIONS)：	
	无
```

```shell
#事实上这是一个重命名的命令, 这里会增加一个引用, 并不会修改原来的.
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
<none>              <none>              47b19964fb50        4 weeks ago         88.1MB
ubuntu              14.04               5dbc3f318ea5        6 weeks ago         188MB
centos              7                   1e1148e4cc2c        3 months ago        202MB
centos              latest              1e1148e4cc2c        3 months ago        202MB
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker tag -h
Flag shorthand -h has been deprecated, please use --help

Usage:	docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker tag centos:7 centos:7.4
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
<none>              <none>              47b19964fb50        4 weeks ago         88.1MB
ubuntu              14.04               5dbc3f318ea5        6 weeks ago         188MB
centos              7                   1e1148e4cc2c        3 months ago        202MB
centos              7.4                 1e1148e4cc2c        3 months ago        202MB
centos              latest              1e1148e4cc2c        3 months ago        202MB

------------------------------------------------------------------------
#但是如果是<none>的情况, 相当于存在一个没有标签的镜像, 然后重命名之后就变成默认的镜像
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker tag 47b1 ubuntu:latest
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              latest              47b19964fb50        4 weeks ago         88.1MB
ubuntu              14.04               5dbc3f318ea5        6 weeks ago         188MB
centos              7                   1e1148e4cc2c        3 months ago        202MB
centos              7.4                 1e1148e4cc2c        3 months ago        202MB
centos              latest              1e1148e4cc2c        3 months ago        202MB
```



#### 镜像详细信息 docker image inspect/docker inspect

```
作用：
	查看本地一个或多个镜像的详细信息
命令格式：
	docker image inspect [OPTIONS] IMAGE [IMAGE...]
      或者 docker inspect [OPTIONS] IMAGE [IMAGE...]
命令参数(OPTIONS)：	
	-f, --format string          利用特定Go语言的format格式输出结果
```

```shell
#查出来的是json字符串
#固定语法

[root@izuf6csxy0jrgs3azvia67z ~]# docker image inspect centos
[
    {
        "Id": "sha256:1e1148e4cc2c148c6890a18e3b2d2dde41a6745ceb4e5fe94a923d811bf82ddb",
        "RepoTags": [
            "centos:7",
            "centos:7.4",
            "centos:latest"
        ],
        "RepoDigests": [],
        "Parent": "",
        "Comment": "",
        "Created": "2018-12-06T00:21:07.135655444Z",
        "Container": "1fdbb0fcc184eb795364f7aa5fdc00299d0a2b90d8e26b4696217c22da7f983f",
        "ContainerConfig": {
            "Hostname": "1fdbb0fcc184",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "#(nop) ",
                "CMD [\"/bin/bash\"]"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:b3a68d99a4a4195c6c97c2345b83cb2d6cfd1661247816ac403cf0b584437ad7",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {
                "org.label-schema.build-date": "20181205",
                "org.label-schema.license": "GPLv2",
                "org.label-schema.name": "CentOS Base Image",
                "org.label-schema.schema-version": "1.0",
                "org.label-schema.vendor": "CentOS"
            }
        },
        "DockerVersion": "17.06.2-ce",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/bash"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:b3a68d99a4a4195c6c97c2345b83cb2d6cfd1661247816ac403cf0b584437ad7",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {
                "org.label-schema.build-date": "20181205",
                "org.label-schema.license": "GPLv2",
                "org.label-schema.name": "CentOS Base Image",
                "org.label-schema.schema-version": "1.0",
                "org.label-schema.vendor": "CentOS"
            }
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 201779604,
        "VirtualSize": 201779604,
        "GraphDriver": {
            "Data": {
                "MergedDir": "/var/lib/docker/overlay2/6099b0dfde447cd9b332ac2c0e1cb7d660572a9d8a31a988e1db8d253e717d00/merged",
                "UpperDir": "/var/lib/docker/overlay2/6099b0dfde447cd9b332ac2c0e1cb7d660572a9d8a31a988e1db8d253e717d00/diff",
                "WorkDir": "/var/lib/docker/overlay2/6099b0dfde447cd9b332ac2c0e1cb7d660572a9d8a31a988e1db8d253e717d00/work"
            },
            "Name": "overlay2"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:071d8bd765171080d01682844524be57ac9883e53079b6ac66707e192ea25956"
            ]
        },
        "Metadata": {
            "LastTagTime": "2019-03-10T12:15:26.0800718+08:00"
        }
    }
]

#上面的信息量太大, 我们可以针对性的查看部分
[root@izuf6csxy0jrgs3azvia67z ~]# docker inspect centos | grep Created
        "Created": "2018-12-06T00:21:07.135655444Z",
# 存在问题: 显示的只有当前行
[root@izuf6csxy0jrgs3azvia67z ~]# docker inspect centos | grep Data
            "Data": {
#解决办法: 使用固定的go语法
[root@izuf6csxy0jrgs3azvia67z ~]# docker inspect -f "{{json .Id}}" centos
"sha256:1e1148e4cc2c148c6890a18e3b2d2dde41a6745ceb4e5fe94a923d811bf82ddb"
# 其中的 点 表示第一层
[root@izuf6csxy0jrgs3azvia67z ~]# docker inspect -f "{{json .GraphDriver.Data}}" centos
{"MergedDir":"/var/lib/docker/overlay2/6099b0dfde447cd9b332ac2c0e1cb7d660572a9d8a31a988e1db8d253e717d00/merged","UpperDir":"/var/lib/docker/overlay2/6099b0dfde447cd9b332ac2c0e1cb7d660572a9d8a31a988e1db8d253e717d00/diff","WorkDir":"/var/lib/docker/overlay2/6099b0dfde447cd9b332ac2c0e1cb7d660572a9d8a31a988e1db8d253e717d00/work"}

#补充: 
docker image inspect -h 和 docker inspect -h  不同, 一个只针对image, 一个是针对docker 对象, 也就是说还包括 容器,网络,数据卷等

```



#### 镜像历史信息  docker history

```
作用：
	查看本地一个镜像的历史(历史分层)信息
命令格式：
	docker history [OPTIONS] IMAGE
命令参数(OPTIONS)：
	-H, --human		将创建时间、大小进行优化打印(默认为true)
	-q, --quiet           	只显示镜像ID
	     --no-trunc        	不缩略显示
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker history centos
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
1e1148e4cc2c        3 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B                  
<missing>           3 months ago        /bin/sh -c #(nop)  LABEL org.label-schema.sc…   0B                  
<missing>           3 months ago        /bin/sh -c #(nop) ADD file:6f877549795f4798a…   202MB 
```



### 第四章 容器 -- 打包技术

关闭

```
service docker stop
reboot now 
# 这两种方式都会将 所有的运行的容器关闭掉
```

#### 容器创建 docker create

```
作用：
	利用镜像创建出一个Created 状态的待启动容器
命令格式：
	docker create [OPTIONS] IMAGE [COMMAND] [ARG...]
命令参数(OPTIONS)：
	-t, --tty           		分配一个伪TTY，也就是分配虚拟终端
    -i, --interactive    	即使没有连接，也要保持STDIN打开
    --name          		为容器起名，如果没有指定将会随机产生一个名称
命令参数（COMMAND\ARG）:
	COMMAND 表示容器启动后，需要在容器中执行的命令，如ps、ls 等命令
	ARG 表示执行 COMMAND 时需要提供的一些参数，如ps 命令的 aux、ls命令的-a等等
-------------------
补充:
docker create --help 查看帮助信息, 不能使用 -h , 因为这里的-h已经作为它用. 类似的还有其他的.
[COMMAND] 用于创建容器带有的命令, 如yum , apt-get ls 等
[ARG]  用于对 [COMMAND] 传递参数  比如  ls -alh
当然, COMMAND其有默认值:   /bin/bash 或其它
```

```shell
[root@izuf6csxy0jrgs3azvia67z docker]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[root@izuf6csxy0jrgs3azvia67z docker]# docker create centos ls -a
8a6a45f9a0d0b8a2590264af688684b4269066ffaafc8fdf8e6a116166d3e66f
[root@izuf6csxy0jrgs3azvia67z docker]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[root@izuf6csxy0jrgs3azvia67z docker]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
8a6a45f9a0d0        centos              "ls -a"             18 seconds ago      Created                                 stupefied_lichterman
# docker ps 默认不显示  created状态的 容器. 如果要显示需要加 参数 -a
# 如果使用[COMMAND]选项, 那么会覆盖默认的 /bin/bash 命令
[root@izuf6csxy0jrgs3azvia67z docker]# docker create centos 
901eec029d7ea5b1f2687334c49c40c59959a8a1a200c0f8aefbd8b7efce81cb
[root@izuf6csxy0jrgs3azvia67z docker]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[root@izuf6csxy0jrgs3azvia67z docker]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
901eec029d7e        centos              "/bin/bash"         7 seconds ago       Created                                 flamboyant_bartik
8a6a45f9a0d0        centos              "ls -a"             2 minutes ago       Created                                 stupefied_lichterman

# PORTS 选项标记的是端口映射
# NAMES 会给创建的容器生成一个默认的名字, 当然也可以通过 --name 选项来指定名字
[root@izuf6csxy0jrgs3azvia67z docker]# docker create --name centos-test centos
ba1085bfe9f0ff8a00b2e06a4eb4f62f4b171d695ee865d4a92600ef2b921617
[root@izuf6csxy0jrgs3azvia67z docker]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
ba1085bfe9f0        centos              "/bin/bash"         3 seconds ago        Created                                 centos-test
901eec029d7e        centos              "/bin/bash"         About a minute ago   Created                                 flamboyant_bartik
8a6a45f9a0d0        centos              "ls -a"             3 minutes ago        Created                                 stupefied_lichterman

# 分配
```

#### 容器启动 docker start

```shell
#COMMAND默认值, 会在每次启动该容器的时候都会执行一次. 
#但是要显示需要通过 -a 参数来实现
[root@izuf6csxy0jrgs3azvia67z ~]# docker start 6137
6137
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
61374d7c1f72        centos              "ls -a"             53 seconds ago      Exited (0) 8 seconds ago                       centos-test

[root@izuf6csxy0jrgs3azvia67z ~]# docker start -a 6137
.
..
.dockerenv
anaconda-post.log
bin
dev
etc
home
lib
lib64
media
mnt
...

#类似Python这种命令执行需要 虚拟一个终端, 同时还要有标准输入和输出才能展示出来.
#在控制台直接输入Python的时候是有输出的.
#所以, 创建的时候需要 -t 才能分配 虚拟终端, -i 才能提供标准输入, 这两者都具备才能运行 python

# 所以, start python的时候, 也需要 有标准输出和输入. 所以需要  -a 和 -i 参数

[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
61374d7c1f72        centos              "ls -a"             7 minutes ago       Exited (0) 4 minutes ago                       centos-test
[root@izuf6csxy0jrgs3azvia67z ~]# docker create --name python centos python
1d270adb44c8be96bacb5d17d44922e51bc8d984a5fac3afd7a118a3fcfcae27
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
1d270adb44c8        centos              "python"            4 seconds ago       Created                                        python
61374d7c1f72        centos              "ls -a"             8 minutes ago       Exited (0) 5 minutes ago                       centos-test
[root@izuf6csxy0jrgs3azvia67z ~]# docker start 1d27
1d27
[root@izuf6csxy0jrgs3azvia67z ~]# python
Python 2.7.5 (default, Oct 30 2018, 23:45:53) 
[GCC 4.8.5 20150623 (Red Hat 4.8.5-36)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> quit()
[root@izuf6csxy0jrgs3azvia67z ~]# docker start -a python
[root@izuf6csxy0jrgs3azvia67z ~]# docker create -ti --name python-new centos python
e4c60ba568f333b1015f05413c9ae7d0e4ac94931497b12d97210a5db9a2ff6c
[root@izuf6csxy0jrgs3azvia67z ~]# docker start -a python-new
Python 2.7.5 (default, Oct 30 2018, 23:45:53) 
[GCC 4.8.5 20150623 (Red Hat 4.8.5-36)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> quit

quit
^C
[root@izuf6csxy0jrgs3azvia67z ~]# docker start --help

Usage:	docker start [OPTIONS] CONTAINER [CONTAINER...]

Start one or more stopped containers

Options:
  -a, --attach               Attach STDOUT/STDERR and forward signals
      --detach-keys string   Override the key sequence for detaching a container
  -i, --interactive          Attach container's STDIN
[root@izuf6csxy0jrgs3azvia67z ~]# docker start -ai python-new
import os
>>> import os
>>> os.dir(".")
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: 'module' object has no attribute 'dir'
>>> quit()
```

#### 容器创建并启动 docker run

```
作用：
	利用镜像创建并启动一个容器
命令格式：
	docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
命令参数(OPTIONS)：查看更多
	-t, --tty           		分配一个伪TTY，也就是分配虚拟终端
    -i, --interactive    	    即使没有连接，也要保持STDIN打开
    --name          			为容器起名，如果没有指定将会随机产生一个名称
	-d, --detach				在后台运行容器并打印出容器ID
	--rm						当容器退出运行后，自动删除容器
命令参数（COMMAND\ARG）:
	COMMAND 表示容器启动后，需要在容器中执行的命令，如ps、ls 等命令
	ARG 表示执行 COMMAND 时需要提供的一些参数，如ps 命令的 aux、ls命令的-a等等

```

```shell
docker run <=> docker create + docker start -a   前台模式
docker run -d <=> docker create + docker start    后台模式
```

#### 容器关闭 docker stop

```
补充
docker run -dti --rm centos bash
# 那么当 stop 或 kill 掉容器的时候, 那么容器会被自动删除
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker stop -h
Flag shorthand -h has been deprecated, please use --help

Usage:	docker stop [OPTIONS] CONTAINER [CONTAINER...]

Stop one or more running containers

Options:
  -t, --time int   Seconds to wait for stop before killing it (default 10)

# 如果不使用 -d 在后台运行, 那么虽然 Python可以起到阻塞作用, 但是一旦 Ctrl+D 退出或 quit()退出之后. 
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[root@izuf6csxy0jrgs3azvia67z ~]# docker run -ti centos python
Python 2.7.5 (default, Oct 30 2018, 23:45:53) 
[GCC 4.8.5 20150623 (Red Hat 4.8.5-36)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>>    
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
f71a5c68f152        centos              "python"            11 seconds ago      Exited (0) 6 seconds ago                       kind_goldwasser
[root@izuf6csxy0jrgs3azvia67z ~]# docker run -dti centos python
f8b7611d03b80c7709306035e4df0b87c63b8fbf9e1c0cb59fa9b62dbb133600
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
f8b7611d03b8        centos              "python"            3 minutes ago       Up 3 minutes                                   nervous_wiles
f71a5c68f152        centos              "python"            4 minutes ago       Exited (0) 4 minutes ago                       kind_goldwasser
```

#### 容器终止  docker kill 

```
作用：
	强制并立即关闭一个或多个处于暂停状态或者运行状态的容器
命令格式：
	docker kill [OPTIONS] CONTAINER [CONTAINER...]
命令参数(OPTIONS)：
	-s, --signal string   	指定发送给容器的关闭信号 (默认“KILL”信号)
```

> 补充
>
> ```shell
> # 使用kill的时候默认发送的是 15)SIGTERM  ;    (通知即将关掉 ,  给时间回收一下内存等)
> # 使用kill -9 是发送 9)SIGKILL
> [root@izuf6csxy0jrgs3azvia67z docker_demo]# kill -l
>  1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
>  6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
> 11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
> 16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
> 21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
> 26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
> 31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
> 38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
> 43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
> 48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
> 53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
> 58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
> 63) SIGRTMAX-1	64) SIGRTMAX
> ```

```shell
前提知识点：
Linux其中两种终止进程的信号是：SIGTERM和SIGKILL
SIGKILL信号：无条件终止进程信号。进程接收到该信号会立即终止，不进行清理和暂存工作。该信号不能被忽略、处理和阻塞，它向系统管理员提供了可以杀死任何进程的方法。
SIGTERM信号：程序终结信号，可以由kill命令产生。与SIGKILL不同的是，SIGTERM信号可以被阻塞和终止，以便程序在退出前可以保存工作或清理临时文件等。

docker stop 会先发出SIGTERM信号给进程，告诉进程即将会被关闭。在-t指定的等待时间过了之后，将会立即发出SIGKILL信号，直接关闭容器。
docker kill 直接发出SIGKILL信号关闭容器。但也可以通过-s参数修改发出的信号。

因此会发现在docker stop的等过过程中，如果终止docker stop的执行，容器最终没有被关闭。而docker kill几乎是立刻发生，无法撤销。

此外还有些异常原因也会导致容器被关闭，比如docker daemon重启、容器内部进程运行发生错误等等“异常原因”。
```

#### 容器暂停  docker pause

```
作用：
	暂停一个或多个处于运行状态的容器
命令格式：
	docker pause CONTAINER [CONTAINER...]
命令参数(OPTIONS)：
	无	
```

*注: 涨停也是一个特殊的运行状态*

#### 容器取消暂停 docker unpause

```
作用：
	取消一个或多个处于暂停状态的容器，恢复运行
命令格式：
	docker unpause CONTAINER [CONTAINER...]		
命令参数(OPTIONS)：
	无
```

*注: 暂停和取消暂停 都是只能运行一次, 重复运行会报错*

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                  PORTS               NAMES
f8b7611d03b8        centos              "python"            2 days ago          Up 10 hours (Paused)                        nervous_wiles
f71a5c68f152        centos              "python"            2 days ago          Exited (0) 2 days ago                       kind_goldwasser
[root@izuf6csxy0jrgs3azvia67z ~]# docker pause f8b7
Error response from daemon: Container f8b7611d03b80c7709306035e4df0b87c63b8fbf9e1c0cb59fa9b62dbb133600 is already paused
```



#### 容器重启

```
作用：
	重启一个或多个处于运行状态、暂停状态、关闭状态或者新建状态的容器
	该命令相当于stop和start命令的结合
命令格式：
	docker restart [OPTIONS] CONTAINER [CONTAINER...]
命令参数(OPTIONS)：
	 -t, --time int   		重启前，等待的时间，单位秒(默认 10s) 
				实则是关闭前等待的时间	
```

```shell
docker restart <=> docker stop + docker start
```



#### 容器的详细信息

```
作用：
	查看本地一个或多个容器的详细信息
命令格式：
	docker container inspect [OPTIONS] CONTAINER [CONTAINER...]
      或者 docker inspect [OPTIONS] CONTAINER [CONTAINER...]
命令参数(OPTIONS)：	
	-f, --format string	利用特定Go语言的format格式输出结果
	-s, --size		显示总大小
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker inspect f8
[
    {
        "Id": "f8b7611d03b80c7709306035e4df0b87c63b8fbf9e1c0cb59fa9b62dbb133600",
        "Created": "2019-03-10T13:27:48.925737681Z",
        "Path": "python",
        "Args": [],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 13875,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2019-03-12T03:57:58.638030916Z",
            "FinishedAt": "2019-03-12T03:55:10.114967417Z"
        },
        "Image": "sha256:1e1148e4cc2c148c6890a18e3b2d2dde41a6745ceb4e5fe94a923d811bf82ddb",
...
...
...
State还可查看容器的状态
[root@izuf6csxy0jrgs3azvia67z ~]# docker inspect -f "{{json .State.Running}}" f8
true
```

#### 容器日志 docker logs

```

```

```shell
#显示的是   容器 COMMAND 产生的一些结果
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                  PORTS               NAMES
1d3f38d39a95        centos              "python"            3 minutes ago       Up 3 minutes                                dreamy_lovelace
f8b7611d03b8        centos              "python"            2 days ago          Up 10 hours                                 nervous_wiles
f71a5c68f152        centos              "python"            2 days ago          Exited (0) 2 days ago                       kind_goldwasser
[root@izuf6csxy0jrgs3azvia67z ~]# docker logs 1d
Python 2.7.5 (default, Oct 30 2018, 23:45:53) 
[GCC 4.8.5 20150623 (Red Hat 4.8.5-36)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
```

#### 容器重命名 docker rename

```
作用：
	修改容器的名称
命令格式：
	docker rename CONTAINER NEW_NAME
命令参数(OPTIONS)：	
	无
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                  PORTS               NAMES
1d3f38d39a95        centos              "python"            About an hour ago   Up About an hour                            dreamy_lovelace
f8b7611d03b8        centos              "python"            2 days ago          Up 12 hours                                 nervous_wiles
f71a5c68f152        centos              "python"            2 days ago          Exited (0) 2 days ago                       kind_goldwasser
[root@izuf6csxy0jrgs3azvia67z ~]# docker rename 1d This
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                  PORTS               NAMES
1d3f38d39a95        centos              "python"            About an hour ago   Up About an hour                            This
f8b7611d03b8        centos              "python"            2 days ago          Up 12 hours                                 nervous_wiles
f71a5c68f152        centos              "python"            2 days ago          Exited (0) 2 days ago                       kind_goldwasser
```

#### 容器连接 docker attach

```
作用：
	将当前终端的STDIN、STDOUT、STDERR绑定到正在运行的容器的主进程上实现连接
命令格式：
	docker attach [OPTIONS] CONTAINER
命令参数(OPTIONS)：	
	--no-stdin             	不绑定STDIN
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[root@izuf6csxy0jrgs3azvia67z ~]# docker run -dti centos bash
6113fc2dd14a609a8dff44a3a363037a1ea45ecd5173fc8c88d26a66d3c55cf3
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
6113fc2dd14a        centos              "bash"              4 seconds ago       Up 4 seconds                            adoring_blackwell
[root@izuf6csxy0jrgs3azvia67z ~]# docker attach 611
#两次ps的的PID不同, 之前的ps -A执行结束, 所以第二次的ps就有新的PID
[root@6113fc2dd14a /]# ps -A
  PID TTY          TIME CMD
    1 pts/0    00:00:00 bash
   15 pts/0    00:00:00 ps
[root@6113fc2dd14a /]# ps -A
  PID TTY          TIME CMD
    1 pts/0    00:00:00 bash
   16 pts/0    00:00:00 ps

#这里如果退出, 那么相应的也会退出该容器, 容器则变成关闭状态.
[root@6113fc2dd14a /]# exit
exit
#想要再次连接则会报错:
[root@izuf6csxy0jrgs3azvia67z ~]# docker attach 611
You cannot attach to a stopped container, start it first
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
6113fc2dd14a        centos              "bash"              6 minutes ago       Exited (0) 2 minutes ago                       adoring_blackwel
#而attach必须是 运行中的容器, 所以 需要先启动
#进入Python终端
[root@izuf6csxy0jrgs3azvia67z ~]# docker run -dti centos python
e964d014521a36cb229e5e21dda0686a4cfed7e394509f45fe8989aac23c7cdc
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a 
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
e964d014521a        centos              "python"            About a minute ago   Up About a minute                       friendly_mirzakhani
6113fc2dd14a        centos              "bash"              14 minutes ago       Up About a minute                       adoring_blackwell
[root@izuf6csxy0jrgs3azvia67z ~]# docker attach e96
>>> print("hello world")
hello world
>>> quit()
```

```shell
#attach 把当前终端的 标准输入, 标准输入, 标准错误流 和 当前容器终端的主进程联系起来. 即PID=1 的进程.
#所以当attach之后会执行 COMMAND 命令, 该命令执行完, 则终端退出.
```

#### 容器中执行新命令  docker exec

```
作用：
	在容器中运行一个命令
命令格式：
	docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
命令参数(OPTIONS)：	
	-d, --detach               	后台运行命令
	-i, --interactive		即使没连接容器，也将当前的STDIN绑定上
	-t, --tty                  	分配一个虚拟终端
	-w, --workdir string       	指定在容器中的工作目录
	-e, --env list             	设置容器中运行时的环境变量
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[root@izuf6csxy0jrgs3azvia67z ~]# docker run -dti centos python
f73f3758588ba82728a3b7645b1eed3e648ce5b110eeec19b548db909fa04ad6
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
f73f3758588b        centos              "python"            9 seconds ago       Up 8 seconds                            modest_goldberg
[root@izuf6csxy0jrgs3azvia67z ~]# docker exec f7 ps -A
  PID TTY          TIME CMD
    1 pts/0    00:00:00 python
    6 ?        00:00:00 ps
[root@izuf6csxy0jrgs3azvia67z ~]# docker exec f7 ps -A
  PID TTY          TIME CMD
    1 pts/0    00:00:00 python
   11 ?        00:00:00 ps
[root@izuf6csxy0jrgs3azvia67z ~]# docker exec f7 python
[root@izuf6csxy0jrgs3azvia67z ~]# docker exec -ti f7 python
Python 2.7.5 (default, Oct 30 2018, 23:45:53) 
[GCC 4.8.5 20150623 (Red Hat 4.8.5-36)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> quit()
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
f73f3758588b        centos              "python"            2 minutes ago       Up 2 minutes                            modest_goldberg
```

```
#重点:
#exec  和 attach区别在于不和主进程进行关联, 是以容器子进程的形式存在, 所以其运行不影响容器主进程. 执行结束也不会导致容器直接退出.
而 docker logs 日志打印的只是主进程的日志, exec的日志是没法打印的.
```

### 第五章 容器与镜像

```shell
#引入, centos7的docker镜像默认是没有ifconfig模块,需要安装net-tools工具
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[root@izuf6csxy0jrgs3azvia67z ~]# docker run -dti centos bash
a43634abeb56cd28ad5487807d2ec4aa02ef24a711b8e9c45252614f718c6622
[root@izuf6csxy0jrgs3azvia67z ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
a43634abeb56        centos              "bash"              3 seconds ago       Up 3 seconds                            frosty_mclaren
[root@izuf6csxy0jrgs3azvia67z ~]# docker exec a4 ifconfig
OCI runtime exec failed: exec failed: container_linux.go:344: starting container process caused "exec: \"ifconfig\": executable file not found in $PATH": unknown
[root@izuf6csxy0jrgs3azvia67z ~]# docker exec a4 yum install -y net-tools
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
 * base: mirrors.aliyun.com
 * extras: mirrors.aliyun.com
 * updates: mirrors.aliyun.com
Resolving Dependencies
--> Running transaction check
---> Package net-tools.x86_64 0:2.0-0.24.20131004git.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package         Arch         Version                          Repository  Size
================================================================================
Installing:
 net-tools       x86_64       2.0-0.24.20131004git.el7         base       306 k

Transaction Summary
================================================================================
Install  1 Package

Total download size: 306 k
Installed size: 918 k
Downloading packages:
warning: /var/cache/yum/x86_64/7/base/packages/net-tools-2.0-0.24.20131004git.el7.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY
Public key for net-tools-2.0-0.24.20131004git.el7.x86_64.rpm is not installed
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
Importing GPG key 0xF4A80EB5:
 Userid     : "CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>"
 Fingerprint: 6341 ab27 53d7 8a78 a7c2 7bb1 24c6 a8a7 f4a8 0eb5
 Package    : centos-release-7-6.1810.2.el7.centos.x86_64 (@CentOS)
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : net-tools-2.0-0.24.20131004git.el7.x86_64                    1/1 
  Verifying  : net-tools-2.0-0.24.20131004git.el7.x86_64                    1/1 

Installed:
  net-tools.x86_64 0:2.0-0.24.20131004git.el7                                   

Complete!
[root@izuf6csxy0jrgs3azvia67z ~]# docker exec a4 ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.17.0.2  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:ac:11:00:02  txqueuelen 0  (Ethernet)
        RX packets 1264  bytes 9634846 (9.1 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1037  bytes 67850 (66.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        loop  txqueuelen 1  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```



#### 容器提交 docker  commit

```
作用：
	根据容器生成一个新的镜像(会保留原来容器和对原有容器进行的更改)
命令格式：
	docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
命令参数(OPTIONS)：
	-a, --author string    	作者
	-c, --change list      	为创建的镜像加入Dockerfile命令
	-m, --message string   	提交信息，类似git commit -m
	-p, --pause            	提交时暂停容器 (default true)	
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker commit -m "(export) install net-tools" a436 net-tools:v1.0
sha256:311dc06b53aade01b986b9fdebbabde3de00facfb8633736274911046c108304
[root@izuf6csxy0jrgs3azvia67z ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos-net          v1.0                cf3acaf1acc4        10 hours ago        280MB
centos              latest              1e1148e4cc2c        3 months ago        202MB

```

#### 容器导出  docker export

```
作用：
	将容器当前的文件系统导出成一个tar文件
命令格式：
	docker export [OPTIONS] CONTAINER
命令参数(OPTIONS)：
	-o, --output string   		指定写入的文件，默认是STDOUT	
```

```shell
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker export -o centos-net.tar f825
[root@izuf6csxy0jrgs3azvia67z docker_demo]# ll
total 744844
-rw------- 1 root root 264616960 Mar 13 22:22 centos-net.tar
-rw-r--r-- 1 root root 498098176 Mar 10 11:52 linux.tar
```

#### 容器打包的导入 docker import

```
作用：
	从一个tar文件中导入内容创建一个镜像
命令格式：
	docker import [OPTIONS] file|URL|- [REPOSITORY[:TAG]]
命令参数(OPTIONS)：
	-c, --change list      	为创建的镜像加入Dockerfile命令
	-m, --message string   	导入时，添加提交信息	
```

```shell
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker import -h
Flag shorthand -h has been deprecated, please use --help

Usage:	docker import [OPTIONS] file|URL|- [REPOSITORY[:TAG]]

Import the contents from a tarball to create a filesystem image

Options:
  -c, --change list      Apply Dockerfile instruction to the created image
  -m, --message string   Set commit message for imported image
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker import -m "(export) install net-tools" centos-net.tar centos-net2:v1.0
sha256:c0ff4aa5865696bdd95809180676267f4683029d0dee258a3d2ca45c12a980b8
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos-net2         v1.0                c0ff4aa58656        22 seconds ago      257MB
centos-net          v1.0                cf3acaf1acc4        12 hours ago        280MB
ubuntu              latest              47b19964fb50        5 weeks ago         88.1MB
centos              latest              1e1148e4cc2c        3 months ago        202MB

#docker commit 和 import 的区别:
#commit保留了镜像的详细信息, 用的更多
#import只保留了最后修改的综合的样子
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker history centos
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
1e1148e4cc2c        3 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B                  
<missing>           3 months ago        /bin/sh -c #(nop)  LABEL org.label-schema.sc…   0B                  
<missing>           3 months ago        /bin/sh -c #(nop) ADD file:6f877549795f4798a…   202MB               
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker history centos-net:v1.0
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
cf3acaf1acc4        12 hours ago        bash                                            78.5MB              install net-tools
1e1148e4cc2c        3 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B                  
<missing>           3 months ago        /bin/sh -c #(nop)  LABEL org.label-schema.sc…   0B                  
<missing>           3 months ago        /bin/sh -c #(nop) ADD file:6f877549795f4798a…   202MB               
[root@izuf6csxy0jrgs3azvia67z docker_demo]# docker history centos-net2:v1.0
IMAGE               CREATED             CREATED BY          SIZE                COMMENT
c0ff4aa58656        5 minutes ago                           257MB               (export) install net-tools

```

### 第六章 docker核心技术--网络管理

#### 为什么需要docker网络管理

```
容器的网络默认与宿主机、与其他容器都是相互隔离。
容器中可以运行一些网络应用(如nginx、web应用、数据库等)，如果要让外部也可以访问这些容器内运行的网络应用，那么就需要配置网络来实现。
有可能有的需求下，容器不想让它的网络与宿主机、与其他容器隔离。
有可能有的需求下，容器根本不需要网络。
有可能有的需求下，容器需要更高的定制化网络（如定制特殊的集群网络、定制容器间的局域网）。
有可能有的需求下， 容器数量特别多，体量很大的一系列容器的网络管理如何
……

因此容器的网络管理是非常重要的

------------------
容器网络管理:
- 不设置隔离   => 性能最高
自带5种网络驱动模式
- 可以手动安装别的模式
```



#### docker网络默认5种驱动模式

```
Docker有五种网络驱动模式
bridge network 模式（网桥）：默认的网络模式。类似虚拟机的nat模式
host network 模式（主机）：容器与宿主机之间的网络无隔离，即容器直接使用宿主机网络
None network 模式：容器禁用所有网络。
Overlay network 模式（覆盖网络）： 利用VXLAN实现的bridge模式
Macvlan network 模式：容器具备Mac地址，使其显示为网络上的物理设备
```

#### 查看网络 docker network ls

```
作用：
	查看已经建立的网络对象
命令格式：
	docker network ls [OPTIONS]
命令参数(OPTIONS)：
	-f, --filter filter   		过滤条件(如 'driver=bridge’)
	    --format string   	格式化打印结果
	    --no-trunc        	不缩略显示
	-q, --quiet          	 	只显示网络对象的ID
注意：
	默认情况下，docker安装完成后，会自动创建bridge、host、none三种网络驱动
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
6d052b504ac7        bridge              bridge              local
a468c0a23faf        host                host                local
47d7fe0d3f46        none                null                local
[root@izuf6csxy0jrgs3azvia67z ~]# docker network ls -f 'driver=host'
NETWORK ID          NAME                DRIVER              SCOPE
a468c0a23faf        host                host                local
```



#### 创建网络 docker network

```
作用：
	创建新的网络对象
命令格式：
	docker network create [OPTIONS] NETWORK
命令参数(OPTIONS)：
	-d, --driver string        		指定网络的驱动(默认 "bridge")
	    --subnet strings       		指定子网网段(如192.168.0.0/16、172.88.0.0/24)
	    --ip-range strings     		执行容器的IP范围，格式同subnet参数
	    --gateway strings      		子网的IPv4 or IPv6网关，如(192.168.0.1)
注意：
	host和none模式网络只能存在一个
	docker自带的overlay 网络创建依赖于docker swarm(集群负载均衡)服务
	192.168.0.0/16 等于 192.168.0.0~192.168.255.255    192.168.8.0/24
	172.88.0.0/24 等于 172.88.0.0~172.88.0.255
```



```shell
Create a network

Options:
      --attachable           Enable manual container attachment
      --aux-address map      Auxiliary IPv4 or IPv6 addresses used by Network driver (default map[])
      --config-from string   The network from which copying the configuration
      --config-only          Create a configuration only network
  -d, --driver string        Driver to manage the Network (default "bridge")
      --gateway strings      IPv4 or IPv6 Gateway for the master subnet
      --ingress              Create swarm routing-mesh network
      --internal             Restrict external access to the network
      --ip-range strings     Allocate container ip from a sub-range
      --ipam-driver string   IP Address Management Driver (default "default")
      --ipam-opt map         Set IPAM driver specific options (default map[])
      --ipv6                 Enable IPv6 networking
      --label list           Set metadata on a network
  -o, --opt map              Set driver specific options (default map[])
      --scope string         Control the network's scope
      --subnet strings       Subnet in CIDR format that represents a network segment
[root@izuf6csxy0jrgs3azvia67z ~]# docker network create -d bridge my-bridge
204abef6d8250b2e3d264ff00ca7844a34fb525c9f4bc0d6b609cd5658eb32b0
[root@izuf6csxy0jrgs3azvia67z ~]# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
6d052b504ac7        bridge              bridge              local
a468c0a23faf        host                host                local
204abef6d825        my-bridge           bridge              local
47d7fe0d3f46        none                null                local

# docker默认的是 bridge
[root@izuf6csxy0jrgs3azvia67z ~]# docker network create -d host my-bridge
Error response from daemon: network with name my-bridge already exists
[root@izuf6csxy0jrgs3azvia67z ~]# docker network create -d host my-bridge2
Error response from daemon: only one instance of "host" network is allowed

#依赖集群,需要先启动 swarm
[root@izuf6csxy0jrgs3azvia67z ~]# docker network create -d overlay my-bridge2
Error response from daemon: This node is not a swarm manager. Use "docker swarm init" or "docker swarm join" to connect this node to swarm and try again.

# host 和 null 只能存在一个
[root@izuf6csxy0jrgs3azvia67z ~]# docker network create -d null my-bridge2
Error response from daemon: only one instance of "null" network is allowe
```



#### 网络删除 docker network rm

```
作用：
	删除一个或多个网络
命令格式：
	docker network rm NETWORK [NETWORK...]
命令参数(OPTIONS)：
	无
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker network rm 204a
204a
[root@izuf6csxy0jrgs3azvia67z ~]# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
6d052b504ac7        bridge              bridge              local
a468c0a23faf        host                host                local
47d7fe0d3f46        none                null                local
```



#### 查看网络详细信息 docker network inspect

```
作用：
	查看一个或多个网络的详细信息
命令格式：
	docker network inspect [OPTIONS] NETWORK [NETWORK...]
      或者 docker inspect [OPTIONS] NETWORK [NETWORK...]
命令参数(OPTIONS)：
	-f, --format string   	根据format输出结果
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker network inspect -h
Flag shorthand -h has been deprecated, please use --help

Usage:	docker network inspect [OPTIONS] NETWORK [NETWORK...]

Display detailed information on one or more networks

Options:
  -f, --format string   Format the output using the given Go template
  -v, --verbose         Verbose output for diagnostics
[root@izuf6csxy0jrgs3azvia67z ~]# docker inspect 6d05
[
    {
        "Name": "bridge",
        "Id": "6d052b504ac75a7f072529b0439f8f3b3d685a68334955bea3929515df71f639",
        "Created": "2019-03-16T17:01:50.101348476+08:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]
[root@izuf6csxy0jrgs3azvia67z ~]# docker inspect -f "{{json IPAM.Config.Gateway}}" 6d05
Template parsing error: template: :1: function "IPAM" not defined
# 下面的Gateway不是一个对象    ---> 存疑
[root@izuf6csxy0jrgs3azvia67z ~]# docker inspect -f "{{json .IPAM.Config.Gateway}}" 6d05
Template parsing error: template: :1:12: executing "" at <.IPAM.Config.Gateway>: can't evaluate field Gateway in type interface {}
[root@izuf6csxy0jrgs3azvia67z ~]# docker inspect -f "{{json .IPAM.Config}}" 6d05
[{"Subnet":"172.17.0.0/16","Gateway":"172.17.0.1"}]
```



#### 使用网络 docker run --network

*docker 的网络使用是基于 容器 的 , 所以使用的是 docker run 加 --network 选项的方式*

```
作用：
	为启动的容器指定网络模式
命令格式：
	docker run/create --network NETWORK
命令参数(OPTIONS)：
	无
注意：
	默认情况下，docker创建或启动容器时，会默认使用名称为bridge的网络
```

```shell
[root@izuf6csxy0jrgs3azvia67z ~]# docker network create -d bridge my-bridge
fb089483b6b4f554580487bdcbf645e0f09272fb1b7313879f910302f1fcf96b
[root@izuf6csxy0jrgs3azvia67z ~]# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
6d052b504ac7        bridge              bridge              local
a468c0a23faf        host                host                local
fb089483b6b4        my-bridge           bridge              local
47d7fe0d3f46        none                null                local
[root@izuf6csxy0jrgs3azvia67z ~]# docker run --network my-bridge -dti centos bash
a0a310e8849e94147d508513af3ebaaee14c4d1d09639ca4186dac4d11ca6b2e
[root@izuf6csxy0jrgs3azvia67z ~]# docker exec a0a3 ping baidu.com
PING baidu.com (123.125.115.110) 56(84) bytes of data.
64 bytes from 123.125.115.110 (123.125.115.110): icmp_seq=1 ttl=50 time=25.1 ms
64 bytes from 123.125.115.110 (123.125.115.110): icmp_seq=2 ttl=50 time=25.1 ms
64 bytes from 123.125.115.110 (123.125.115.110): icmp_seq=3 ttl=50 time=25.2 ms

# 默认的网络是 bridge
--network string                 Connect a container to a network (default "default")
```

