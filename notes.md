## 2019-1-23

### 知识点1 -- ubuntu 下安装 deb 软件包的方法

- 1.通过命令 `sudo dpkg -i <package_name>` 来安装自己手动下载的 deb软件包,  需要加上超级管理员权限
- 2.前提--**更新软件源 解决依赖问题**
  - `sudo apt-get update`  更新
  - `sudo apt-get -f install`  解决依赖关系
  - `sudo dpkg -i xxx.deb` 重新安装



### 知识点2 -- 将html转换成pdf的python脚本

1. 

