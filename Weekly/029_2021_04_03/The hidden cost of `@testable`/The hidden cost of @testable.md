[Original Link](https://paul-samuels.com/blog/2021/03/29/thoughts-on-testable-import/)

# The hidden cost of `@testable`
## Introduction
This post talks about a few potential design issues that could come from using __@testable__

## Public API
APIs will be stable, supported and the behaviour will not change unless some change management process is followed.
The code authors keep the surface area of their public APIs as small as possible and hide as much implementation from end users. This set up gives the author the freedom to rework the internals as much as they like.

## Overly specified code
Adding tests around code makes the code harder to change because we are locking in the behaviour or at the very least our current understanding of the behaviour. 
This is great for public APIs because public APIs should be stable. This rigidity is not so good for our non public implementation details that we want to be easier to change.

Sometimes, we got carried away and we are testing the implementation details rather than the overall behaviour.

There’s been plenty of times we’ve hit code visibility issues in our tests and instinctively reached for @testable import instead of opting to mark the API we want to test as public.

The issue is, once using @testable, it’s much easier to overly specify your code and write tests at the wrong level.

## Loosens documentation and forces extremes
As the default visibility for code is __internal__ it means that unless otherwise stated all code you write in a single module is visible everywhere within that module. 
This makes it really hard to differentiate what code should be stable and what code should be flexible.

To resolve this we can go to extremes and mark all implementation details as __private__ but this then removes our ability to use the escape hatch of __@testable.__

## But we use TDD
People TDD some code and come up with good solutions but then fall at the last hurdle. It’s easy to forget that that tests are not the artifact we care about producing, instead they just help create working software. 

Keeping in mind that tests make things less flexible and the things we preferably want to be stable are the public API. 
We should therefore see if we can restate any tests that are aimed at implementation details as tests of the public API

## Different compilation
For @testable import to work your Swift module needs to be compiled differently. 