步骤总结:

- 1.Nginx提供服务器进行rtsp收流
- 2.ffmpeg 进行转流



目前最后采用的方案参考自:

[FFmpeg+nginx海康威视rtsp转rtmp](<https://blog.csdn.net/zx763/article/details/83002528>)  存在问题:  需要给nginx安装 rtmp 插件并编译, 故推荐网上找编译好的.

1.下载 [nginx](http://nginx.org/en/download.html)  稳定版本

2.修改nginx配置文件 nginx.conf 后 重启(重载) nginx

```

#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}

rtmp {
    
    server {
        listen 1935;
        chunk_size 4000;
        # TV mode: one publisher, many subscribers
        application mylive {

            # enable live streaming
            live on;
        }
    }
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html;
            index  index.html index.htm;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}

```

3.安装 [FFmpeg](<https://ffmpeg.zeranoe.com/builds/>) , 并将 bin 目录的路径配置到 系统环境变量 path 中

4.cmd 中执行:

`ffmpeg -re  -rtsp_transport tcp -i "rtsp://admin:bl123456@10.90.93.144:554/Streaming/Channels/101" -f flv -vcodec libx264 -vprofile baseline -acodec aac -ar 44100 -strict -2 -ac 1 -f flv -s 1280x720 -q 10 "rtmp://127.0.0.1:1935/mylive/test"`



##### 当前方案遗留问题:

> 1.延迟问题
>
> 2.推流终止后再次推流, 服务器没法继续工作



##### 其他参考资料:

[海康&大华&DSS视频拉流-RTSP转RTMP多媒体播放技术](https://www.cnblogs.com/Javame/p/10070825.html)

