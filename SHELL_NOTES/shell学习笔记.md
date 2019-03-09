发现一个牛逼的网站: [[Linux命令大全](http://man.linuxde.net/)]

## shell 笔记 2019-03-02 21:36

### 0.shell介绍

- 0.自动化可以通过两种方式来实现:  **工具** 和 **脚本**

- 1.常见的脚本有两种
  - shell脚本
  - 其他脚本, 诸如python脚本等
- 2.shell 是一个  **命令解释器** , shell是位于应用程序和操作系统之间的有效命令翻译工具.
- 3.shell分为两大类
  - 1.图形化的shell , 如我们常说的操作系统的桌面
  - 2.命令行的shell
    - win 系统下的 cmd
    - Linux 系统下的 shell   (sh  bash  ksh ...)
      - 注: **最原始的shell是 `sh` , 目前各大`*uinx`平台的shell是bash, 它新增了很多功能**  . 所以在shell脚本中 推荐使用 `#!/bin/bash`代替`#!/bin/sh`
  - 3.查看系统shell类型:  `echo $SHELL`
  - 4.查看当前系统环境支持的shell  :  `cat /etc/shells`
  - 5.shell手工执行的时候有一个重要的特点: **逐行输入命令, 逐行解释执行**  (解释性语言都是如此)

## 1. shell脚本的基础知识

#### 0.概念

- 常用编辑工具 vim vi
- 命名: **见名知义**

#### 1.注释

##### 1.1单行注释

​	除了 **首行** 加`#`不是注释外, 其他在行首加`#`均表示此行是单行注释

##### 1.2多行注释

​	实现方式有两种:

- 方法一

```shell
:<<!
...  #这里表示注释掉的内容
!
```

- 方法二

```shell
:<<字符
...  #这里表示注释掉的内容
字符
```

#### 2.脚本执行(三种方式)

##### 2.1强烈推荐的方式: 写完整的路径名

`/bin/bash /path/script-name.sh ` (更推荐) 或 `bash /path/script-name.sh`

##### 2.2当前路径下执行脚本

`path/to/script-name.sh` 或 `./script-name.sh` 

**注意:** 要修改文件的可执行权限 `chmod +x script-name.sh`

##### 2.3点 执行

`source script-name.sh`  或 `. script-name.sh`

> 执行说明：
>
> 1、脚本文件本身没有可执行权限或者脚本首行没有命令解释器时使用的方法，我们推荐用bash执行。
>
> 使用频率：☆☆☆☆☆
>
> 2、脚本文件具有可执行权限时使用。
>
> 使用频率：☆☆☆☆
>
> 3、使用source或者.点号，加载shell脚本文件内容，使shell脚本内容环境和当前用户环境一致。
>
> 使用频率：☆☆☆
>
> 使用场景：环境一致性

#### 3.脚本开发规范

- 1.命名要见名知义, 脚本后缀是 `.sh`

- 2.脚本首行是且必须是`#!/bin/bash`
- 3.第二行开始一般先写脚本的描述信息:
  - 3.1脚本名称, 功能, 版本, 作者, 联系信息等
  - 3.2注释 **不推荐中文**, 避免不同的操作系统出现中文乱码的问题
- 4.脚本的执行也是从上到下依次执行, 但是可以通过 `&`灵活的使其中 **部分阻塞式的命令在后台执行**

- 5.代码书写规范
  - 5.1 成对内容一次写出防止遗漏, 比如 `()`等
  - 5.2 `[  ]`中括号内部的 **两端**要有空格
  - 5.3 内部流程控制语句一次性书写完, 再添加内容.
  - 5.4通过缩进提高代码的 **可读性**, 即该有空格的地方要有空格
    - *注: 比较奇葩, 往往有些地方没有空格, 会因为python代码的规范来误用空格,比如在给变量的赋值的时候就容易犯这样的错误*

#### 4.变量

##### 0.变量

- 变量名  (不变的部分)
- 变量值  (可变的部分)

通常提到 **变量** 指的是 **变量名**

##### 1.本地变量

- 注: *在当前系统的**某个环境下**才能生效的变量, 作用范围小*
- 本地变量包含两种
  - 普通变量
  - **命令变量**  (必须掌握)

**普通变量** 的定义方式(三种)

- 1.方式一:  `变量名=变量值`

  - **重点:** 变量值必须是一个整体，中间没有特殊字符
  - **注意:**  **等号**两边都不能有空格

- 2.方式二: `变量名='变量值'`

  - **重点:** "所见即所得"

  - 这里是 `单引号`不是 `反引号`

- 3.方式三: `变量名="变量值"`

  - **重点:**如果变量值范围内, 有可以解析的变量A, 那么首先解析变量A, 将A的结果和其他内容组合成一个 **整体** , 重新赋值给变量B

- 4.习惯:  ==数字不加引号, 其他默认加双引号==

**命令变量** 定义有两种方式:  **(熟练)** 

- 1.方式一: 变量名=<code>&#96;</code>命令<code>&#96;</code>
-  2.方式二: 变量名=$(命令)
- *注意点:  这里==等号==两边都不能有空格*

##### 2.全局变量

- 注: 在当前系统所有环境都能生效得变量
- **查看全局变量:**  `env` 命令查看系统的所有环境变量

**定义全局变量**

```shell
方法一
	变量名=变量值
	export 变量名
方法二
	export 变量名=变量值
```

显然通过上面定义方式, 我们更加倾向选用 方法二

**变量查看和取消**

```shell
查看变量
	方式一
		$变量名
	方式二
		"$变量名"
	方式三
		${变量名}
		频率较高, 在作为一个被双引号已经包裹的命令中使用
	方式四
		"${变量名}"
		标准用法, 推荐用法

取消变量
	unset 变量名
```

##### shell内置变量

- **注:** 无需我们定义就可以直接来使用的变量

**和脚本文件有关**

| 符号 | 意义                                                         |
| ---- | ------------------------------------------------------------ |
| $0   | 获取当前执行的shell脚本文件名，包括脚本路径                  |
| $n   | 获取当前执行的shell脚本的第n个参数值，n=1..9，当n为0时表示脚本的文件名，如果n大于9就要用大       括号括起来${10} |
| $#   | 获取当前shell命令行中参数的总个数                            |
| $?   | 获取执行上一个指令的返回值(0为**成功** , 非0为**失败**)      |

**字符串精确截取相关**

`格式: ${变量名:起始位置:截取长度}`

```shell
#示例代码:
${file:0:5}		从第1个字符开始，截取5个字符
${file::5}			从第1个字符开始，截取5个字符
${file:5:5}		从第6个字符开始，截取5个字符
${file:5}			从第6个字符开始，截取后面所有的字符
${file:0-5}		从倒数第5个字符开始，截取后面所有的字符
${file:0-6:3}		从倒数第6个字符开始，截取之后的3个字符
```

**默认值相关**

> 1.格式: `${变量名:-默认值}`
>
> 场景:
>
> - if 变量a 有值,  then 输出 变量a 的值
> - 否则, 就输出 默认值

```shell
#!/bin/bash
#套餐选择演示: 如果用户指定了套餐n那么就输出n, 否则一律输出套餐1
a="$1"
echo "您选择的套餐是: ${a:-1}"
```

> 2.格式: `${变量名+默认值}`
>
> 场景:
>
> - 无论变量a是否有内容, 都输出默认值
> - 注:  如果不给参数, 那么默认不显示的 ,这个和上面不同

```shell
#!/bin/bash
# 无论输入法定结婚年龄是多少岁, 一律输出法定结婚年龄(男性)22岁
a="$1"
echo "国家法定结婚年龄(男性)是${a+22}岁"
```



#### 5.SHELL 进阶

##### 1. 表达式

**1.1 测试语句形式**

**A: test 条件表达式**

**B: [ 条件表达式 ]**   ==更常用==

格式注意:

- 1.上述两种方式作用完全一样, 后者更加常用
- 2.后者需要注意 `[]`的 内部两端与条件表达式之间至少有一个空格
- 3.test跟 [] 意思一样
- 4.**条件成立, 状态返回值是0, 条件不成立, 状态返回值是1**

**1.2 条件表达式**

> **逻辑表达式**
>
> - 逻辑表示一般用于判断多个条件之间的依赖关系
>
> - 两种:  &&  和 ||

**"夫唱妇随"**

```shell
1. &&
命令1 && 命令2
如果命令1执行成功, 那么执行命令2
如果命令1执行失败, 那么也不再执行命令2
```

**"对着干"**

```shell
1. ||
命令1 || 命令2
如果命令1执行成功, 那么不执行命令2
如果命令1执行失败, 那么执行命令2
```

> **文件表达式**

**-f  判断输入内容是否是一个文件**

```shell
#!/bin/bash
# description: 判断xx是否是一个文件
[ -f test.sh ] && echo "是一个文件"
[ -f test.sh ] || echo "不是一个文件"
```

**-d 判断输入内容是否是一个目录**

```shell
[ -d test.sh ] || echo "不是一个目录"
mkdir test
[ -d test ] && echo "是一个目录"
```

**-x 判断输入内容是否可行**

```shell
[ -x test.sh ] || echo "文件没有执行权限"
[ -x test.sh ] && echo "文件没有执行权限"
```

> 数值操作符

```shell
n1 -eq n2  相等
n1 -gt n2  大于
n1 -lt n2  小于
n1 -ne n2  不等于
```

> 字符串比较

```shell
str1 == str2   str1和str2字符串内容一致
str1 != str2   str1和str2字符串内容不一致.   !表示相反的意思.
```

**1.3 计算表达式**

> 方式一
>
> ​	`$((计算表达式))`
>
> 方式二
>
> ​	let 计算表达式
>
> **注意: `$(())中只能用+-*/运算符,并且只能做整数运算`**

```shell
#!/bin/bash
#description: 运算符的两种方式演示


i=0
while [ $i -lt 5 ]
do
    echo $i
    i=$((i+1))

done
echo $((100/5))

#----------------
j=10
let j=j-1
echo "j 的结果是: ${j}"

#总结:
#    1.表达式范围内, 空格不限制
#    2.表达式必须是一个整体, 中间不能出现空格等特殊字符.
```



##### 2. Linux常见符号

**2.1 重定向符号**

> `>`  表示左侧内容, 以 **覆盖** 方式输入到右侧文件中
>
> `>>` 表示左侧内容, 以 **追加** 方式输入到右侧文件末尾行的下一行.

**2.2 管道符**

> `|` 
>
> `命令1 | 命令2` 管道符左侧 **命令1** 执行后的结果 , **传递** 给管道符右侧的**命令2** 使用.
>
> 举例: `env | grep SHELL`

**2.3 其他符号**

> **后台展示符号 &**
>
> - 1.定义: **`&`**就是将一个命令从前台转到后台执行
> - 2.使用: `命令 &`

> **全部信息符号  2>&1**
>
> - 1.符号详解:
>   - 1  表示正确输出的信息
>   - 2  表示错误输出的信息
>   - 2>&1 表示所有的输出的信息
> - 2.符号示例
>   - `cat test.sh 1>> zonghe.sh`  标准正确输出示例
>   - `asdfgh 2>> err.log`
> - 3.**Linux 垃圾桶: /dev/null**
>   - `/dev/null ` 是 linux 下的一个设备文件, 特点: 容量无限大.

```shell
#!/bin/bash
#description: xxx

echo "执行一条错误指令"
asdfgh 
echo "执行一条错误指令"
ls /root

bash test.sh 1>> test_ok.log 2>> test_error.log

bash test.sh >> all_info.log 2>&1
```



##### 3. 常见命令详解

**3.1 grep 命令详解**

> `grep` 是强大的 **文本搜索命令**
>
> 格式:
>
> ​	`grep [参数][关键字] <文件名>`
>
> 注意:
>
> ​	在查看某个文件的内容的时候, 是需要有<文件名>
>
> ​	`grep`命令在结合 `|` 使用的情况下, 后面的后面的`<文件名>`是没有的
>
> ​	帮助文档:  `grep --help`
>
> **参数详解: **
>
> - `-c`  只输出匹配行的计数
> - `-n` 显示匹配行及行号
> - `-v`  显示不包含匹配文本的所有行
>
> **小技巧**
>
> ​	精确定位错误代码
>
> ​	`grep -nr [错误关键字] *`

**3.2 sed 命令详解**

> **sed 行命令编辑工具.   编辑文件是以 行 为单位的**
>
> **命令格式:**
>
> ​	`sed [参数] <匹配条件> [动作] [文件名]`
>
> **参数详解:**
>
> - 参数为空     表示se的操作效果实际上不对文件进行编辑
> - `-i`              表示对文件进行编辑(注意mac版本的bash使用 -i 参数, 必须在后面**单独** 加个东西: -i ``)
>
> **匹配条件**
>
> - 匹配条件分为两种: **数字行号**或者**关键词**匹配
>   - 关键字匹配格式:
>     - '/关键字/'
>     - 注意: 隔离符号 / 可以换成 @  #  ! 等符号
>     - 根据实际情况: 如果关键字和隔离符号有冲突, 就换成其他的符号即可.
>
> **动作详解**  *<u>注意:  下面的动作应该在参数为 -i 的时候使用, 不然的话不会有效果</u>*
>
> - -a     在匹配到的内容的下一行增加内容
>   - 格式: `sed -i '行号a\增加的内容' 文件名`
>   - 注意: 如果是增加多行, 可以在行号的位置写个范围值, 彼此之间用 **`,`** 隔开.
>   - 举例: 在1-3行的每一行后面增加内容: `sed -i  '行号a\增加的内容' 文件名`
> - -i      在匹配到的内容的上一行增加内容
>   - 格式: `sed -i '行号i\增加的内容' 文件名`
> - -d     删除匹配到的内容
>   - 格式: `sed -i '行号d' 文件名`
>   - 如果删除多行, 在行号位置用**逗号**隔开.
> - -s     替换匹配到的内容
>   - 包含:   **行号   列号   全体**   3种替换方式
>   - 命令格式:    `sed -i [替换格式] [文件名]`
>   - *注意:  替换命令的写法*
>     - 's###'     ---->  's#原内容#替换后的内容#'
>   - 替换 **每行首个** 匹配内容:   `sed -i 's#原内容#替换后的内容#' 文件名`
>
> ```shell
> #1.替换 每行首个 匹配到的内容:
> sed -i 's#原内容#替换后内容#' 文件名
> 
> #2.替换 全部 匹配到的内容:  通过 g 来实现
> sed -i 's#原内容#替换后的内容#g' 文件名
> 
> #3.指定 行号 替换 首个 匹配内容:
> #比如替换第2行
> sed -i '2s#原内容#新内容#' 文件名
> 
> #4.首行 指定 列号 替换匹配内容
> 替换第3列匹配到的内容的那一列
> sed -i 's#原内容#新内容#3' 文件名
> 
> #5.指定 行号 列号 匹配内容
> sed -i '行号s#原内容#替换后的内容#列号' 文件名
> ```

**3.3 awk 命令详解**

*<u>注: awk 是一个功能强大的文档编辑工具, 不仅能以行为单位进行编辑还能以列为单位进行文件处理</u>*

> **命令格式:**
>
> ​	awk [参数] '[动作]' 文件名
>
> **常见参数**
>
> - -F            指定行的分隔符
>
> **常见内置变量**
>
> FILENAME    当前输入文件的文件名, 该变量是 只读 的
>
> NR                  指定显示行的行号
>
> NF                  输出  最后一列的内容
>
> OFS                输出格式的列分隔符, 默认是空格
>
> FS                   输入文件的列分隔符, 默认是连续的空格和Tab
>
> **命令演示**
>
> ```shell
> #1.打印指定列的内容
> awk '{print $1,$4,$6}' awk.txt
> #2.指定行打印内容
> awk 'NR==1 {print $1,$3}' awk.txt
> #3. 指定分隔符打印内容
> awk -F ':' '{print $1,$7}' awk.txt
> #4. 设置显示分隔符,显示内容
> awk 'BEGIN{OFS=":"} {print NR,$0}' awk.txt
> ```

**3.4 find命令详解**

> **命令格式:**
>
> ​	`find [路径][参数] [关键字]`
>
> **参数详解**
>
> - **-name       按照文件名查找文件**
> - -perm        按照文件权限来查找文件
> - -user          按照文件属主来查找文件
> - -group       按照文件所属的组来查找文件
> - **-type          查找某一类型的文件**
>   - b    块设备文件
>   - d     目录
>   - c      字符设备文件
>   - p     管道文件
>   - l       符号链接文件
>   - f       普通文件
> - -size n：[c] 查找文件长度为n块的文件，带有c时表示文件长度以字节计
> - -depth：在查找文件时，首先查找当前目录中的文件，然后再在其子目录中查找。
> - -mindepth n：在查找文件时，查找当前目录中的第n层目录的文件，然后再在其子目录中查找。! : 表示取反



#### 6.流程控制

##### 6.1简单流程控制语句

**6.1.1 单分支if语句**

>  语法

```shell
if [ 条件 ]
then
    指令
fi
```

**6.1.2 双分支if语句**

> 语法

```shell
if [ 条件 ]
then
	指令1
else
	指令2
fi
```

**6.1.3 多分支if语句**

> 语法

```shell
# 场景:  服务器的  start stop restart ... 场景中
if [ 条件1 ]
then
	指令1
elif [ 条件2 ]
then
	指令2
else
	指令3
fi
```

**6.1.4 case 选择语句**

> 格式

```shell
case 变量名 in
值1)
    指令1
    ;;
值2)
    指令2
    ;;
值3)
    指令3
    ;;
*)
    指令4
    ;;
esac
```

**6.1.5 for循环语句**

​	*循环完指定的所有元素, 循环完就退出循环*

> 语法

```shell
for 值 in 列表
do
    执行语句
done
```

**6.1.6 while 循环语句**

> 语法

```shell
while 条件
do
	执行语句
done
```

> **注意:**
>
> ​	条件的类型:
>
> ​		**命令** 、[[字符串表达式]] 、((数字表达式))

```shell
#!/bin/bash
# while的示例
a=1
while [ "${a}" -lt 5 ] 
do
   echo "${a}"
   a=$((a+1))
done
```

**6.1.7 until 循环**   (只要 条件 不成立, 就一直循环下去)

> 语法

```shell
until 条件
do
   执行语句
done
```

>  **注意:**
>
> ​	条件的类型:
>
> ​		**命令** 、[[字符串表达式]] 、((数字表达式))

```shell
#!/bin/bash
# until的示例
a=1
until [ "${a}" -eq 5 ] 
do
   echo "${a}"
   a=$((a+1))
done
```

##### 6.2 复杂流程控制语句 -- 函数

**6.2.1 函数基础知识**

简单函数格式:

> 定义函数

```shell
函数名(){
    函数体
}
```

> 调用函数

```shell
函数名
```

传参函数格式:

> 传参数

```shell
函数名 参数
```

> 函数体调用参数

```shell
函数名(){
    函数体 $n
}
```

> 脚本传参 --> 给函数调用(作为其参数)



#### 7. 代码发布

##### 7.1 发布流程(大型脚本)

```mermaid
graph LR
A[1.获取代码] --> B[2.打包代码]
B --> C[3.传输代码]
C --> D[4.停止使用]
D --> E[5.解压代码]
E --> F[6.放置代码]
F --> G[7.开启应用]
G --> H[8.检查结果]
H --> I[9.对外访问]
```

关闭服务流程: <u>先关闭离客户近的, 再关闭离客户远的</u>

开启服务流程: <u>先开启离客户远的, 再开启离客户近的</u>

检查: ***查看浏览器效果 或者 netstat -tnulp查看系统开放的端口***

##### 7.2 常见的工具

- 1.仓库管理工具:
  - git   对网络的依赖更低, 大多数都可以 本地化完成
  - svn  **集中式** , 对网络的依赖高
  - gitlab  私有化仓库
- 2.权限

  - 开发|管理|查看
- 3.打包
- 4.传输
  - 有网
    - git    ftp   scp     共享挂载   cp   rsync
  - 没网
    - U盘  硬盘

##### 7.3 技术关键点

- 1.文件压缩
  - 压缩格式:    `tar zcvf  xx.tar.gz  xx`
  - 解压格式:    `tar  xvf  xx.tar.gz`
  - 查看格式:    `zcat xx.tar.gz`
  - 命令参数详解:
    - z    指定压缩文件的格式为  tar.gz
    - c    表示压缩
    - v    显示详细过程
    - f     指定压缩文件
    - x     解压
- 2.文件传输--scp传输工具
  - 命令格式: `scp 要传输的文件 要放置的位置`    (*注: 只能传输单个文件而非文件夹*)
  - 远端主机 **[文件放置位置]** 的表示形式:
    - `远端链接的用户@远程主机:远程主机的目录路径 `
  - 远端主机 **[文件位置]** 的表示形式
    - `远程连接的用户@远程主机:远程主机的文件路径`
- 3.文件的备份
  - date命令详解:
    - 格式: `date [option] `
    - 常见参数: 
      - +%F    日期    %Y-%m-%d
      - +%T    时间     %H:%M%S    
    - 实际应用:
      - `mv  folder folder-$(date +%Y%m%d%H%M%S)`
      - `cp folder folder-$(date +%Y%m%d%H%M%S)`



#### 8. 环境部署

##### 8.1 基础环境

**8.1.1 基础目录环境**

**创建基本目录---同时创建多个目录**

```shell
mkdir /data/{server,logs,backup,softs,virtual,scripts,codes} -p
备份 代码 日志 脚本 服务 软件 虚拟环境
```

**8.1.2 主机网络环境**

==主机间免密认证==   (在root账户下操作的, ubuntu默认是没有root密码,需要设置sudo passwd,通过安装时候的用户(已具有)权限去进行设置)

- 1.方案详解
  - 本机生成密钥对
  - 对端机器使用公钥文件认证
  - 验证

- 2.方案实施

  (<u>**备注: 2.1和2.5是在服务器上操作的, 其他几步都是在本地主机上操作**</u>)

  - 2.1生成密钥 对  `ssh-keygen -t rsa`
    - -t    指定密钥的类型
    - rsa   密钥的类型
    - 2.2密钥目录:  `/root/.ssh/`  (ubuntu的root权限下才是有这个目录)
      - 私钥:  `id_rsa`        钥匙
      - 公钥: `id_rsa.pub`   锁
  - 2.2编辑认证文件
    - `mkdir /root/.ssh`
    - `vim /root/.ssh/authorized_keys`
    - 复制公钥内容到本地电脑的
  - 2.3编辑ssh配置文件
    - 前置步骤, 有些Ubuntu没有`sshd_config`文件, 需要先执行: `sudo apt-get install openssh-server`, 这样保证才能真正开启 **ssh** 服务,  最终才会看到 `/etc/init.d/`下面有`ssh`可执行的服务. 用于后面修改服务后的重启服务.其他配置可以参考 [Ubuntu下SSH设置](http://www.cnblogs.com/chen1987lei/archive/2010/12/02/1894768.html)
    - `vim /etc/ssh/sshd_config`
    - 取消注释:   `AuthorizedKeysFile   %h/.ssh/authorized_keys`  (%h  表示当前用户, 其实主要是要找到该目录即可, 可以在~目录下`cd .ssh 看看是否下面有authorized_keys文件`)
  - 2.4配置文件生效
    - 重启ssh服务   `/etc/init.d/ssh restart`
  - 2.5验证操作(看是否还需要输入密码)
    - ssh root@ip

==上面的存在问题暂时搁置==

##### 8.2方案分析

**8.2.1 需求**

**8.2.2 需求分析**

**8.2.3 部署方案**

环境部署方案

- Django环境部署
  - 1.1python虚拟环境
  - 1.2django环境部署
    - 1.2.1 django软件安装
    - 1.2.2 项目基本操作
    - 1.2.3 应用基本操作
    - 1.2.4 view和url配置
- Nginx代理django
  - 2.1nginx软件安装
    - 2.1.1  pcre软件安装
    - 2.2.2  nginx安装
    - 2.2.3   nginx基本操作
  - 2.2 nginx代理配置
    - 2.2.1目录结构查看
    - 2.2.2  配置文件查看
    - 2.2.3  编辑代理配置项
- 项目调试
  - 3.1  启动软件
    - 3.1.1 启动django
    - 3.1.2 启动nginx
  - 3.2  整个项目调试

##### 8.3 项目环境部署

**8.3.1 python虚拟环境**

软件安装--安装虚拟环境

`apt-get install python-virtualenv -y`  

或者 `yum install python-virtual`

*注: python-virtual其实是一个Python包, 可以用 `pip install virtualenv` 或 `easy_install`来安装.* 

> 原因:
>
>  [1.有较少概率出现版本和系统不兼容](https://blog.csdn.net/guoqianqian5812/article/details/72625617)
>
> 解决: <u>如果virtualenv是通过yum安装的，请卸载后使用pip进行安装</u>

虚拟环境基本操作

创建: `virtualenv -p /usr/bin/python3.5 venv`

进入: `source venv/bin/activate`

退出: `deactivate`

删除: `rm -rf venv`

<u>*注: venv 是虚拟环境名*</u>

**8.3.2 django环境**

```shell
解压
cd /data/soft
tar xf Django-1.11.11.tar.gz
查看
cd Django-1.11.11
cat INSTALL or README
安装
python setup.py install
```

**拓展知识点**

**1. python类型软件的安装教程**

  - 普通 

         - 解压   安装

- 特殊:

      - 解压   编译   安装
      - 编译:  `python setup.py build` 

  **2. Linux 中软件安装的一般流程**

- 解压   tar
  - 获取真正的配置文件
- 配置  configure
  - 根据默认配置项或更改配置项, 生成编译配置文件(Makefile)
- 编译   make
  - 根据 Makefile 内容, 编译生成指定的软件所需要的所有文件
- 安装   make install
  - 将编译生成的所有文件,转移到软件指定安装的目录下面

**8.3.3 nginx环境**

pcre 软件安装

```shell
解压
cd /data/soft/
tar xf pcre-8.39.tar.gz
查看帮助
cd pcre-8.39
INSTALL 或者 README
配置
./configure
编译
make
安装
make install
```

nginx软件安装

```shell
解压
cd /data/soft/
tar xf nginx-1.10.2.tar.gz
配置
cd nginx-1.10.2/
./configure --prefix=/data/server/nginx --without-http_gzip_module
编译
make
安装
make install
```

nginx 简单操作

```shell
检查
/data/server/nginx/sbin/nginx -t 检查nginx的配置文件,及是否成功
开启
/data/server/nginx/sbin/nginx
关闭
/data/server/nginx/sbin/nginx -s stop
重载
/data/server/nginx/sbin/nginx -s reload
检查开启情况:
netstat -tnulp | grep ':80'
```

**8.3.4 nginx代理django**

nginx配置简介

==nginx目录结构==

```shell
....# tree -L 2 /data/server/nginx/
/data/server/nginx/
├── ...
├── conf				配置文件目录
│   ...
│   ├── nginx.conf		默认的配置文件
│   ...
├── ...
├── html				网页文件
│   ├── 50x.html
│   └── index.html
├── logs				日志目录
│   ├── access.log
│   └── error.log
├── ...
├── sbin				执行文件目录
│   └── nginx
├── ...	

```

==nginx配置文件介绍==

- 全局配置段
- http配置段
  - server配置段				项目或应用
    - location配置段		url配置

#### 9. 脚本发布代码

##### 9.1  简单脚本编写

- 1.命令罗列实现功能
- 2.固定内容变量实现
- 3.功能函数实现
- 4.远程执行命令

**9.1.1 命令罗列**

```shell
#!/bin/bash
#功能: 打包代码
#脚本名: tar_code.sh
#作者: Guang
#版本: v 0.1
#联系方式: defaulttest@sina.com

cd /data/codes
[ -f django.tar.gz ] && rm -f django.tar.gz
tar zcf django.tar.gz django
```

**9.1.2 固定内容变量化**

```shell
#!/bin/bash
#功能: 打包代码
#脚本名: tar_code.sh
#作者: Guang
#版本: v 0.2
#联系方式: defaulttest@sina.com

FILE="django.tar.gz"
CODE_DIR="/data/codes"
CODE_PRO="django"

cd "${CODE_DIR}"
[ -f "${FILE}" ] && rm -f "${FILE}"
tar zcf "${FILE}" "${CODE_PRO}"
```

**9.1.3 功能函数化**

```shell
#!/bin/bash
#功能: 打包代码
#脚本名: tar_code.sh
#作者: Guang
#版本: v 0.3
#联系方式: defaulttest@sina.com

FILE="django.tar.gz"
CODE_DIR="/data/codes"
CODE_PRO="django"

code_tar(){
    cd "${CODE_DIR}"
    [ -f "${FILE}" ] && rm -f "${FILE}"
    tar zcf "${FILE}" "${CODE_PRO}"
}

code_tar
```

**9.1.4 远程执行**

远程命令

```shell
举例:
ssh root@47.101.212.36 "ls -alh /home"
举例:
ssh root@47.101.212.36 "ifconfig etho0"
总结, 需要执行的命令推荐用 双引号 包裹
```

##### 9.2 大型脚本编写

编写大型脚本有一个流程:

- 1.脚本框架
- 2.命令填充
- 3.完善功能
  - 日志
  - 锁文件
  - 主函数逻辑
  - 参数安全措施

**9.2.1 脚本框架**

命令多  功能多  不好组合  ==> 脚本框架

**需求:**

​	先将脚本所涉及的业务流程跑通.

> 穿插自己的见解:
>
> ​	shell编程最好的思路其实就是一步步的单独到命令行中去测试通过, 然后组合起来.
>
> ​	因为shell的脚本一般不太会涉及到特别复杂的逻辑, 这样的思路基本够用.	

**方案:**

​	函数

**实施框架**

```shell
#!/bin/bash
#description: 打包代码
#script_name: deploy.sh
#author: Guang
#version: v 0.1
#e-mail: defaulttest@sina.com

#获取代码
get_code(){
    echo "获取代码"
}

#打包代码
tar_code(){
    echo "打包代码"
}

#传输代码
scp_code(){
    echo "传输代码"
}

#关闭应用
stop_server(){
    echo "关闭应用"
    echo "关闭nginx应用"
    echo "关闭django应用"
}

#解压代码
untar_code(){
    echo "解压代码"
}

#放置代码
put_code(){
    echo "放置代码"
    echo "备份老文件"
    echo "放置新文件"
}

#开启应用
start_server(){
    echo "开启应用"
    echo "开启Django应用"
    echo "开启nginx应用"
}

#检查
check(){
    echo "检查项目"
}

#部署函数
deploy_pro(){
    get_code
    tar_code
    scp_code
    stop_server
    untar_code
    put_code
    start_server
    check
}

#主函数
main(){
    deploy_pro
}

#执行主函数
main
```

**9.2.2 命令填充**

**方案**

​	*在脚本框架中, 填写执行成功的命令*

脚本实施:

```shell
#!/bin/bash
#description: 打包代码
#script_name: deploy.sh
#author: Guang
#version: v 0.2
#e-mail: defaulttest@sina.com

#获取代码
get_code(){
    echo "获取代码"
}

#打包代码
tar_code(){
    echo "打包代码"
    ssh root@des_ip "/bin/bash /data/scripts/tar_code.sh"
}

#传输代码
scp_code(){
    echo "传输代码"
    cd /data/codes
    [ -f ddjango.tar.gz ] && rm -f django.tar.gz
    scp root@des_ip:/data/codes/django.tar.gz ./
}

#关闭应用
stop_server(){
    echo "关闭应用"
    echo "关闭nginx应用"
    /data/server/nginx/sbin/nginx -s stop
    echo "关闭django应用"
    kill $(lsof -Pti:8000)
}

#解压代码
untar_code(){
    echo "解压代码"
    tar xf django.tar.gz
}

#放置代码
put_code(){
    echo "放置代码"
    echo "备份老文件"
    mv /data/server/django_project/test.py /data/backup/test.py-$(date +%Y%m%d%H%M%S)
    echo "放置新文件"
    mv /data/codes/django_project/test.py /data/server/django_project/test.py
}

#开启应用
start_server(){
    echo "开启应用"
    echo "开启Django应用"
    source /data/virtual/venv/bin/activate
    cd /data/server/django_project/
    python manage.py runserver >> /dev/null 2>&1 &
    deactivate
    echo "开启nginx应用"
    /data/server/nginx/sbin/nginx
}

#检查
check(){
    echo "检查项目"
    netstat -tnulp | grep ':80'
}

#部署函数
deploy_pro(){
    get_code
    tar_code
    scp_code
    stop_server
    untar_code
    put_code
    start_server
    check
}

#主函数
main(){
    deploy_pro
}

#执行主函数
main
```

**9.2.3 增加日志功能**

**需求:**

- 追踪记录
- 数据说话

**方案**

- 增加日志功能
- 1.日志文件
  - /data/logs/deploy.log
- 2.日志格式
  - 日期  时间 脚本名称  步骤

**脚本实施:**

```shell
#!/bin/bash
#description: 打包代码
#script_name: deploy.sh
#author: Guang
#version: v 0.3
#e-mail: defaulttest@sina.com

LOG_FILE='/data/logs/deploy.log'
#增加日志功能
write_log(){
    DATE=$(date +%F)
    TIME=$(date +%T)
    step="$1"
    echo "${DATE} ${TIME} $0 : ${step}" >> "${LOG_FILE}"

}

#获取代码
get_code(){
    echo "获取代码"
    write_log "获取代码"
}

#打包代码
tar_code(){
    echo "打包代码"
    ssh root@des_ip "/bin/bash /data/scripts/tar_code.sh"
    write_log "打包代码"
}

#传输代码
scp_code(){
    echo "传输代码"
    cd /data/codes
    [ -f ddjango.tar.gz ] && rm -f django.tar.gz
    scp root@des_ip:/data/codes/django.tar.gz ./
    write_log "传输代码"
}

#关闭应用
stop_server(){
    echo "关闭应用"
    write_log "关闭应用"
    echo "关闭nginx应用"
    /data/server/nginx/sbin/nginx -s stop
    write_log "关闭nginx应用"
    echo "关闭django应用"
    kill $(lsof -Pti:8000)
    write_log "关闭Django应用"
}

#解压代码
untar_code(){
    echo "解压代码"
    tar xf django.tar.gz
    write_log "解压代码"
}

#放置代码
put_code(){
    echo "放置代码"
    write_log "放置代码"
    echo "备份老文件"
    mv /data/server/django_project/test.py /data/backup/test.py-$(date +%Y%m%d%H%M%S)
    write_log "备份老文件"
    echo "放置新文件"
    mv /data/codes/django_project/test.py /data/server/django_project/test.py
    write_log "放置新文件"
}

#开启应用
start_server(){
    echo "开启应用"
    write_log "开启应用"
    echo "开启Django应用"
    source /data/virtual/venv/bin/activate
    cd /data/server/django_project/
    python manage.py runserver >> /dev/null 2>&1 &
    deactivate
    write_log "开启Django应用"
    echo "开启nginx应用"
    /data/server/nginx/sbin/nginx
    write_log "开启nginx应用"
}

#检查
check(){
    echo "检查项目"
    netstat -tnulp | grep ':80'
    write_log "检查项目"
}

#部署函数
deploy_pro(){
    get_code
    tar_code
    scp_code
    stop_server
    untar_code
    put_code
    start_server
    check
}

#主函数
main(){
    deploy_pro
}

#执行主函数
main
```

**9.2.4 增加锁文件功能**

**需求**

- 同一个时间段内, 只允许一个用户来执行这个脚本
- 如果脚本执行的时候, 有人在执行, 那么**输出报错**: `脚本 xx.sh 正在执行,请稍后...`

**设计**

- 1.锁文件               `/tmp/deploy.pid`

- 2.存在锁文件时候,输出报错信息
- 3.脚本执行的时候,需要创建锁文件
- 4.脚本执行结束的时候,需要删除锁文件

**脚本实施**

```shell
#!/bin/bash
#description: 打包代码
#script_name: deploy.sh
#author: Guang
#version: v 0.4
#e-mail: defaulttest@sina.com

PID_FILE='/tmp/deploy.pid'
#增加锁文件功能
add_lock(){
    echo "增加锁文件"
    touch "${PID_FILE}"
    write_log "增加锁文件"
}

#删除锁文件功能
del_lock(){
    echo "删除锁文件"
    rm -rf "${PID_FILE}"
    write_log "删除锁文件"
}

LOG_FILE='/data/logs/deploy.log'

#脚本报错信息
err_msg(){
    echo "脚本 $0 正在运行, 请稍后..."
}

#增加日志功能
write_log(){
    DATE=$(date +%F)
    TIME=$(date +%T)
    step="$1"
    echo "${DATE} ${TIME} $0 : ${step}" >> "${LOG_FILE}"

}

#获取代码
get_code(){
    echo "获取代码"
    write_log "获取代码"
}

#打包代码
tar_code(){
    echo "打包代码"
    ssh root@des_ip "/bin/bash /data/scripts/tar_code.sh"
    write_log "打包代码"
}

#传输代码
scp_code(){
    echo "传输代码"
    cd /data/codes
    [ -f ddjango.tar.gz ] && rm -f django.tar.gz
    scp root@des_ip:/data/codes/django.tar.gz ./
    write_log "传输代码"
}

#关闭应用
stop_server(){
    echo "关闭应用"
    write_log "关闭应用"
    echo "关闭nginx应用"
    /data/server/nginx/sbin/nginx -s stop
    write_log "关闭nginx应用"
    echo "关闭django应用"
    kill $(lsof -Pti:8000)
    write_log "关闭Django应用"
}

#解压代码
untar_code(){
    echo "解压代码"
    tar xf django.tar.gz
    write_log "解压代码"
}

#放置代码
put_code(){
    echo "放置代码"
    write_log "放置代码"
    echo "备份老文件"
    mv /data/server/django_project/test.py /data/backup/test.py-$(date +%Y%m%d%H%M%S)
    write_log "备份老文件"
    echo "放置新文件"
    mv /data/codes/django_project/test.py /data/server/django_project/test.py
    write_log "放置新文件"
}

#开启应用
start_server(){
    echo "开启应用"
    write_log "开启应用"
    echo "开启Django应用"
    source /data/virtual/venv/bin/activate
    cd /data/server/django_project/
    python manage.py runserver >> /dev/null 2>&1 &
    deactivate
    write_log "开启Django应用"
    echo "开启nginx应用"
    /data/server/nginx/sbin/nginx
    write_log "开启nginx应用"
}

#检查
check(){
    echo "检查项目"
    netstat -tnulp | grep ':80'
    write_log "检查项目"
}

#部署函数
deploy_pro(){
	add_lock
    get_code
    tar_code
    scp_code
    stop_server
    untar_code
    put_code
    start_server
    check
    del_lock
}

#主函数
main(){
	if [ -f "${PID_FILE}" ]
	then
		err_msg
	else
    	deploy_pro
    fi
}

#执行主函数
main
```

**9.2.5 脚本流程知识点补充**

**需求**

- 1.如果我给脚本输入的参数是deploy，那么脚本才执行

- 2.否则提示该脚本的使用帮助信息，然后退出

  提示信息：脚本 deploy.sh 的使用方式： deploy.sh [ deploy ]

  ==补充知识== : `exit ` 退出

**分析：**

- 1.脚本传参，就需要在脚本内部进行调用参数

- 2.脚本的帮助信息

- 3.脚本内容就需要对传参的内容进行判断

**脚本实施**

```shell
#!/bin/bash
#description: 打包代码
#script_name: deploy.sh
#author: Guang
#version: v 0.5
#e-mail: defaulttest@sina.com

#脚本帮助信息
usage(){
    echo "脚本 $0 的使用方式: $0 [deploy]"
    exit
}

PID_FILE='/tmp/deploy.pid'
#增加锁文件功能
add_lock(){
    echo "增加锁文件"
    touch "${PID_FILE}"
    write_log "增加锁文件"
}

#删除锁文件功能
del_lock(){
    echo "删除锁文件"
    rm -rf "${PID_FILE}"
    write_log "删除锁文件"
}

LOG_FILE='/data/logs/deploy.log'

#脚本报错信息
err_msg(){
    echo "脚本 $0 正在运行, 请稍后..."
}

#增加日志功能
write_log(){
    DATE=$(date +%F)
    TIME=$(date +%T)
    step="$1"
    echo "${DATE} ${TIME} $0 : ${step}" >> "${LOG_FILE}"

}

#获取代码
get_code(){
    echo "获取代码"
    write_log "获取代码"
}

#打包代码
tar_code(){
    echo "打包代码"
    ssh root@des_ip "/bin/bash /data/scripts/tar_code.sh"
    write_log "打包代码"
}

#传输代码
scp_code(){
    echo "传输代码"
    cd /data/codes
    [ -f ddjango.tar.gz ] && rm -f django.tar.gz
    scp root@des_ip:/data/codes/django.tar.gz ./
    write_log "传输代码"
}

#关闭应用
stop_server(){
    echo "关闭应用"
    write_log "关闭应用"
    echo "关闭nginx应用"
    /data/server/nginx/sbin/nginx -s stop
    write_log "关闭nginx应用"
    echo "关闭django应用"
    kill $(lsof -Pti:8000)
    write_log "关闭Django应用"
}

#解压代码
untar_code(){
    echo "解压代码"
    tar xf django.tar.gz
    write_log "解压代码"
}

#放置代码
put_code(){
    echo "放置代码"
    write_log "放置代码"
    echo "备份老文件"
    mv /data/server/django_project/test.py /data/backup/test.py-$(date +%Y%m%d%H%M%S)
    write_log "备份老文件"
    echo "放置新文件"
    mv /data/codes/django_project/test.py /data/server/django_project/test.py
    write_log "放置新文件"
}

#开启应用
start_server(){
    echo "开启应用"
    write_log "开启应用"
    echo "开启Django应用"
    source /data/virtual/venv/bin/activate
    cd /data/server/django_project/
    python manage.py runserver >> /dev/null 2>&1 &
    deactivate
    write_log "开启Django应用"
    echo "开启nginx应用"
    /data/server/nginx/sbin/nginx
    write_log "开启nginx应用"
}

#检查
check(){
    echo "检查项目"
    netstat -tnulp | grep ':80'
    write_log "检查项目"
}

#部署函数
deploy_pro(){
	add_lock
    get_code
    tar_code
    scp_code
    stop_server
    untar_code
    put_code
    start_server
    check
    del_lock
}

#主函数
main(){
	case "$1" in
		"deploy")
		
            if [ -f "${PID_FILE}" ]
            then
                err_msg
            else
                deploy_pro
            fi
        ;;
        *)
        	usage
        ;;
        esac
}

#执行主函数
main $1
```

**9.2.6 输入参数安全优化**

**需求**

​	对脚本传入的参数的数量进行判断，如果参数数量不对，提示脚本的使用方式，然后退出

**脚本实施**

```shell
#!/bin/bash
#description: 打包代码
#script_name: deploy.sh
#author: Guang
#version: v 0.6
#e-mail: defaulttest@sina.com

#脚本帮助信息
usage(){
    echo "脚本 $0 的使用方式: $0 [deploy]"
    exit
}

PID_FILE='/tmp/deploy.pid'
#增加锁文件功能
add_lock(){
    echo "增加锁文件"
    touch "${PID_FILE}"
    write_log "增加锁文件"
}

#删除锁文件功能
del_lock(){
    echo "删除锁文件"
    rm -rf "${PID_FILE}"
    write_log "删除锁文件"
}

LOG_FILE='/data/logs/deploy.log'

#脚本报错信息
err_msg(){
    echo "脚本 $0 正在运行, 请稍后..."
}

#增加日志功能
write_log(){
    DATE=$(date +%F)
    TIME=$(date +%T)
    step="$1"
    echo "${DATE} ${TIME} $0 : ${step}" >> "${LOG_FILE}"

}

#获取代码
get_code(){
    echo "获取代码"
    write_log "获取代码"
}

#打包代码
tar_code(){
    echo "打包代码"
    ssh root@des_ip "/bin/bash /data/scripts/tar_code.sh"
    write_log "打包代码"
}

#传输代码
scp_code(){
    echo "传输代码"
    cd /data/codes
    [ -f ddjango.tar.gz ] && rm -f django.tar.gz
    scp root@des_ip:/data/codes/django.tar.gz ./
    write_log "传输代码"
}

#关闭应用
stop_server(){
    echo "关闭应用"
    write_log "关闭应用"
    echo "关闭nginx应用"
    /data/server/nginx/sbin/nginx -s stop
    write_log "关闭nginx应用"
    echo "关闭django应用"
    kill $(lsof -Pti:8000)
    write_log "关闭Django应用"
}

#解压代码
untar_code(){
    echo "解压代码"
    tar xf django.tar.gz
    write_log "解压代码"
}

#放置代码
put_code(){
    echo "放置代码"
    write_log "放置代码"
    echo "备份老文件"
    mv /data/server/django_project/test.py /data/backup/test.py-$(date +%Y%m%d%H%M%S)
    write_log "备份老文件"
    echo "放置新文件"
    mv /data/codes/django_project/test.py /data/server/django_project/test.py
    write_log "放置新文件"
}

#开启应用
start_server(){
    echo "开启应用"
    write_log "开启应用"
    echo "开启Django应用"
    source /data/virtual/venv/bin/activate
    cd /data/server/django_project/
    python manage.py runserver >> /dev/null 2>&1 &
    deactivate
    write_log "开启Django应用"
    echo "开启nginx应用"
    /data/server/nginx/sbin/nginx
    write_log "开启nginx应用"
}

#检查
check(){
    echo "检查项目"
    netstat -tnulp | grep ':80'
    write_log "检查项目"
}

#部署函数
deploy_pro(){
	add_lock
    get_code
    tar_code
    scp_code
    stop_server
    untar_code
    put_code
    start_server
    check
    del_lock
}

#主函数
main(){
	case "$1" in
		"deploy")
		
            if [ -f "${PID_FILE}" ]
            then
                err_msg
            else
                deploy_pro
            fi
        ;;
        *)
        	usage
        ;;
        esac
}

#执行主函数
if [ $# -eq 1 ]
then
	main $1
else
	usage
fi
```

##### 9.3 脚本调试功能

-n    检查脚本中的语法错误

-v    **先**显示脚本所有内容，**然后**执行脚本，结果输出，如果执行遇到错误，将错误输出。

-x    将执行的每一条命令和执行结果都打印出来

##### 9.4 生产脚本编写总结

**9.4.1 简单脚本编写总结**

1、手工执行的命令一定要可执行

2、命令简单罗列

3、固定的内容变量化

4、功能函数化

**9.4.2 复杂脚本编写总结**

1、手工执行的命令一定要可执行

2、根据发布流程编写脚本的框架

3、将手工执行的命令填充到对应的框架函数内部

4、增加日志功能，方便跟踪脚本历史执行记录

5、主函数中逻辑流程控制好

6、设计安全的方面：

- 增加锁文件，保证代码发布的过程中不受干扰，

- 输入参数数量

- 输入参数匹配

- 脚本帮助信息

7、调试脚本

**9.4.3 注意事项**

1、命令一定要保证能正常执行

2、成对的符号，要成对写，避免丢失

3、函数调用，写好函数后，一定要在主函数中进行调用

4、避免符号出现中文

5、命令变量的写法一定要规范

6、固定的内容一定要变量实现，方便以后更改

7、日志的输出

8、脚本的传参和函数的传参要区别对待