## 鸣谢

- [P3TERX/aria2.conf](https://github.com/P3TERX/aria2.conf)  依靠来自P3TERX大佬的Aria2脚本，实现了Aria2下载完成自动触发Rclone上传。


## 概述

本容器集成了Aria2+WebUI、Aria2+Rclone联动自动上传功能、可自定义的导航页、Filebrowser轻量网盘。

![image](https://user-images.githubusercontent.com/98247050/163658943-4df3e534-248a-46c5-b832-bfa6957c46c8.png)
 
 1. 开箱即用，只需要准备rclone.conf配置文件, 容器一切配置都预备齐全。
 2. AMD64/i386/Arm64/Armv7多架构支持。
 3. 由caddy反代所有web服务和远程控制路径，均有密码保护，可自定义基础URL防爆破，并可使用caddy的自动https功能。
 4. 可自定义内容导航页，显示当前容器运行信息。
 5. Aria2和Rclone多种联动模式，有BT下载完成做种前立即开始上传功能，适合有长时间做种需求的用户。
 6. 独立的Rclone容器以daemon方式运行，方便实时在WebUI上监测传输情况，可在docker-compose文件中自定义运行参数。
 7. 基于 [runit](http://smarden.org/runit/index.html) 的进程管理，每个进程可以独立启停，互不影响。
 8. 所有配置集中于config数据卷，方便迁移。
 9. 支持PUID/GUID方式以非root用户运行容器内进程。

## 快速部署
 
 1. 建议使用docker-compose方式部署，方便修改变量配置。
 2. 下载[docker-compose文件](https://raw.githubusercontent.com/wy580477/Aria2-AIO-Container/master/docker-compose.yml)
 3. 按说明设置好变量，用如下命令运行容器。
```
docker-compose up -d
```
 4. 按ip地址或域名+基础URL就可打开导航页，随后打开AriaNg，将变量中的密码填入AriaNg设置中的RPC密钥即可连接Aria2。
 5. 打开Filebrowser页面，将事先准备好的rclone.conf配置文件上传到config目录下，运行如下命令重启容器即可让Aria2—Rclone联动功能生效。
```
docker restart allinone
```

### 更多用法和注意事项
 5. config/aria2目录下为Aria2相关配置文件，按语言变量选择版本进行修改。   
    script.conf为Aria2自动化配置文件，可以更改文件自动清理设置和指定Rclone上传目录。   
    执行tracker.sh可自动下载tracker列表添加到aria2配置文件，注意这样会覆盖原来的tracker列表。
    
 


