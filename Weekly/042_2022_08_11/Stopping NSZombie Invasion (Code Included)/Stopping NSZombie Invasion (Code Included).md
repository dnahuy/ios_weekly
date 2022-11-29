[Original Link](https://medium.com/@FunCorp/stopping-nszombie-invasion-d8fb0250c22e)

# Stopping NSZombie Invasion (Code Included)
## Introduction
This post is about the zombie object detection mechanism and implementation of FunCorp

![](resources/nszombie01.jpeg)

 <strong>EXC_BAD_ACCESS objc_release…</strong>

## The nature of such crashes
* Called to an deallocated object
* `use after free` error
* `unowned (unsafe)`

## FunCorp's implementation
* Must `-fno-objc-arc` (compile without ARC)

## FNZombieService
#### enableWithBufferSize
* Replace `NSObject's dealloc` with `zombie_dealloc` 
    - `static void zombie_dealloc(id object, SEL selector) `

```objc
  Class rootClass = [NSObject class];
  _deallocIMP = class_getMethodImplementation(rootClass, @selector(dealloc));

  Class zombieClass = objc_getClass("FNZombie");
  _zombieClass = zombieClass;
  
  Method rootClassMethod = class_getInstanceMethod(rootClass, @selector(dealloc));
  method_setImplementation(rootClassMethod, (IMP)zombie_dealloc);
```

#### zombie_dealloc
* Destroy memory
```objc
  objc_destructInstance(object);
  memset((__bridge void *)object, 0, size);
```

* Replace `isa` of object with `_zombieClass` (`FNZombie`)

```objc
  object_setClass(object, service->_zombieClass);
```

* Put zombie into buffer

```objc
  FNZombieRecord record = {};
  record.object = object;
  record.wasa = objectClass;

  if (service->_bufferSize > 0) {
      FN_SWAP(record, service->_zombies[service->_zombiesIndex]);
      service->_zombiesIndex = (service->_zombiesIndex + 1) % service->_bufferSize;
  }
```

## FNZombie
* Override some methods: 
    - `forwardingTargetForSelector`
    - `performSelector`
    ....
    
```objc
- (id)forwardingTargetForSelector:(SEL)aSelector {
  [[FNZombieService sharedInstance]
   crashWithObject:self
   withSelector:aSelector
   fromSelector:nil
  ];
  return nil;
};

```

* `crashWithObject` will log information (object, class, method invoked).
```objc
  NSString *message = [NSString stringWithFormat:@"Zombie <%@: %p> received -%@",
                       className,
                       object,
                       selectorName];
  
  pthread_mutex_unlock(get_lock());
  fatal_error(message);
```

## Summary
* Replace `NSObject's dealloc`
* Implement `forwardingTargetForSelector`, `performSelector` of `FNZombie`
