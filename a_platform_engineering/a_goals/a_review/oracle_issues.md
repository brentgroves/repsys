# Oracle sign in issue

The following is in markdown format and can be viewed by copying and pasting the entire content of this email into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## No access

HR adds you to Oracle and sometimes they do not enter all the info needed such as manager and domain EntraId account. If this is the case you will receive
the following error: System error. "Please re-try your action. If you continue to get this error, please contact the Administrator." when clicking company single sign on button. After HR enters your domain user account it takes time to take effect. In my case I tried to sign in the next day.

## after my domain user account was added and waiting a day for it to take affect it worked

10/2/25 : I was able to sign in from edge on Windows isdev.

Welcome, Brent Groves
Home
You have a new home page!
Open it with the home icon or the company logo.
You can continue to access this page by selecting the My Dashboard item in the navigation menu.

Note: In the 3 dash menu on the right there is a star review menu item.

## launch Microsoft Edge from Private Window

it takes me to the Linamar sign in page: <https://login.microsoftonline.com/ceadc058-fad7-4b6b-830b-00ac739654f0/oauth2/authorize?client%5Fid>...
entered <bgroves@linamar.com> and clicked next
it went to Windows Security page at: adfs.linamar.com security
filled out Windows Security page fields:
user name: bgroves
password: xxxxx
domain: already set to linamar
clicked ok
it went to the Linamar approve sign page: <https://login.microsoftonline.com/login.srf>
which says open your authenticator app and enter the number if prompted.
From the Microsoft Authenticator app on my Android phone I entered the number when prompted it I was trying to sign in to LinamarCorporation as <bGroves@linamar.com>.
It went to the Linamar sharepoint page: <https://linamarcorporation.sharepoint.com/>
There were 2 options for accessing Linus:

- Left vertical menu item: Linus Home
- Click here for new Linus image button
I chose the "Click here for new Linus" image button
It went to the Linus Home page: <https://linamarcorporation.sharepoint.com/sites/Linus>
I clicked on the Star Oracle image button.
It went to the Oracle Application Cloud sign in page: <https://login-epmd-saasfaprod1.fa.ocs.oraclecloud.com/oam/server/obrareq.cgi?encquery%3Dg7qnabMtqpKRDyXWG7Fic8zvSHYbLMO6EQRHuC1OkAC80VNiJGx7aVwbRaFDpK9y>...
I clicked the company single sign-on button.
The same page was show with the following error: "System error. Please re-try your action. If you continue to get this error, please contact the Administrator."
and the URL changed to: <https://login-epmd-saasfaprod1.fa.ocs.oraclecloud.com/oam/server/fed/sp/sso>

## launch microsoft edge

deleted all browsing data for all time.
close microsoft edge
launch microsoft edge
it goes to <https://linamarcorporation.sharepoint.com/sites/Linus>
select Employee benefits and it works.
select Oracle star review
it takes me to <https://login-epmd-saasfaprod1.fa.ocs.oraclecloud.com/oam/server/obrareq.cgi?ECID-Context=1.006G1o7HqG0Bp2K6yVjc6G00Crmr0007xq%3BkXjE>
clicked company single sign on button.
get the following error: System error. Please re-try your action. If you continue to get this error, please contact the Administrator.

## launch chrome

opened incognito window
went to <https://linamarcorporation.sharepoint.com/sites/Linus>
it went to the Linamar sign in page at <https://login.microsoftonline.com/ceadc058-fad7-4b6b-830b-00ac739654f0/oauth2/authorize?client%5Fid=>...
enter login: <bGroves@linamar.com>
clicked next
it went to our organization sign in page: <https://adfs.linamar.com/adfs/ls/wia?client-request-id=e033cba1-4018-a000-2065-d5ea3086bc88&wa=wsignin1.0&wtrealm=urn%3afederation%3aMicrosoftOnline&>...
enter username: bgroves and my password
clicked sign in
it went to the approve sign in request screen saying open your authenticator app and type 97.
Entered 97 in my phone Microsoft Authenticator app when prompted with <bGroves@linamar.com> is attempting to sign in.
It goes to the Linus home page at <https://linamarcorporation.sharepoint.com/sites/Linus>.
Click the Star Oracle button.
It takes me to the Oracle Application Cloud sign in page: <https://login-epmd-saasfaprod1.fa.ocs.oraclecloud.com/oam/server/obrareq.cgi?ECID-Context=1.006G1pGG9vDBp2K6yVjc6G00Crmr00099z%3BkXjE>
Click the company single sign-on button and get the following error:
"System error. Please re-try your action. If you continue to get this error, please contact the Administrator." and the URL is now <https://login-epmd-saasfaprod1.fa.ocs.oraclecloud.com/oam/server/fed/sp/sso>
