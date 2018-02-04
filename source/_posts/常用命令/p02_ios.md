---
title: iOS
toc: false
date: 2018-02-04 10:37:50
tags: [command]
---

## 验证域名是否支持ATS
```
nscurl --ats-diagnostics https://www.baidu.com --verbose
```

## 检查IDFA的方法

步骤：

+  打开终端cd到要检查的文件的根目录。
+  执行下列语句：

```
grep -r advertisingIdentifier . （别少了最后那个点号）
find . | grep -v .svn | grep ".a" | grep -v ".app" | xargs grep
	advertisingIdentifier
```

## 多语言

将 NSLocalizedString 的 key 提取到 strings文件里

```
find . -name *.swift | xargs genstrings -o TVService/Resources/fr.lproj/
```


##代码行数
```
find . "(" -name "*.m" -or -name "*.mm" -or -name "*.cpp" -or -name "*.h" -or -name "*.rss" ")" -print | xargs wc -l
```