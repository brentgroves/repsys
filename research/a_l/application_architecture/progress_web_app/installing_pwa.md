# **[Making PWAs installable](https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps/Guides/Making_PWAs_installable)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

One of the defining aspects of a PWA is that it can be promoted by the browser for installation on the device. Once installed, a PWA appears to users as a platform-specific app, a permanent feature of their device which they can launch directly from the operating system like any other app.

We can summarize this as follows:

- Supporting browsers promote the PWA to the user for installation on the device.
- The PWA can be installed like a platform-specific app, and can customize the install process.
- Once installed, the PWA gets an app icon on the device, alongside platform-specific apps.
- Once installed, the PWA can be launched as a standalone app, rather than a website in a browser.

## Installability

For a web app to be promoted for installation by a supporting browser, it needs to meet some technical requirements. We can consider these the minimum requirements for a web app to be a PWA.

Note: While not a requirement for a PWA to be installable, many PWAs use service workers to provide an offline experience. See the CycleTracker: Service workers tutorial for more information.

## The web app manifest

A web app manifest is a JSON file that tells the browser how the PWA should appear and behave on the device. For a web app to be a PWA it must be installable, and for it to be installable it must include a manifest.

The manifest is included using a <link> element in the app's HTML:

```html
<!doctype html>
<html lang="en">
  <head>
    <link rel="manifest" href="manifest.json" />
    <!-- ... -->
  </head>
  <body></body>
</html>
```

If the PWA has more than one page, every page must reference the manifest in this way.

The manifest contains a single JSON object containing a collection of members, each of which defines some aspect of the PWA's appearance or behavior. Here's a rather minimal manifest, containing just two members: "name" and "icons".

```json
{
  "name": "My PWA",
  "icons": [
    {
      "src": "icons/512.png",
      "type": "image/png",
      "sizes": "512x512"
    }
  ]
}
```

## Required manifest members

Chromium-based browsers, including Google Chrome, Samsung Internet, and Microsoft Edge, require that the manifest includes the following members:

- name or short_name
- icons must contain a 192px and a 512px icon
- start_url
- display and/or display_override
- prefer_related_applications must be false or not present

For a full description of every member, see the **[Web app manifest](https://developer.mozilla.org/en-US/docs/Web/Manifest)** reference documentation.

## HTTPS, localhost, or loopback are required

For a PWA to be installable it must be served using the https protocol, or from a local development environment using localhost or 127.0.0.1 — with or without a port number.

This is a more stringent requirement than **[secure context](https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts)**, which considers resources loaded from file:// URLs to be secure.
