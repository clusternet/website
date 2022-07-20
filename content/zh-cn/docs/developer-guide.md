---
title: "开发者指南"
description: "如何开发 Clusternet"
date: 2022-01-17
draft: false
weight: 10
---

首先，请确保您有一个可用的 [Go 环境](https://golang.org/doc/install) 和 [Docker 环境](https://docs.docker.com/engine) 。

## 克隆 Clusternet

克隆代码仓库

```bash
mkdir -p $GOPATH/src/github.com/clusternet/
cd $GOPATH/src/github.com/clusternet/
git clone https://github.com/clusternet/clusternet
cd clusternet
```

## 构建二进制文件

运行

```bash
# 基础环境默认为 linux/amd64 
make clusternet-agent clusternet-hub clusternet-scheduler
```

基于“linux/amd64”架构构建了二进制文件“clusternet-agent”、“clusternet-hub”和“clusternet-scheduler”。

您还可以在构建时指定其他平台，例如，

```bash
# 基于 linux/arm64 和 darwin/amd64 来构建 clusternet-agent
# 使用逗号分隔多个平台
PLATFORMS=linux/arm64,darwin/amd64 make clusternet-agent
# 支持以下平台
# PLATFORMS=darwin/amd64,darwin/arm64,linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm
```

所有构建的二进制文件都将放置在 `_output` 文件夹中。

## 构建 docker 镜像

您还可以构建 docker 映像。 这里 `docker buildx` 用于帮助构建多架构容器镜像。

如果您运行的是 MacOS，请安装 [Docker Desktop](https://docs.docker.com/desktop/)， 然后检查构建器。

```bash
$ docker buildx ls
NAME/NODE DRIVER/ENDPOINT STATUS  PLATFORMS
default * docker
  default default         running linux/amd64, linux/arm64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6
```

如果您运行的是 Linux，请参考 [docker buildx docs](https://docs.docker.com/buildx/working-with-buildx/) 进行安装。

> 注意:
>
> 为了更好地支持 docker buildx ，建议使用 Ubuntu Focal 20.04 (LTS)、Debian Bullseye 11 和 CentOS 8。
>
> 并安装 deb/rpm 包：`qemu-user-static`，例如
> ```bash
> apt-get install qemu-user-static
> ```
> or
> ```bash
> yum install qemu-user-static
> ```

```bash
# 默认基于 linux/amd64 架构构建
# 构建 clusternet-agent, clusternet-hub and clusternet-scheduler 镜像
make images
```

你也可以为其他平台构建容器镜像，例如`arm64`，

```bash
PLATFORMS=linux/amd64,linux/arm64,linux/ppc64le make images
# 支持以下平台
# PLATFORMS=linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm
```
