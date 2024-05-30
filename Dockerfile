# 第1阶段
FROM node AS buildDIR
WORKDIR /build_app

# RUN apt-get update && apt-get install -y git
# RUN git clone

# install git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh |  bash
RUN apt-get install -y git-lfs

# COPY . .

# RUN npm install && npm run build

# 第2阶段
FROM nginx

# 将第一阶段 [buildDIR] 的构建目录 /build_app/dist 拷贝到 nginx
COPY --from=buildDIR /build_app/dist /usr/share/nginx/html/

# 将本地nginx配置，替换容器里的默认配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

# 启动nginx
CMD ["nginx", "-g", "daemon off;"]
