# Send SMS Text Message With Python Using GMail SMTP For Free

This is a demonstration on how to send a text message with Python. In this example, we use GMail to send the SMS message; but any host can work with the correct SMTP settings.

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## references

Video: <https://youtu.be/hKxtMaa2hwQ>
Source: <https://github.com/acamso/demos/blob/master/_email/send_txt_msg.py>
<https://www.reddit.com/r/Python/comments/mikh28/send_sms_text_message_with_python_using_gmail/>
<https://www.codeproject.com/Articles/16250/Some-Easy-Ways-to-Send-Emails-via-SMTP-and-SMS-Tex>
<https://groups.google.com/g/jasmin-sms-gateway/c/-EcG6mjzI8Y>
<https://www.gmass.co/blog/send-text-from-gmail/>
<https://ntfy.sh/>

```python

# *- coding: utf-8 -*-
# send_txt_msg.py
# 04-02-2021 03:08:34 EDT
# (c) 2021 acamso

"""Sends TXT message with GMail.

This is a demonstration on how to send an text message with Python.
In this example, we use GMail to send the SMS message,
but any host can work with the correct SMTP settings.
Each carrier has a unique SMS gateway hostname.
This method is completely free and can be useful in a variety of ways.

Video: https://youtu.be/hKxtMaa2hwQ
Turn on: https://myaccount.google.com/lesssecureapps
"""

import asyncio
import re
from email.message import EmailMessage
from typing import Collection, List, Tuple, Union

import aiosmtplib

HOST = "smtp.gmail.com"
# https://kb.sandisk.com/app/answers/detail/a_id/17056/~/list-of-mobile-carrier-gateway-addresses
# https://www.gmass.co/blog/send-text-from-gmail/
CARRIER_MAP = {
    "verizon": "vtext.com",
    "tmobile": "tmomail.net",
    "sprint": "messaging.sprintpcs.com",
    "at&t": "txt.att.net",
    "boost": "smsmyboostmobile.com",
    "cricket": "sms.cricketwireless.net",
    "uscellular": "email.uscc.net",
}


# pylint: disable=too-many-arguments
async def send_txt(
    num: Union[str, int], carrier: str, email: str, pword: str, msg: str, subj: str
) -> Tuple[dict, str]:
    to_email = CARRIER_MAP[carrier]

    # build message
    message = EmailMessage()
    message["From"] = email
    message["To"] = f"{num}@{to_email}"
    message["Subject"] = subj
    message.set_content(msg)

    # send
    send_kws = dict(username=email, password=pword, hostname=HOST, port=587, start_tls=True)
    res = await aiosmtplib.send(message, **send_kws)  # type: ignore
    msg = "failed" if not re.search(r"\sOK\s", res[1]) else "succeeded"
    print(msg)
    return res


async def send_txts(
    nums: Collection[Union[str, int]], carrier: str, email: str, pword: str, msg: str, subj: str
) -> List[Tuple[dict, str]]:
    tasks = [send_txt(n, carrier, email, pword, msg, subj) for n in set(nums)]
    return await asyncio.gather(*tasks)


if __name__ == "__main__":
    _num = "999999999"
    _carrier = "verizon"
    _email = "user@gmail.com"
    _pword = "pword"
    _msg = "Dummy msg"
    _subj = "Dummy subj"
    coro = send_txt(_num, _carrier, _email, _pword, _msg, _subj)
    # _nums = {"999999999", "000000000"}
    # coro = send_txts(_nums, _carrier, _email, _pword, _msg, _subj)
    asyncio.run(coro)
```
