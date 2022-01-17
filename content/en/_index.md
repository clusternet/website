---
title: Clusternet Homepage
description: Hugo zzo, zdoc theme documentation home page
date: 2022-01-16
draft: false

landing:
  height: 400
  image: logo.png
  title:
    - Clusternet
  text:
    - Managing your Kubernetes clusters (including public, private, edge, etc) as easily as visiting the Internet ⎈
  titleColor: "#096fff"
  textColor:
  spaceBetweenTitleText: 25
  buttons:
    - link: docs
      text: Learn More
      color: primary
      icon: icons/document-white.png
    - link: https://github.com/clusternet/clusternet
      text: Download
      color: default
      icon: icons/GitHub.png

footer:
  sections:
    - title: General
      links:
        - title: Documentation
          link: /documentation/
        - title: Releases
          link: /releases/
        # - title: Blog
        #  link: https://gohugo.io/
    - title: Resources
      links:
        - title: GitHub
          link: https://github.com/clusternet/clusternet
        - title: Helm Charts
          link: https://github.com/clusternet/charts
        - title: Command Line Tool (kubectl-clusternet)
          link: https://github.com/clusternet/kubectl-clusternet
    - title: Contacts
      links:
        - title: GitHub Issues
          link: https://github.com/clusternet/clusternet/issues/new/choose
        - title: Google Group
          link: https://groups.google.com/g/clusternet
        # - title: Slack
        #   link: https://gohugo.io/
  contents:
    align: left
    applySinglePageCss: false
    markdown:
      |
      ## Clusternet
      Copyright 2021 The Clusternet Authors & ©THL A29 Limited, a Tencent company. All Rights Reserved. [LICENSE](https://github.com/clusternet/clusternet/blob/main/LICENSE)

sections:
  - bgcolor: "#148D8D"
    type: card
    description: "An open-source project that helps users manage multiple Kubernetes clusters as easily as 'visiting the Internet' (thus the name 'Clusternet'). It is a general-purpose system for controlling Kubernetes clusters across different environments as if they were running locally."
    header:
      title: What is Clusternet
      hlcolor: "#EFBC75"
      color: '#fff'
      fontSize: 32
      width: 360
    rows:
      - description: row 1
        cards:
          - subtitle: Multi-cluster Management
            subtitlePosition: center
            description: "Manages multiple Kubernetes clusters from a single management cluster."
            image: icons/clusters.png
            color: white
          - subtitle: Kubernetes Native
            subtitlePosition: center
            description: "Out-of-the-box add-on to empower standard Kubernetes clusters"
            image: icons/kubernetes.png
            color: white
          - subtitle: For all Cloud Categories
            subtitlePosition: center
            description: "Manages Kubernetes clusters across public, private, hybrid, and edge clouds."
            image: icons/cloud.png
            color: white
      - description: row 2
        cards:
          - subtitle: Application Management
            subtitlePosition: center
            description: "Two-tier application configuration for cluster-specific values."
            image: icons/application-management.png
            color: white
          - subtitle: RBAC Support
            subtitlePosition: center
            description: "Support accessing all managed clusters with RBAC."
            image: icons/lock.png
            color: white
          - subtitle: CLI Support
            subtitlePosition: center
            description: "Command line interface installable via Krew."
            image: icons/cli.png
            color: white

  - bgcolor: "#1A4A5A"
    type: card
    # description: ""
    header:
      title: Join Us
      hlcolor: "#C1E1A7"
      color: "#fff"
      fontSize: 32
      width: 170
    rows:
      - description: row 1
        cards:
          - subtitle: Community Forum
            subtitlePosition: center
            description: "Follow our [Google Group](https://groups.google.com/g/clusternet) for announcements and technical Discussions."
            image: icons/groups.png
            color: white
          - subtitle: Contributing
            subtitlePosition: center
            description: "Create a [Pull Request](https://github.com/clusternet/clusternet/pulls) on GitHub to get started.
New users are always welcome!"
            image: icons/GitHub.png
            color: white
          - subtitle: Reporting Issues
            subtitlePosition: center
            description: "If you encounter any issues, feel free to open an [issue](https://github.com/clusternet/clusternet/issues/new/choose)."
            image: icons/chat.png
            color: white

          # - subtitle: Join us on Slack
          #   subtitlePosition: center
          #   description: "Join [Clusternet Slack]() for live conversation and quick questions."
          #   image: icons/root-server.png
          #   color: white

---
