# SaemalPuri v1.0

这是 `새말풀이` iOS 词典 App 的 v1.0 工程。它包含 SwiftUI 原生界面、本地 JSON 词库、搜索、分类分组和详情页。

## 最省事的 IPA 路线：GitHub Actions 自动打包

这个包已经内置 `.github/workflows/build-unsigned-ipa.yml`，可以在 GitHub 的 macOS runner 上自动生成 **unsigned IPA**。

步骤：

1. 在 GitHub 新建一个空仓库，例如 `SaemalPuri`。
2. 把本文件夹里的所有内容上传到仓库根目录。
3. 打开仓库页面：`Actions` → `Build unsigned IPA` → `Run workflow`。
4. 等构建完成后，在页面底部 `Artifacts` 下载 `SaemalPuri_unsigned_ipa`。
5. 解压后得到 `SaemalPuri_unsigned.ipa`。
6. 用 Sideloadly / AltStore / SideStore 自签安装。

> 注意：这个 IPA 是未签名包，不能直接安装到 iPhone。它是给 Sideloadly、AltStore、SideStore 这类工具重新签名用的。

## 本地 Mac 打包路线

如果以后有 Mac，也可以在项目根目录运行：

```bash
./scripts/build_unsigned_ipa.sh
```

会生成：

```text
SaemalPuri_unsigned.ipa
```

## 工程文件

```text
SaemalPuri.xcodeproj
SaemalPuri/SaemalPuriApp.swift
SaemalPuri/ContentView.swift
SaemalPuri/WordEntry.swift
SaemalPuri/WordDetailView.swift
SaemalPuri/WordStore.swift
SaemalPuri/words.json
.github/workflows/build-unsigned-ipa.yml
scripts/build_unsigned_ipa.sh
```

## 修改词库

打开：

```text
SaemalPuri/words.json
```

继续追加词条即可。注意 JSON 规则：前一个词条后面要加逗号，最后一个词条后面不要加逗号。

## 当前功能

- 本地 `words.json` 词库
- 分类分组
- 搜索
- 详情页
- 卡片式详情 UI
- 文本可复制
- GitHub Actions 自动生成 unsigned IPA
