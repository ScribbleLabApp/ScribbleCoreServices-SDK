# ``ScribbleCoreServices``

Managing essential Core Services with ease with ScribbleCoreServices (Swift)

@Metadata {
    @SupportedLanguage(swift) 
    @SupportedLanguage(cpp)
    @Available(iOS, introduced: "17.0")
    @Available(macOS, introduced: "14.0")
    @Available(MacCatalyst, introduced: "17.0")
    @Available(visionOS, introduced: "1.0")
    @Available(iPadOS, introduced: "17.0")
    @Available(Swift, introduced: "5.10")
}

## Overview

ScribbleCoreServices is a set of essential tools and services that enable ScribbleLab to function seamlessly. It provides a wide range of resources, including system-level services such as data management, networking, and security, as well as application-specific services that optimize ScribbleLab's performance and user experience. By leveraging ScribbleCoreServices, ScribbleLab delivers a reliable and high-quality experience to its users, aligning with Apple's accessibility guidelines and best practices.

![An illustartion reperesenting the structure of the layers](layers)

ScribbleCoreServices offers endpoints for ScribbleLabApp's XPCs and the underlying operating system. ScribbleLab benefits from ScribbleCoreServices' comprehensive suite of features, which help it to deliver high-quality performance and optimal user experience.

> Important:
> You may only use ScribbleCoreServices within ScribbleLabApp's Applications or Plug-Ins. Read our Developer EULA [here](https://github.com/ScribbleLabApp/ScribbleLab).

### Essentials

@Links(visualStyle: detailedGrid) {
    - <doc:QuickStart>
}

## Topics

### Essentials

- <doc:QuickStart>

### Utils

- ``SCNLog``
- ``SCNImageCache``
- ``SCNColor``

### Updates

- <doc:SCNUpdate>
- ``SCNUpdateService-262ia``

### Services

- ``SCNAuthService``
- ``SCNUserService``
- ``SCNLA``

### File management

### Networking
