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
docker run
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



