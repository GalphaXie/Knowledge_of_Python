**什么是Redis持久化？Redis有哪几种持久化方式？优缺点是什么？**

持久化就是把内存的数据写到磁盘中去，防止服务宕机了内存数据丢失。

Redis 提供了两种持久化方式:RDB（默认） 和AOF 

**RDB：**

rdb是Redis DataBase缩写

功能核心函数rdbSave(生成RDB文件)和rdbLoad（从文件加载内存）两个函数

![img](https://mmbiz.qpic.cn/mmbiz_png/qdaKw2D1RS33kgdO9rAA7eyG2UopOLeNogmVwicBoUnOIrdoCh0xPibXFBHpiccvfpKa25A978HjeOvUE5DVLnKZw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

**AOF:**

Aof是Append-only file缩写

![img](https://mmbiz.qpic.cn/mmbiz_png/qdaKw2D1RS33kgdO9rAA7eyG2UopOLeNztTKGPmOfofnzmLhswaibjmr88Mx1PmSPCgR8ZCJjPG9t4DUnpSW5Ng/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

每当执行服务器(定时)任务或者函数时flushAppendOnlyFile 函数都会被调用， 这个函数执行以下两个工作

aof写入保存：

WRITE：根据条件，将 aof_buf 中的缓存写入到 AOF 文件

SAVE：根据条件，调用 fsync 或 fdatasync 函数，将 AOF 文件保存到磁盘中。

**存储结构:**

  内容是redis通讯协议(RESP )格式的命令文本存储。

**比较**：

1、aof文件比rdb更新频率高，优先使用aof还原数据。

2、aof比rdb更安全也更大

3、rdb性能比aof好

4、如果两个都配了优先加载AOF



## Linux下如何实现MySQL数据库每天自动备份定时备份

微wx笑 [数据库开发](javascript:void(0);) *9月25日*

> 来自：https://blog.csdn.net/testcs_dn/article/details/48829785
>
> 作者：testcs_dn(微wx笑)

备份是容灾的基础，是指为防止系统出现操作失误或系统故障导致数据丢失，而将全部或部分数据集合从应用主机的硬盘或阵列复制到其它的存储介质的过程。而对于一些网站、系统来说，数据库就是一切，所以做好数据库的备份是至关重要的！

## **备份是什么？**

![img](https://mmbiz.qpic.cn/mmbiz_png/sG1icpcmhbiaDY1cP2zNLw96xR6R11zPNzZyXsSDuUFxWicHg31Ymn1qcNTssy4X7pgSBp8Fs4R9KhlicynkCtjThg/640?tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

## **为什么要备份**

![img](https://mmbiz.qpic.cn/mmbiz_png/sG1icpcmhbiaDY1cP2zNLw96xR6R11zPNzouRbeGCGwGZdWI9NS3CIyekDKL2kzkTVkUpGDIuAx4ibQUFgB1jwcIA/640?tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

## **容灾方案建设**

![img](https://mmbiz.qpic.cn/mmbiz_png/sG1icpcmhbiaDY1cP2zNLw96xR6R11zPNz8VSwiafDICib81ZBumFxpcgqpewoqKX5kq1YwTyTTSW4xunIlgPBoubg/640?tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

## **存储介质**

> 光盘 
> 磁带 
> 硬盘 
> 磁盘阵列 
> DAS：直接附加存储 
> NAS：网络附加存储 
> SAN：存储区域网络 
> 云存储

这里主要以本地磁盘为存储介质讲一下计划任务的添加使用，基本的备份脚本，其它存储介质只是介质的访问方式可能不大一样。

**1、查看磁盘空间情况：**

既然是定时备份，就要选择一个空间充足的磁盘空间，避免出现因空间不足导致备份失败，数据丢失的恶果！ 

存储到当前磁盘这是最简单，却是最不推荐的；服务器有多块硬盘，最好是把备份存放到另一块硬盘上；有条件就选择更好更安全的存储介质；

```
# df -hFilesystem
```

**2、创建备份目录：**

上面我们使用命令看出/home下空间比较充足，所以可以考虑在/home保存备份文件；

```
cd /home
mkdir backupcd backup
```

**3、创建备份Shell脚本:**

注意把以下命令中的DatabaseName换为实际的数据库名称； 
当然，你也可以使用其实的命名规则！

```
vi bkDatabaseName.sh
```

输入/粘贴以下内容：

```
#!/bin/bash
mysqldump -uusername -ppassword DatabaseName > /home/backup/DatabaseName_$(date +%Y%m%d_%H%M%S).sql
```

对备份进行压缩：

```
#!/bin/bash
mysqldump -uusername -ppassword DatabaseName | gzip > /home/backup/DatabaseName_$(date +%Y%m%d_%H%M%S).sql.gz
```

**注意：** 
把 username 替换为实际的用户名； 
把 password 替换为实际的密码； 
把 DatabaseName 替换为实际的数据库名；

**4、添加可执行权限：**

```
chmod u+x bkDatabaseName.sh
```

添加可执行权限之后先执行一下，看看脚本有没有错误，能不能正常使用；

```
./bkDatabaseName.sh
```

##  

## **5、添加计划任务**

## **检测或安装 crontab**

确认crontab是否安装： 
执行 crontab 命令如果报 command not found，就表明没有安装

如时没有安装 crontab，需要先安装它，具体步骤请参考： 
CentOS下使用yum命令安装计划任务程序crontab 
使用rpm命令从CentOS系统盘安装计划任务程序crontab

## **添加计划任务**

执行命令：

```
crontab -e
```

这时就像使用vi编辑器一样，可以对计划任务进行编辑。 
输入以下内容并保存：

```
*/1 * * * * /home/backup/bkDatabaseName.sh
```

具体是什么意思呢？ 
意思是每一分钟执行一次shell脚本“/home/backup/bkDatabaseName.sh”。

**6、测试任务是否执行**

很简单，我们就执行几次“ls”命令，看看一分钟过后文件有没有被创建就可以了！

如果任务执行失败了，可以通过以下命令查看任务日志：

```
# tail -f /var/log/cron
```

输出类似如下：

```
Sep 30 14:01:01 bogon run-parts(/etc/cron.hourly)[2503]: starting 0anacron
Sep 30 14:01:01 bogon run-parts(/etc/cron.hourly)[2512]: finished 0anacron
Sep 30 15:01:01 bogon CROND[3092]: (root) CMD (run-parts /etc/cron.hourly)
Sep 30 15:01:01 bogon run-parts(/etc/cron.hourly)[3092]: starting 0anacron
Sep 30 15:01:02 bogon run-parts(/etc/cron.hourly)[3101]: finished 0anacron
Sep 30 15:50:44 bogon crontab[3598]: (root) BEGIN EDIT (root)
Sep 30 16:01:01 bogon CROND[3705]: (root) CMD (run-parts /etc/cron.hourly)
Sep 30 16:01:01 bogon run-parts(/etc/cron.hourly)[3705]: starting 0anacron
Sep 30 16:01:01 bogon run-parts(/etc/cron.hourly)[3714]: finished 0anacron
Sep 30 16:15:29 bogon crontab[3598]: (root) END EDIT (root)
```

