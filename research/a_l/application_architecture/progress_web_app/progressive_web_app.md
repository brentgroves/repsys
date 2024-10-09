# **[Progressive web app](https://en.wikipedia.org/wiki/Progressive_web_app)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

A progressive web application (PWA), or progressive web app, is a type of web app that can be installed on a device as a standalone application.[1] PWAs are installed using the offline cache of the device's web browser.[2]

PWAs were introduced from 2016 as an alternative to native (device-specific) applications, with the advantage that they do not require separate bundling or distribution for different platforms. They can be used on a range of different systems, including desktop and mobile devices. Publishing the app to digital distribution systems like the Apple App Store or Google Play is optional.[2]

Because a PWA is delivered in the form of a webpage or website built using common web technologies including HTML, CSS, JavaScript, and WebAssembly,[3] it can work on any platform with a PWA-compatible browser. As of 2021, PWA features are supported to varying degrees by Google Chrome, Apple Safari, Firefox for Android, and Microsoft Edge[4][5] but not by Firefox for desktop.[6]

## Predecessors

At Apple's Worldwide Developers Conference in 2007, Steve Jobs announced that the iPhone would "run applications created with Web 2.0 Internet standards".[7] No software development kit (SDK) was required, and the apps would be fully integrated into the device through the Safari browser engine.[8] This model was later switched to the App Store, as a means of appeasing frustrated developers.[9] In October 2007 Jobs announced that an SDK would be launched the following year.[8] As a result, although Apple continued to support web apps, the vast majority of iOS applications shifted toward the App Store.

Beginning in the early 2010s dynamic web pages allowed web technologies to be used to create interactive web applications. Responsive web design, and the screen-size flexibility it provides have made PWA development more accessible. Continued enhancements to HTML, CSS, and JavaScript allowed web applications to incorporate greater levels of interactivity, making native-like experiences possible on a website.[10]

In 2013, Mozilla released Firefox OS. It was intended to be an open-source operating system for running web apps as native apps on mobile devices. Firefox OS was based on the Gecko rendering engine with a user interface called Gaia, written in HTML5. The development of Firefox OS ended in 2016,[11] and the project was completely discontinued in 2017,[12] although a fork of Firefox OS was used as the basis of KaiOS, a feature phone platform.

## Initial introduction

In 2015, designer Frances Berriman and Google Chrome engineer Alex Russell coined the term "progressive web apps"[14] to describe apps taking advantage of new features supported by modern browsers, including service workers and web app manifests, that let users upgrade web apps to progressive web applications in their native operating system (OS). Google then put significant efforts into promoting PWA development for Android.[15][16] Firefox introduced support for service workers in 2016, and Microsoft Edge and Apple Safari followed in 2018,[17][15] making service workers available on all major systems.

By 2019, PWAs were supported by desktop versions of most browsers, including Microsoft Edge[18] (on Windows) and Google Chrome[19] (on Windows, macOS, ChromeOS, and Linux).

In December 2020, Firefox for desktop abandoned the implementation of PWAs (specifically, removed the prototype "site-specific browser" configuration that had been available as an experimental feature). A Firefox architect noted: "The signal I hope we are sending is that PWA support is not coming to desktop Firefox anytime soon."[6] Mozilla still plans to support PWAs on Android

## Characteristics

Progressive web apps are all designed to work on any browser that is compliant with the appropriate web standards. As with other cross-platform solutions, the goal is to help developers build cross-platform apps more easily than they would with native apps.[15] Progressive web apps employ the progressive enhancement web development strategy.

Some progressive web apps use an architectural approach called the App Shell Model.[24] In this model, **[service workers](./service_workers_api.md)** store the Basic User Interface or "shell" of the responsive web design web application in the browser's offline cache. This model allows for PWAs to maintain native-like use with or without web connectivity. This can improve loading time, by providing an initial static frame, a layout or architecture into which content can be loaded progressively as well as dynamically.[25]

## Technical criteria

The technical baseline criteria for a site to be considered a progressive web app and therefore capable of being installed by browsers were described by Russell in 2016[26] and updated since:[27][28]

- Originate from a secure origin. Served over TLS and have no active mixed content. Progressive web apps must be served via HTTPS to ensure user privacy, security, and content authenticity.
Register a service worker with a fetch handler. Progressive web apps must use service workers to create programmable content caches. Unlike regular HTTP web cache, which caches content after the first use and then rely on various heuristics to guess when content is no longer needed, programmable caches can explicitly prefetch content in advance before it's used for the first time and explicitly discard it when it is no longer needed.[29] This requirement helps pages to be accessible offline or on low-quality networks.
