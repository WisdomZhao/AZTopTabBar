---
title: cocoapods 
toc: false
date: 2018-02-04 10:37:50
tags: [command]
---

##常用命令

```
pod install --verbose --no-repo-update
pod update --verbose --no-repo-update
pod lib lint --verbose
pod trunk push AppInfoTracker.podspec
pod search AppInfoTracker
pod trunk me
pod setup
ls -al ~/.cocoapods/repos/
pod trunk push
pod repo update --verbose
```

##常见问题

###`pod install` 失败原因

- 可能是网络问题，重启teminal

###`pod search` 来搜索类库信息时出错

相信有的小伙伴已经成功安装了CocoaPods，也可以正常使用，然而会发现执行`pod search`来搜索类库信息时，却总是
`[!]Unable to find a pod with name, author, summary, or descriptionmatching '······'`

前提：成功安装CocoaPods，不能pod search搜素类库的情况

1. 执行pod setup
    * 其实在你安装CocoaPods执行pod install时，系统会默认操作pod setup，然而由于中国强大的墙可能会pod setup不成功。这时就需要手动执行pod setup指令，如下：
    * 终端输入：pod setup
    * 会出现Setting up CocoaPods master repo，稍等几十秒，最底下会输出Setup completed。说明执行pod setup成功。
    * 如果pod search操作还是搜索失败，如下：
    * 终端输入：pod search AFNetworking
    * 输出：Unable to find a pod with name, author, summary, or descriptionmatching 'AFNetworking' 这时就需要继续下面的步骤了。
2. 删除~/Library/Caches/CocoaPods目录下的search_index.json文件
    * pod setup成功后，依然不能pod search，是因为之前你执行pod search生成了search_index.json，此时需要删掉。
    * 终端输入：rm ~/Library/Caches/CocoaPods/search_index.json
    * 删除成功后，再执行pod search。
3. 执行pod search
    * 终端输入：pod search afnetworking(不区分大小写)
    * 输出：Creating search index for spec repo 'master'..Done!，稍等片刻······就会出现所有带有afnetworking字段的类库。
