## 鸣谢

- [P3TERX/aria2.conf](https://github.com/P3TERX/aria2.conf)  依靠来自P3TERX大佬的Aria2脚本，实现了Aria2下载完成自动触发Rclone上传。


## 概述

基于本人 [Aria2-AIO-Container](https://github.com/wy580477/Aria2-AIO-Container) Aria2全能容器项目精简而来，适合已经部署了Web服务的情况下配置反代使用。
集成了Aria2和经过修改的P3TERX大佬Aria2自动化脚本，与[Rclone-Daemon-Container](https://github.com/wy580477/Aria2-AIO-Container)配合，实现自动化上传功能。
 
 1. 开箱即用，只需要准备rclone.conf配置文件, 容器一切配置都预备齐全。
 2. AMD64/i386/Arm64/Armv7/Armv6/s390x/ppc64le多架构支持。
 3. Aria2和Rclone多种联动模式，有BT下载完成做种前立即开始上传功能，适合有长时间做种需求的用户。
 4. 独立的Rclone容器以daemon方式运行，支持自动开启Web UI服务，可在docker-compose文件中自定义运行参数。
 5. 使用Rclone RC界面传递命令，Aria2和Rclone可以部署在不同的host上，更加灵活。
 6. 所有配置集中于config数据卷，方便迁移。
 7. 支持PUID/GUID方式以非root用户运行容器内进程。

## 快速部署
 
 1. 建议使用docker-compose方式部署，方便修改变量配置。
 2. 下载[docker-compose文件](https://github.com/wy580477/Aria2-Container-for-Rclone/blob/dev/docker-compose.yml)
 3. 按说明设置好变量，用如下命令运行容器。
```
docker-compose up -d
```
 4. 将rclone.conf文件上传到指定的config目录，联动功能即可正常工作。
 5. 按docker-compose文件默认网络设置部署完成后，Aria2 RPC地址为
```
http://localhost:6800/jsonrpc
``` 
   Rclone RC地址为：
```
http://localhost:56802
```
### 更多用法和注意事项
  - config/aria2目录下为Aria2相关配置文件，默认使用aria2.conf英文版本，可以用aria2_chs.conf中文版本重命名覆盖替换。  
  - script.conf为Aria2自动化配置文件，可以更改文件自动清理设置和指定Rclone上传目录。   
  - 执行tracker.sh可自动下载tracker列表添加到aria2配置文件，注意这样会覆盖原来的tracker列表。
  
 


