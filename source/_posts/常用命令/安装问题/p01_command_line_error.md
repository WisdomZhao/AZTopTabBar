---
title: brew install error
toc: false
date: 2018-02-04 10:37:50
tags: [配置错误]
---


##brew install python3

```
Error: /usr/local/Cellar is not writable. You should change the
ownership and permissions of /usr/local/Cellar back to your
user account:
   sudo chown -R $(whoami) /usr/local/Cellar
Error: Cannot write to /usr/local/Cellar
```
解决办法 ``sudo chown -R $USER /usr/local``
