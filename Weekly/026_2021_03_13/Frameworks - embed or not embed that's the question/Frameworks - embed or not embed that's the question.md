[Original Link](https://holyswift.app/frameworks-embed-or-not-embed-thats-the-question?guid=none&deviceId=608ee4fb-41e2-444c-9f1a-03b592279cc1)

# Frameworks - embed or not embed that's the question

## Introduction
This post explains __“Do not Embed”, “Embed without Signing”, “Embed and Signing”__ frameworks

## Dynamic Library
They are not part of application executable file. When app is launched, the code is first loaded into application address space. Then __Dynamic linker__ will link everything app needs.

## Static Library
When at build time, __Static Linker__ will merge in a single executable file all the framework code and target application code. 
This way, final executable file will be bigger but guaranted that all code needed to run, are available to run.
When app is launched, all application code plus framework code will be loaded into application address space.

## Framework
Framework is a hierarchical directory that encapsulates shared resources such as _library, nib files, image files, v.v…_ in a single package.
__Match-O-Type:__ to check framework is a dynamic library or static library.

## Do not Embed
Framework will not be packed with application. This implies final application package __won’t contain__ a folder called __Frameworks__ with all the framework code.
Therefore, __“Do not Embed”__ mustn’t be used with __Dynamic Library__ or the application will has runtime error (__“Undefined symbols”__).
“Do not embed” can be __safely__ used with __Static Library__ because framework code was be merge with executable binary by Static Linker in Build Time.

## Embed (signing or not)
So, when do we need embed framework? You embed framework if you want to have access some __“media bundle”__ inside the library framework you are using.
__Embeding a dynamic library__ framework, when the app try to resolve external symbols that are not inside the main app code, it will find inside the app bundle in the framework folder. This could effect seriously __startup time__.
__Embeding a static library__ framework. Because you have already link library in Build Time, it actually will __“duplicate”__ the size. 
Of course, if for some reasons, we need to get access to “media bundle” inside static library, we can embed it to final bundle.
The "Embed and Sign" and "Embed Without Signing" the only diference is if you need to sign the framework or not.