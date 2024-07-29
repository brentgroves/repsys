# **[setup venv](https://www.freecodecamp.org/news/how-to-setup-virtual-environments-in-python/)**

## How to Install a Virtual Environment using Venv

Virtualenv is a tool to set up your Python environments. Since Python 3.3, a subset of it has been integrated into the standard library under the venv module. You can install venv to your host Python by running this command in your terminal:

pip install virtualenv
To use venv in your project, in your terminal, create a new project folder, cd to the project folder in your terminal, and run the following command:

```bash
# add env/ folder to gitignore
conda deactivate
pushd .
cd ~/src/repsys/volumes/python/tutorials/venv
# python3.8 -m venv env if multiple versions of python are installed using deadsnakes ppa
python3 -m venv env
source env/bin/activate
```

## How to Activate the Virtual Environment

Now that you have created the virtual environment, you will need to activate it before you can use it in your project. On a mac, to activate your virtual environment, run the code below:

```source env/bin/activate```
This will activate your virtual environment. Immediately, you will notice that your terminal path includes env, signifying an activated virtual environment.

## Is the Virtual Environment Working?

We have activated our virtual environment, now how do we confirm that our project is in fact isolated from our host Python? We can do a couple of things.

First we check the list of packages installed in our virtual environment by running the code below in the activated virtual environment. You will notice only two packages – pip and setuptools, which are the base packages that come default with a new virtual environment

```bash
pip list
Package    Version
---------- -------
pip        22.0.2
setuptools 59.6.0
```

Next you can run the same code above in a new terminal in which you haven't activated the virtual environment. You will notice a lot more libraries in your host Python that you may have installed in the past. These libraries are not part of your Python virtual environment until you install them.

## How to Install Libraries in a Virtual Environment

To install new libraries, you can easily just pip install the libraries. The virtual environment will make use of its own pip, so you don't need to use pip3.

After installing your required libraries, you can view all installed libraries by using pip list, or you can generate a text file listing all your project dependencies by running the code below:

```bash
pip freeze > requirements.txt
You can name this requirements.txt file whatever you want.
```

## Requirements File

Why is a requirements file important to your project? Consider that you package your project in a zip file (without the env folder) and you share with your developer friend.

To recreate your development environment, your friend will just need to follow the above steps to activate a new virtual environment.

Instead of having to install each dependency one by one, they could just run the code below to install all your dependencies within their own copy of the project:

```~ pip install -r requirements.txt```

Note that it is generally not advisable to share your env folder, and it should be easily replicated in any new environment.

Typically your env directory will be included in a .gitignore file (when using version control platforms like GitHub) to ensure that the environment file is not pushed to the project repository.

## How to Deactivate a Virtual Environment

To deactivate your virtual environment, simply run the following code in the terminal:

```~ deactivate```

## Conclusion

Python virtual environments give you the ability to isolate your Python development projects from your system installed Python and other Python environments. This gives you full control of your project and makes it easily reproducible.

When developing applications that would generally grow out of a simple .py script or a Jupyter notebook, it's a good idea to use a virtual environment – and now you know how to set up and start using one.
