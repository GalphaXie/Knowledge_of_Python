## 虚拟环境

### 一、ubuntu 16.04 在线安装 virtualenv  virtualenvwrapper 虚拟环境

#### 1.检查 pip3 是否安装, 安装一下

```
apt install python3-pip
```

#### 2.安装 virtualenv  virtualenvwrapper

```shell
pip3 install virtualenv
pip3 install virtualenvwrapper
# 注: 有时候可能会因为网络问题, 出现报错信息, 多尝试几次.甚至可以加镜像源尝试一下
pip3 -i https://pypi.tuna.tsinghua.edu.cn/simple install xxx  清华源
http://pypi.douban.com/simple/  豆瓣源
```

#### 3.创建目录存放虚拟环境

```shell
mkdir $HOME/.virtualenvs
```

#### 4.配置环境变量(要区分: 当前用户或者root下)

- 打开`~/.bashrc 文件, 添加` (如果是安装装到系统的环境变量中, 则需要 sudo 权限)

```shell
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3  # 指定python解释器
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
```

#### 5.使配置生效

```shell
source ~/.bashrc
```

