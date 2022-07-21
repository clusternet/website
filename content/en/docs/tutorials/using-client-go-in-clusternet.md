---
title: "client-go 支持"
description: "使用 client-go 与 Clusternet 交互"
date: 2022-01-17
draft: false
weight: 4
collapsible: false
---

如果你想使用 client-go 与 Clusternet 交互，你只需要在你的代码中插入下面的 `wrapperFunc`，其余的保持不变。

```go
// 只需添加如下代码
config.Wrap(func(rt http.RoundTripper) http.RoundTripper {
    return clientgo.NewClusternetTransport(config.Host, rt)
})
```

您可以查阅 [demo.go](https://github.com/clusternet/clusternet/blob/main/examples/clientgo/demo.go) 以快速入门。
