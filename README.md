# 说明

## 仓库来源
https://github.com/cookieY/Yearning/releases/tag/2.3.2.1

## 改动说明
### 问题   
官方的dockerfile中的入口命令有误，导致无法正常运行，可参考: https://github.com/cookieY/Yearning/issues/445  

### 修改说明
为了能够区分执行install和run命令，修改了如下文件：
1）`Dockerfile`： 执行我们自己的入口脚本    
2) 添加 `docker-entrypoint.sh`    
3）添加文件`install_flag`用于标记是否安装初始化了数据库表；    

**逻辑说明：**
* 添加了一个 install_flag 的配置文件，用于记录是否已经执行过安装命令；
* install_flag 文件只能有一行内容（首尾无空格），如下：   
```properties
installed=true
```
* 使用时需要将此文件挂载到容器的 `/opt/install_flag` 位置；

**docker-entrypoint.sh 执行的逻辑：**
1. 读取 install_flag 中的true/false的值；
2. 如果为false，则执行 install，然后执行run；然后将install_flag中的值改为true
3. 如果为true，则直接执行run；
4. 未读取到install_flag 文件则直接run；


## 构建镜像
```shell script
docker build -t yearning:latest ./
```

## 运行
如需执行安装步骤，需要手动将instal_flag中的true改为false。
如需执行安装步骤，需要手动将instal_flag中的true改为false。
如需执行安装步骤，需要手动将instal_flag中的true改为false。
```shell script
docker-compose up
```