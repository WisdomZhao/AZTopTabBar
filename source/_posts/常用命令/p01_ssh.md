---
title: SSH
toc: false
date: 2018-02-04 10:37:50
tags: [command]
---

## 免ssh输入密码
```
scp /Users/zhaozh/.ssh/id_rsa.pub root@10.0.63.238:/root/.ssh/authorized_keys
```

## 免输入passphrase
```
ssh-add -K ~/.ssh/id_rsa
```

## 上传和下载文件
```
// 上传
scp /Users/zhaozh/Documents/06_company/packages/ota/online/prepare.ipa root@10.0.63.238:/opt/mycompany/ios-build/online

// 下载
scp root@10.0.63.238:/opt/mycompany/ios-build/online/demo.txt /Users/zhaozh/Documents/06_company/packages/ota/online/
```