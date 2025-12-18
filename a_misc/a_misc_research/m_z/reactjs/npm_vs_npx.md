# **[npm vs npx](https://www.freecodecamp.org/news/npm-vs-npx-whats-the-difference/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## If you’ve ever used Node.js, then you must have used npm for sure.

npm (node package manager) is the dependency/package manager you get out of the box when you install Node.js. It provides a way for developers to install packages both globally and locally.

Sometimes you might want to take a look at a specific package and try out some commands. But you cannot do that without installing the dependencies in your local node_modules folder.

That’s where npx comes in.

In this article, we’re going to have a look at the differences between the npm and npx and learn how to get the best from both.

First, let’s understand what npm actually is and what we can do with it.

Want to watch a video to supplement your reading? Check this out:

## npm the package manager
npm is a couple of things. First and foremost, it is an online repository for the publishing of open-source Node.js projects.

Second, it is a CLI tool that aids you install those packages and manage their versions and dependencies. There are hundreds of thousands of Node.js libraries and applications on npm and many more are added every day.

npm by itself doesn’t run any packages. If you want to run a package using npm, you must specify that package in your package.json file.

When executables are installed via npm packages, npm creates links to them:

- local installs have links created at the ./node_modules/.bin/ directory
- global installs have links created from the global bin/ directory (for example: /usr/local/bin on Linux or at %AppData%/npm on Windows)

To execute a package with npm you either have to type the local path, like this:

```bash
$ ./node_modules/.bin/your-package
```

or you can run a locally installed package by adding it into your package.json file in the scripts section, like this:

```json
{
  "name": "your-application",
  "version": "1.0.0",
  "scripts": {
    "your-package": "your-package"
  }
}
```

Then you can run the script using npm run:

```bash
npm run your-package
```

You can see that running a package with plain npm requires quite a bit of ceremony.

Fortunately, this is where npx comes in handy.

npx the package runner
Since npm version 5.2.0 npx is pre-bundled with npm. So it’s pretty much a standard nowadays.

npx is also a CLI tool whose purpose is to make it easy to install and manage dependencies hosted in the npm registry.

It’s now very easy to run any sort of Node.js based executable that you would normally install via npm.

You can run the following command to see if it is already installed for your current npm version:

```bash
$ which npx
```

If it's not, you can install it like this:

```bash
$ npm install -g npx
```

Once you make sure you have it installed, let’s see a few of the use cases that make npx extremely helpful.

Run a locally installed package easily
If you wish to execute a locally installed package, all you need to do is type:

```bash
$ npx your-package
```

npx will check whether <command> or <package> exists in $PATH, or in the local project binaries, and if so it will execute it.

Execute packages that are not previously installed
Another major advantage is the ability to execute a package that wasn’t previously installed.

Let's test this out by running:

```bash
$ npx cowsay wow
```

This is awesome because sometimes you just want to use some CLI tools but you don’t want to install them globally just to test them out.

This means you can save some disk space and simply run them only when you need them. This also means your global variables will be less polluted.

## Run code directly from GitHub

This one’s pretty rad.

You can use npx to run any GitHub gists and repositories. Let’s focus on executing a GitHub gist because it’s easier to create one.

The most basic script consists of the main JS file and a package.json. After you’ve set up the files, all you have to do is run the npx with the link to that gist as shown in the image above.

**[Here](https://gist.github.com/Tynael/0861d31ea17796c9a5b4a0162eb3c1e8)** you can find the code that I used for this example.

Make sure you read carefully any script before you execute it to avoid serious problems that can occur due to malicious code.

