[Original Link](https://benscheirman.com/2020/10/managing-version-numbers-with-fastlane/)

# Managing Version Numbers with Fastlane
## Introduction
Bài viết chủ yếu trình bày cách tự động tăng version bằng fastlane command line tool.

## Bump version
```sh
increment_version_number(bump_type: part)
```
Câu lệnh này sẽ tăng number của part tương ứng lên 1 đơn vị. Part có thể là major, minor hoặc patch tuỳ bạn muốn nâng phần nào của version.
```sh
%w{major minor patch}.each do |part|
  lane "bump_#{part}".to_sym do
    increment_version_number(bump_type: part)
  end
end
```

Đoạn script trên sẽ định nghĩa 3 lane mà bạn có thể dùng để tăng major, minor hoặc patch.
Sau khi chạy đoạn script trên thì bạn sẽ có 3 lane như sau:
```sh
bump_major
bump_minor
bump_patch
```

## Cho phép nhập version number
```sh
private_lane :prompt_for_marketing_version do |options|
  marketing_version = get_version_number
  new_version = UI.input("What marketing version? <enter to keep it at #{marketing_version}>")
  unless new_version.strip == ""
    increment_version_number(version_number: new_version)
    UI.message("Version number set to #{new_version}")
    marketing_version = new_version
  end
end
```

## Commit version change và tag commit
```sh
if UI.confirm "Commit version bump and Tag this version?"
  commit_version_bump
  add_git_tag(tag: lane_context[SharedValues::VERSION_NUMBER])
  push_git_tags
end
```