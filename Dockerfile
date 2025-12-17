# 支持多架构构建的Dockerfile
# docker buildx build --platform linux/amd64,linux/arm64 -t borwide/httptouchdocker:latest --push .

# 使用Ubuntu 24.04作为基础镜像
FROM ubuntu:24.04

# 安装必要的依赖
#RUN apt-get update && apt-get install -y \
#    ca-certificates \
#    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 根据架构复制相应的二进制文件
ARG TARGETARCH

# 复制x64二进制文件
COPY --chmod=755 ./target/release/hello_action ./httptouchdocker-amd64

# 复制arm64二进制文件
COPY --chmod=755 ./target/aarch64-unknown-linux-gnu/release/hello_action ./httptouchdocker-arm64

# 根据架构选择正确的二进制文件
RUN if [ "$TARGETARCH" = "amd64" ]; then \
        mv ./httptouchdocker-amd64 ./httptouchdocker; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        mv ./httptouchdocker-arm64 ./httptouchdocker; \
    else \
        echo "Unsupported architecture: $TARGETARCH" && exit 1; \
    fi

# 清理临时文件
RUN rm -f ./httptouchdocker-amd64 ./httptouchdocker-arm64

# 复制配置文件
# COPY config.toml .

# 暴露HTTP端口
EXPOSE 5080

# 运行应用
CMD ["./httptouchdocker"]
