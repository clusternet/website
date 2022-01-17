---
title: "client-go Support"
description: "Using client-go to interact with Clusternet"
date: 2022-01-17
draft: false
weight: 4
collapsible: false
---

# Using Client-Go in Clusternet

If you want to use [client-go](https://github.com/kubernetes/client-go) to interact with Clusternet, you only need to
insert below `wrapperFunc` in your codes, while the rest remains the same.

```go
// This is the ONLY place you need to wrap for Clusternet
config.Wrap(func(rt http.RoundTripper) http.RoundTripper {
    return clientgo.NewClusternetTransport(config.Host, rt)
})
```

You can follow [demo.go](https://github.com/clusternet/clusternet/blob/main/examples/clientgo/demo.go) for a quick start.
