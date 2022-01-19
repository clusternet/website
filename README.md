# Clusternet Documentation

This repository contains the assets to build the Clusternet website hosted at https://clusternet.io.

## Requirements

Install [Hugo (extended version)](https://gohugo.io/getting-started/installing) with the version specified in the [netlify.toml](netlify.toml)

## Getting Started

### 1. Clone this repo and its submodules
```console
git clone https://github.com/clusternet/website.git
cd website
make load-submodule
```

### 2. Serve the site locally
```console
make serve
```

Changes will be refreshed in real-time at http://localhost:1313

## Modifying the Documentation

* English: `content/en/documentation`
* Assets: **Attached images** in the docs should be put in folder `static`.

Netlify will be triggered to build a preview site by every PR. After merging into `main` branch, site https://clusternet.io will be automatically published by Netlify.
