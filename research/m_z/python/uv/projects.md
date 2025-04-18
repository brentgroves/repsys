# **[Projects](https://docs.astral.sh/uv/guides/projects/)**

**[Research List](../../../research_list.md)**\
**[Detailed Status](../../../../a_status/detailed_status.md)**\
**[Curent Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

## Working on projects

uv supports managing Python projects, which define their dependencies in a pyproject.toml file.

## Creating a new project

You can create a new Python project using the uv init command:

```bash
uv init hello-world
cd hello-world
```

Alternatively, you can initialize a project in the working directory:

```bash
mkdir hello-world
cd hello-world
uv init
```

uv will create the following files:

```bash
.
├── .python-version
├── README.md
├── main.py
└── pyproject.toml
```

The main.py file contains a simple "Hello world" program. Try it out with uv run:

```bash
uv run main.py
Using CPython 3.13.2
Creating virtual environment at: .venv
Hello from hello-world!
```

## Project structure

A project consists of a few important parts that work together and allow uv to manage your project. In addition to the files created by uv init, uv will create a virtual environment and uv.lock file in the root of your project the first time you run a project command, i.e., uv run, uv sync, or uv lock.

A complete listing would look like:

.
├── .venv
│   ├── bin
│   ├── lib
│   └── pyvenv.cfg
├── .python-version
├── README.md
├── main.py
├── pyproject.toml
└── uv.lock

pyproject.toml
The pyproject.toml contains metadata about your project:

pyproject.toml

[project]
name = "hello-world"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
dependencies = []

You'll use this file to specify dependencies, as well as details about the project such as its description or license. You can edit this file manually, or use commands like uv add and uv remove to manage your project from the terminal.

See the official **[pyproject.toml guide](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/)** for more details on getting started with the pyproject.toml format.

You'll also use this file to specify uv **[configuration options](https://docs.astral.sh/uv/configuration/files/)** in a [tool.uv] section.

.python-version
The .python-version file contains the project's default Python version. This file tells uv which Python version to use when creating the project's virtual environment.

.venv
The .venv folder contains your project's virtual environment, a Python environment that is isolated from the rest of your system. This is where uv will install your project's dependencies.

See the **[project environment](https://docs.astral.sh/uv/concepts/projects/layout/#the-project-environment)** documentation for more details.

uv.lock
uv.lock is a cross-platform lockfile that contains exact information about your project's dependencies. Unlike the pyproject.toml which is used to specify the broad requirements of your project, the lockfile contains the exact resolved versions that are installed in the project environment. This file should be checked into version control, allowing for consistent and reproducible installations across machines.

uv.lock is a human-readable TOML file but is managed by uv and should not be edited manually.

See the **[lockfile](https://docs.astral.sh/uv/concepts/projects/layout/#the-lockfile)** documentation for more details.

## Managing dependencies

You can add dependencies to your pyproject.toml with the uv add command. This will also update the lockfile and project environment:

`uv add requests`

You can also specify version constraints or alternative sources:

```bash
# Specify a version constraint
uv add 'requests==2.31.0'

# Add a git dependency
uv add git+https://github.com/psf/requests
```

If you're migrating from a requirements.txt file, you can use uv add with the -r flag to add all dependencies from the file:

```bash
# Add all dependencies from `requirements.txt`.
uv add -r requirements.txt -c constraints.txt
```

To remove a package, you can use uv remove:

```bash
uv remove requests
```

To upgrade a package, run uv lock with the --upgrade-package flag:

`uv lock --upgrade-package requests`

The --upgrade-package flag will attempt to update the specified package to the latest compatible version, while keeping the rest of the lockfile intact.

See the documentation on **[managing dependencies](https://docs.astral.sh/uv/concepts/projects/dependencies/)** for more details.

## Running commands

uv run can be used to run arbitrary scripts or commands in your project environment.

Prior to every uv run invocation, uv will verify that the lockfile is up-to-date with the pyproject.toml, and that the environment is up-to-date with the lockfile, keeping your project in-sync without the need for manual intervention. uv run guarantees that your command is run in a consistent, locked environment.

For example, to use flask:

`uv add flask`
`uv run -- flask run -p 3000`

Or, to run a script:

```python
# example.py

# Require a project dependency
import flask

print("hello world")
```

`uv run example.py`

Alternatively, you can use uv sync to manually update the environment then activate it before executing a command:

```bash
uv sync
source .venv/bin/activate
flask run -p 3000
python example.py
```

The virtual environment must be active to run scripts and commands in the project without uv run. Virtual environment activation differs per shell and platform.

See the documentation on **[running commands and scripts](https://docs.astral.sh/uv/concepts/projects/run/)** in projects for more details.

In the context of the uv Python package manager, uv sync synchronizes your project's dependencies with the environment, ensuring that the packages installed in your virtual environment match those specified in your project's lock file, and optionally removes extraneous packages.

## Building distributions

uv build can be used to build source distributions and binary distributions (wheel) for your project.

By default, uv build will build the project in the current directory, and place the built artifacts in a dist/ subdirectory:

```bash
uv build
ls dist/
```

See the documentation on **[building projects](https://docs.astral.sh/uv/concepts/projects/build/)** for more details.
