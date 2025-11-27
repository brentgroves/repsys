# **[Webassembly Tutorial](https://marcoselvatici.github.io/WASM_tutorial/)**

Introduction
Webassembly (WASM) is an innovative low-level language that can run on all modern browsers. As the name suggests, this is an assembly-like language that have a very compact binary format (thus suitable to be loaded on web pages) and can run with near-native performance.
Thanks to this technology, there is now the possibility to compile high-level languages and run them on the browser. Currently the only languages that can be compiled to WASM binaries are C and C++, but in future the list will probably grow a lot.

It is important to point out that WASM is not going to cut off JavaScript, you will still need it for several reasons that will be explained later on.

In this tutorial, you will learn the basics concepts behind this technology and then you will be ready to create a complete Webassembly-based WebApp!
Furthermore, I am going to guide you through all the concepts by using examples inspired to what I learned creating an online WASM-based file compressor.

Key concepts
There are a few key concepts that we need to know about WASM:

- **Module:** it is the compiled binary code (in other words, the .wasm file).
- **Memory:** a JavaScript typed array that represents the memory for your program.
- **Table:** an array (separated from the memory) that contains the references to the function that you use.
- **Instance:** it is the union of a Module, a Memory and a Table plus some other values that needs to be stored.
Don't worry if you don't get everything at this stage, things will start to make sense once you see them working.

## WASM workflow

If you are familiar with compiled languages, you probably know the steps that your code go through before being executed. Just as a reminder:

![i](https://marcoselvatici.github.io/WASM_tutorial/ref/compile.gif)

If you worked with C/C++, you probably used compilers like gcc or similar. In order to get a Webassembly binary file, we will need some other special compilers. There are more than one available, but currently the best one is Emscripten (and it is open source!).
Differently from the "normal" assembly languages, Webassembly is not CPU specific and therefore can run on multiple platforms, from embedded systems like your phone to the CPU of your computer.

Once we compile our C/C++ code with Emscripten, we obtain a proper WASM file that can run on the browser, pretty straightforward right?
Actually, there are a few more details to consider, but we will cover them step by step.

Briefly, the steps to get your WASM WebApp working are:

1. Compile C/C++ code with Emscripten, to obtain a WASM binary.
2. Bind your WASM binary to your page using a JavaScript "glue code".
3. Run your app and let the browser to instantiate your WASM module, the memory and the table of references. Once that is done, your WebApp is fully operative.

## Browser environment

It is really important to understand that WASM binaries are run in the same **[sandbox](https://www.howtogeek.com/169139/sandboxes-explained-how-theyre-already-protecting-you-and-how-to-sandbox-any-program/)** as JavaScript (in a nutshell, a sandbox is an isolated environment where your code is executed for security reasons).

![i](https://marcoselvatici.github.io/WASM_tutorial/ref/sandbox.gif)

Therefore, you will be able to access only the data that are also accessible with JavaScript. This means, for example, that you will not be able to access a file like this (unless you preload it at compile time):

```c
// "standard" C code to open a file
FILE *fp;
fp = fopen("/path/to/file/file.txt", "r");
```

Instead, you will have to read them via JavaScript and then use them with WASM, but we will return on this later.
You will furthermore have some limitations in the memory you can dynamically and statically allocate, depending on the browser you are using (but these are usually pretty big, so it is unlikely that you will suffer from that).

## Install Emscripten

First of all, let's install the WASM compiler, Emscripten. We will focus on how to install it for Linux, but you can find documentation for other OSes here.

First of all you need to have a working compiler toolchain installed (the set of tools that allows you to compile the code and get an executable) since we will build the software from the source code. Open a terminal and type:

```bash
# Update the package lists
sudo apt-get update

# Install *gcc* (and related dependencies)
sudo apt-get install build-essential

# Install cmake
sudo apt-get install cmake
```

You also need to install:
python 2.7
node.js

```bash
# Install Python

sudo apt-get install python2.7

# Install node.js

sudo apt-get install nodejs
```

Great! Now we have all the prerequisites to install the Emscripten Software Development Kit (emsdk). Just follow these steps:

Don't do this.

- Download and unzip the Software Development Kit (SDK) package to the directory of your choice. Here is the the **[link](https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz)**.
Open a terminal inside the folder emsdk-portable you already unzipped.
Now run the emsdk commands to obtain the latest tools from Github and set them as active:

Do this instead

**[emscripten_install](./emscripten/emscripten_install.md)**
