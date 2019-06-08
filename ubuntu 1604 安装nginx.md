#### 不要重复在自己不需要精通的领域造轮子,  总结:

##### 详细安装教程:  [ubuntu16.04 上 nginx安装教程](http://www.nginx.cn/4723.html)

##### 进阶学习教程:  [进阶学习教程](http://tengine.taobao.org/book/)

ubuntu 16.04 安装 nginx 安装总结和注意事项:

- 0.Ubuntu默认的源中就有Nginx,  所以只需要更新源之后直接即可安装;
- 1.配置防火墙
- 2.配置文件 |  是否开机自启 | 查看启动状态等配置
- 3.访问页面 [浏览器 或  curl] 确认是否访问成功
- 4.管理nginx进程 [启动 , 重启, 停止, 重新加载配置文件]
- 5.nginx的文件和目录:  网站文件位置 |  服务器配置 | 日志文件



---



1. Ubuntu默认的源中就有Nginx，所以安装是比较简单的

1. 更新源, 并安装 nginx

```
sudo apt-get update  && sudo apt-get install nginx
```

1. 配置防火墙

```
sudo ufw app list    # 显示所有ufw应用的配置
-------------------------
Available applications:
  CUPS 
  Nginx Full      # 这个配置打开 80端口和443端口
  Nginx HTTP      # 这个配置只打开80 (普通, 未加密通信)
  Nginx HTTPS     # 这个配置只打开 443 (TLS/SSL 加密通信 )
  OpenSSH
```

只打开 80 端口:

`sudo ufw allow 'Nginx HTTP'`

`sudo ufw status`  查看状态

3.检查  web  server  

ubuntu 默认安装nginx 后就是开启的, 注意不是所有操作系统都是这样. 

进一步检查  web server 状态:  `systemctl status nginx`





