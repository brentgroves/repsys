# **[Re-Hashed: How to clear HSTS settings in Chrome and Firefox](https://www.thesslstore.com/blog/clear-hsts-settings-chrome-firefox/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

A quick look at what **[HSTS](https://www.thesslstore.com/blog/what-is-hypertext-strict-transport-security-hsts/)** is and how to clear it on two of the most popular browsers.

HSTS stands for HTTP Strict Transport Security, it’s a web security policy mechanism that forces web browsers to interact with websites only via secure HTTPS connections (and never HTTP). This helps to prevent protocol downgrade attacks and cookie hijacking.

HSTS was originally created in response to a vulnerability that was introduced by Moxie Marlinspike in a 2009 BlackHat Federal talk titled “New Tricks for Defeating SSL in Practice.” The particular vulnerability that HSTS defends against is the one illustrated by Marlinspike’s SSLStrip tool.

Essentially the tool works by converting secure HTTPS connections back to unsecured HTTP ones. HSTS remedies this by communicating to the browser that an HTTPS connection should always be in place. HSTS can also help to prevent cookie-based login credentials from being stolen by common tools such as Firesheep.

Unfortunately, some HSTS settings can inadvertently cause browser errors. For instance, if you’re using Chrome, you might run into:

“Privacy error: Your connection is not private” (NET::ERR_CERT_AUTHORITY_INVALID).

If you attempt to reach the same site on another browser and don’t run into the same issues, it could just be a problem with how the HSTS settings have affected your original browser. In that case, you will need to clear them. Here’s how to clear HSTS settings on Google Chrome and Mozilla Firefox.

## Clear and Forget HSTS Settings In Popular Browsers

If your browser has stored HSTS settings for a domain and you later try to connect over HTTP or a broken HTTPS connection (mis-match hostname, expired certificate, etc) you will receive an error. Unlike other HTTPS errors, HSTS-related errors cannot be bypassed. This is because the browser has received explicit instructions from the browser not to allow anything but a secure connection.

HSTS settings include a “max-age” option, which tells the browser how long to cache and remember the settings before checking again. In order to immediately proceed past the error, you will need to delete your browser’s local HSTS settings for that domain. Instructions on how to do so are below.

These settings need to be cleared in each browser. As a developer, you may run into this error if you are testing an HSTS configuration. In Chrome, you can receive this error on localhost. If you have deployed HSTS onto a live site for end users, it may be infeasible to correct the errors they are having depending on the size of your audience. Each user needs to delete their local HSTS settings or wait for them to expire according to the ‘max-age’ that was set.

Also note that if the website is still serving the HSTS header, your browser will store it as soon as you visit the site again. So you must first stop sending that header if you don’t want the error to reoccur.

Neither Chrome nor Firefox have a unique error code for HSTS errors, but the interstitial error pages will include information about HSTS.

## Delete HSTS Settings

Note that these instructions are mainly useful for developers who were testing HSTS and now need to delete the settings. For a website you do not control, deleting your browser’s local HSTS settings will not help if the website is still serving an HSTS header as your browser will simply save the settings again on each visit/refresh.

In Chrome you may see the error “NET::ERR_CERT_COMMON_NAME_INVALID.” If you click “Advanced” in Chrome the error message will include “You cannot visit domain.com right now because the website uses HSTS.” That will confirm the error is HSTS-related. On localhost you may see the error “This site can’t provide a secure connection.”

In Firefox the interstitial page will read: “This site uses HTTP Strict Transport Security (HSTS) to specify that Firefox may only connect to it securely. As a result, it is not possible to add an exception for this certificate.”

If you have determined the error is due to cached HSTS settings, follow the following instructions to resolve the error:

## How to Delete HSTS Settings in Chrome

- Navigate to chrome://net-internals/#hsts

This is Chrome’s UI for managing your browser’s local HSTS settings.

First, to confirm the domain’s HSTS settings are recorded by Chrome, type the hostname into the Query Domain section at the bottom of the page. Click Query.If the Query box returns Found with settings information below, the domain’s HSTS settings are saved in your browser.

![hsts](https://www.thesslstore.com/blog/wp-content/uploads/2016/12/HSTS-settings-Chrome.png)

Note that this is a very sensitive search. Only enter the hostname, such as <www.example.com> or example.com without a protocol or path.

Type the same hostname into the Delete domain section and click

Your browser will no longer force an HTTPS connection for that site! You can test if its working properly by refreshing or navigating to the page.

Note that depending on the HSTS settings provided by the site, you may need to specify the proper subdomain. For example, the HSTS settings for staging.yoursite.com may be separate from yoursite.com so you may need to repeat the steps as appropriate.
