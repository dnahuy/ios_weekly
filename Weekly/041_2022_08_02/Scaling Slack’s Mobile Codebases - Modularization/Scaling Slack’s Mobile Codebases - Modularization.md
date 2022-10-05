[Original Link](https://slack.engineering/stabilize-modularize-modernize-scaling-slacks-mobile-codebases-2/)

# Scaling Slack’s Mobile Codebases: Modularization
## Introduction
* This post will explore modularization
    - Breaking apart app target into smaller components
    - Reduce interdependencies, decrease build times
    - Allow independent development
    
* Worked on Modularization and Modernization at the same time
* It wasn’t possible for the smaller Duplo core team to take on all the effort involved. 
    - Needed support from across the product teams as well
    - The pillar (product team) leads worked with the managers and engineers on their teams to determine:
        - How best to modernize their part of the codebase, 
        - Which features to tackle first
        - How to share resources between Duplo and regular feature work.

## Modularization
* `module`: generally a static or dynamic framework linked into the app.
* Benefits:
    - Improving build times
    - Allowing developers to build and test their code in smaller targets
    - Clearer separation of responsibilities and disentangling dependencies
    - Making it easier for developers to work independently
    - Made code ownership clearer. They required that each module have a clear owner
    
## iOS Modularization
#### Feature modules
* Related to presenting a feature in app (a screen, a part of screen, or a series of screens, ....)
* Features can link against the `Interface` of other Features, but not against their `Implementation`s
 
#### Service modules
* Perform some specific function, like making API calls, handling persistence, or any other common component which might be used by app
* Also have `Interface` and `Implementation`

#### Library modules
 * Collections of concrete data structures, simpler classes, and functions
 * Example: a Library of extensions for built-in system APIs, or simple data models.
 * Only depend on other Libraries
 
## Bazel adoption
* <strong>Huge</strong> improvement to development process.
* Creating new modules became simple and easy
* Merge conflicts in project files became rare and much easier to fix.
* Linking statically which was a big performance boost in pre-main times
* Support a shared build cache.
    - The more we can break down codebase into smaller modules and clean up dependency graph, the more benefit the Bazel cache can give us.

## Code generation
* Using scripts and file templates to generate new modules
* Using scripts to update CoreData models and the rest of low level data frameworks
* Creating and modifying feature flags
