# **[How to block git push to github](https://serverfault.com/questions/1111798/how-to-block-git-push-to-github)**

We achieved this be not allowing users to login into Github thereby removing any possibilities of them pushing code to Github. The pull works for public repositories, but not for private as that would require them to login to Github as well.

In the end, we have 3 levels of Github access in the ORG:

Github is blocked (no access to the website and Git protocol)
Github is unblocked, but login URLs are blocked (can't push, but can pull public repos).
Github and its login URLs are unblocked (can push, and pull from public and private repositories).
