[Original Link](https://betterprogramming.pub/how-to-build-an-lru-cache-in-less-than-10-minutes-and-100-lines-of-code-fddad56d7af5)

# How to Build an LRU Cache in Less Than 10 Minutes and 100 Lines of Code
## Introduction
Bài viết giới thiệu về __Least Recenty Used Cache (LRU Cache)__ và cách implement nó.

## LRU Cache
Khi cache out of memory, nó sẽ remove cặp key-value cũ nhất được dùng ra. 

## How to build
* Khi max size,  remove lease recently used cache
* Khi 1 key được fetch hoặc update, nó trở thành most recently used
* Các operation get hoặc set phải được comple trong O(1) time complexity
* Khi fetch 1 key không tồn tại, return về null

#### Data Structure
Ta sẽ cần phải dùng 2 data structure, 1 cái dùng để lưu trữ key-value (Dictionary/Hash map) và 1 cái dùng để giữ các item được sort theo frequency of use.
Đối với data structure thứ 2, ta có thể dùng Array, tuy nhiên ta có 1 solution tốt hơn là dùng Doubly Linked List

#### Doubly Linked List
Ta sẽ cần phải dùng 2 data structure, 1 cái dùng để lưu trữ __key-value (Dictionary/Hash map)__ và 1 cái dùng để giữ các item được __sort__ theo frequency of use.
Đối với Linked List, head sẽ là most recently node, còn tail sẽ là least recently node. Khi cần phải remove cache ta sẽ remove tail trước. Khi có insert/update node thì nó sẽ trở thành head.