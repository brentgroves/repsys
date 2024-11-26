# **[How to include environment variable in bash line CURL?](https://superuser.com/questions/835587/how-to-include-environment-variable-in-bash-line-curl)**

Inside single-quotes, the shell expands nothing. Place them inside double-quotes instead:Inside single-quotes, the shell expands nothing. Place them inside double-quotes instead:

```bash
curl -u <my-api-token>: \
  -X POST https://api.pushbullet.com/v2/pushes \
  --header 'Content-Type: application/json' \
  --data-binary '{"type": "note", "title": "'"$TR_TORRENT_NAME"'", \
  "body": "'"$TR_TORRENT_NAME completed"'."}'
```

## Let's examine how this works by looking at

```bash
$ TR_TORRENT_NAME=MyTorrent
$ echo '{"type": "note", "title": "'"$TR_TORRENT_NAME"'", "body": "'"$TR_TORRENT_NAME completed"'."}'
{"type": "note", "title": "MyTorrent", "body": "MyTorrent completed."}
```

When the shell variable appears, it is always inside double-quotes. Consequently, it is properly expanded.

Quoting like this is a bit subtle. We have single-quoted strings that contain double-quotes as characters and are next to double-quoted strings. To understand this better, let's take this fragment as a an example:

```bash
 "'"$TR_TORRENT_NAME"'"
 ```

Taking each character in turn:

```text
1. " is a literal double-quote character that is inside of a single-quoted string. (For brevity, the beginning of this string is not shown in this fragment.)
2. ' closes a single-quoted string.
3. " opens a double-quoted string.
4. $TR_TORRENT_NAME is a shell variable that is expanded inside double-quotes.
5. " closes the double-quoted string.
6. ' opens a new single-quoted string.
7. " places a double-quote character inside the single-quoted string.
```
