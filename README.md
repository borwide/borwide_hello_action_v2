## 概要
这是一个调用github action的模板，代码采用rust技术栈。
目前实现linux下rust编译与打包

## 编译
```bash
cargo build --release
cargo build --release --target=aarch64-unknown-linux-gnu
```

## 打包
```bash
docker build -t borwide/hello_action:latest .
docker buildx build --platform linux/amd64,linux/arm64 -t borwide/hello_action:latest --push .
```
## TODO
- [x] 交叉编译
- [ ] 打包成Docker
