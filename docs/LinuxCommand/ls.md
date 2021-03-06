# ls

## 1. 命令格式

ls [选项] [目录名]

## 2. 基本功能

列出目标目录中所有的子目录和文件

## 3. 常用参数

-a, --all 列出包括.开头的隐含文件在内的所有文件

-A, --almost-all 同上但除去.和..这两个目录

-c 根据配合参数不同，有不同效果：

> 配合 -lt：根据 ctime 排序及显示 ctime (文件状态最后更改的时间)
>
> 配合 -l：显示 ctime 但根据名称排序
>
> 否则：根据 ctime 排序

-C 每栏由上至下列出项目

--color[=WHEN] 控制是否使用色彩分辨文件。WHEN 可以是'never'、'always'或'auto'其中之一

-d, --directory 将目录象文件一样显示，而不是显示其下的文件。

-D, --dired 产生适合 Emacs 的 dired 模式使用的结果

-f 对输出的文件不进行排序（ls默认以文件名进行排序），-aU 选项生效，-lst 选项失效

-g 类似 -l,但不列出所有者

-G, --no-group 不列出任何有关组的信息

-h, --human-readable 以容易理解的格式列出文件大小 (例如 1K 234M 2G)

--si 类似 -h,但文件大小取 1000 的次方而不是 1024

-H, --dereference-command-line 使用命令列中的符号链接指示的真正目的地

--indicator-style=<方式> 指定在每个项目名称后加上指示符号<方式>：none (默认)，classify (-F)，file-type (-p)

-i, --inode 印出每个文件的 inode 号

-I, --ignore=PATTERN 不印出任何符合 shell 万用字符<样式>的项目

-k 即 –block-size=1K,以 k 字节的形式表示文件的大小。

-l 除了文件名之外，还将文件的权限、所有者、文件大小等信息详细列出来。

-L, –dereference 当显示符号链接的文件信息时，显示符号链接所指示的对象而并非符号链接本身的信息

-m 所有项目以逗号分隔，并填满整行行宽

-o 类似 -l,显示文件的除组信息外的详细信息。

-r, –reverse 依相反次序排列

-R, –recursive 同时列出所有子目录层

-s, –size 以块大小为单位列出所有文件的大小

-S 根据文件大小排序

--sort=WORD 以下是可选用的 WORD 和它们代表的相应选项：

> extension -X status -c
>
> none -U time -t
>
> size -S atime -u
>
> time -t access -u
>
> version -v use -u

-t 以文件修改时间排序

-u

> 配合 -lt:显示访问时间而且依访问时间排序
>
> 配合 -l:显示访问时间但根据名称排序
>
> 否则：根据访问时间排序

-U 不进行排序;依文件系统原有的次序列出项目

-v 根据版本进行排序

-w, --width=COLS 自行指定屏幕宽度而不使用目前的数值

-x 逐行列出项目而不是逐栏列出

-X 根据扩展名排序

-1 每行只列出一个文件

--help 显示此帮助信息并离开

--version 显示版本信息并离开

## 4. 注意事项

在使用 ls 命令时要注意命令的格式：在命令提示符后，首先是命令的关键字，接下来是命令参数，在命令参数之前要有一短横线“-”，所有的命令参数都有特定的作用，自己可以根据需要选用一个或者多个参数，在命令参数的后面是命令的操作对象。使用多个参数时也可以一个“-”后连接所有命令参数。操作对象不在当前路径则需要给出完整路径。

## 5. 常用形式

直接使用`ls`：

```console
$ ls
file_1.txt file_2.txt
```

使用`ls -al`列出全部文件的详细信息：
其中第1列表示用户对文件拥有的权限，第2列表示引用计数，第3列表示文件的所有者（默认所有者是文件的建立用户），第4列表示所属组，第5列表示文件大小，第6列表示文件修改时间（而非文件创建时间），第7列表示文件名/目录名。

```console
$ ls -al
total 8
drwxr-xr-x  2 root root 4096 Jul  1 09:48 .
drwx------ 13 root root 4096 Jul  1 09:50 ..
-rw-r--r--  1 root root    0 Jul  1 09:48 file_1.txt
-rw-r--r--  1 root root    0 Jul  1 09:48 file_2.txt
```

使用`ls -ahl`列出全部文件的详细信息，并以human-readable形式呈现：

```console
total 8.0K
drwxr-xr-x  2 root root 4.0K Jul  1 09:48 .
drwx------ 13 root root 4.0K Jul  1 09:50 ..
-rw-r--r--  1 root root    0 Jul  1 09:48 file_1.txt
-rw-r--r--  1 root root    0 Jul  1 09:48 file_2.txt
```

如要列出列出以file开头的文件信息则可用：`ls -l file*`

列出/home文件下的子目录可用命令:`ls -F /home | grep /$`，或使用`ls -l /home | grep "^d"`列出详细情况

`-ltr`的命令可以让越新的文件排在越后面

如果要计算当前目录下的文件数用`ls  -l * |grep "^-"|wc -l`，计算目录个数用`ls -l * |grep "^d"|wc -l`
