# jupyter-notebook
把jupyter-notebook装进docker里

### Jupyter
+ [RISE](https://github.com/damianavila/RISE) (制作网页 PPT )

### 镜像目前提供的 python 第三方库列表
+ numpy
+ pandas
+ pillow
+ requests
+ matplotlib

### 部署
1. 获取镜像
- 方案一: 从阿里云上拉取 Jupyter 镜像（推荐）
```
$ docker pull registry.cn-hangzhou.aliyuncs.com/diy/jupyter-notebook
$ docker tag registry-internal.cn-hangzhou.aliyuncs.com/diy/jupyter-notebook:[TAG] jupyter-notebook:latest  # 镜像重命名
```
- 方案二: 克隆 + 编译, 得到 Jupyter 镜像（时间比较长）
```
$ git clone https://github.com/hugoxia/jupyter-notebook.git
$ cd jupyter-notebook && docker build -t jupyter-notebook .
```

2. 运行镜像
```
$ docker run --name jupyter -p 10088:8888 --restart=always -v jupyter-dir:/home/ -d jupyter-notebook
```
3. 进入容器
```
$ docker exec -it jupyter bash
```
4. 设置jupyter的登陆密码
```
$ jupyter notebook password
Enter password:
Verify password:
[NotebookPasswordApp] Wrote hashed password to /root/.jupyter/jupyter_notebook_config.json
```
5. 退出容器, 重启容器服务
```
$ exit
$ docker restart jupyter
```
6. 访问浏览器 http://127.0.0.1:10088/ 见证奇迹的时刻，127.0.0.1 要替换成你的 ip

### 使用 Caddy 作为反向代理
```
# /etc/caddy/Caddyfile
www.yourdomain.com:80, www.yourdomain.com:443 {
    tls youremail@126.com
    gzip
    proxy / localhost:10088 {
        header_upstream Connection {>Connection}
        header_upstream Upgrade {>Upgrade}
        header_upstream Host {host}
        header_upstream X-Real-IP {remote}
        header_upstream X-Forwarded-For {remote}
        header_upstream X-Forwarded-Proto {scheme}
    }
}
```
