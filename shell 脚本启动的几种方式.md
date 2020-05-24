

sh只是一个符号链接，最终指向是一个叫做dash的程序，自Ubuntu 6.10以后，系统的默认shell /bin/sh被改成了dash。dash(the Debian Almquist shell) 是一个比bash小很多但仍兼容POSIX标准的shell，它占用的磁盘空间更少，执行shell脚本比bash更快，依赖的库文件更少，当然，在功能上无法与bash相比。dash来自于NetBSD版本的Almquist Shell(ash)。

Ubuntu中将默认shell改为dash的主要原因是效率。由于Ubuntu启动过程中需要启动大量的shell脚本，为了优化启动速度和资源使用情况，Ubuntu做了这样的改动。


### sh 
这种方式直接运行该脚本，会创建一个子shell，并在子shell中逐个执行脚本中的指令； 而子shell从父shell中继承了环境变量，但是执行后不会改变父shell的环境变量；可以这样理解：在子shell中的操作和环境变量不会影响父进程，在执行完shell后又回到了父进程。
   
### source 
采用第二种方法运行该脚本，source命令是在当前shell环境下执行该脚本，不会创建子shell，因而可以在shell中进入到指定目录中。

source命令又称为点命令，作用：在当前shell环境下读取并执行脚本中的命令，通常用于重新执行刚修改过的初始化文件，使之立即生效，而不必注销并登录。
