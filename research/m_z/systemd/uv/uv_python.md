# **[uv scripting and uvx](https://rsb.io/posts/til-uv-script-notation/)**

**[Current Tasks](../../../../a_status/current_tasks.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

I’ve known about Astral’s uv and uvx tools for a while, but over the holidays break I’ve been working to streamline my setup and (if possible) simplify the tools I use.

Changing over to uv from pipx/pyenv/pipenv helps solve my accumulation of one-off scripts. Normally, when I write a script I make a new directory with a **main**.py, requirements.txt, the works. Now with uv I can keep all my one-offs in a single directory for reuse or reference while keeping dependencies reasonable.

Every script starts something like this:

```python
# !/usr/bin/env uv run
# /// script
# requires-python = ">=3.13"
# dependencies = [ "boto3" ]
# ///
import sys, boto3
s3 = boto3.client('s3')
if **name** == "**main**":
    s3.list_objects_v2(Bucket=sys.argv[1])
```

This takes advantage of **[in-script toml-ish metadata](https://packaging.python.org/en/latest/specifications/inline-script-metadata/)**, a new-ish PEP that lets uv construct a temporary virtualenv **[matching your script’s needs](https://docs.astral.sh/uv/guides/scripts/#declaring-script-dependencies)** when you invoke the script thanks to the #! line.

If you dump the above into a file and chmod a+x it, then as long as uv is on your system you can reconstruct the deps and run the script independently of what your other scripts have needed in the meantime. There’s a built-in command uv init --script myscript.py that works, but doesn’t include the #! (shebang) line so you’ll want to add that.

If you’d like to upgrade from a one-shot script to a command you’ll regularly use (and rename from mytool.py to mytool) the shebang needs to be updated to #!/usr/bin/env uv run --script --quiet. If you don’t include the --script flag it will recusively execute forever until you interrupt it.

See the **[uv scripting docs](https://docs.astral.sh/uv/guides/scripts/#running-a-script-with-dependencies)** for more details on how scripting and dependencies work. There’s also uvx, which lets you run existing tools the same way. I was teaching some basic Python in **[Marimo](https://marimo.io/)** and it’s easy to spin up a new notebook with dependencies like:
