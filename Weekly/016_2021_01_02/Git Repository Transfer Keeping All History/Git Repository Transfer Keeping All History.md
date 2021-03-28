[Original Link](https://itnext.io/git-repository-transfer-keeping-all-history-670fe04cd5e4)

# Git Repository Transfer Keeping All History
## Introduction
Bài viết giới thiệu cách để transfer git repo mà vẫn giữ nguyên history

## 1. Tạo ra minor cloned của repo cũ
```sh
git clone --mirror old-repo-url new-repo
```
## 2. Remove remote reference đến repo cũ
```sh
cd new-repo
git remote remove origin
```
## 3. Add remote reference đến new repo
```sh
git remote add origin new-repo-url
```
## 4. Push mọi thứ lên new repo
```sh
git push --all
git push --tags
```
## 5. Clone new repo
```sh
cd ..
rm -rf new-repo
git clone new-repo-url new-repo
```