# **[Using React in Visual Studio Code](https://code.visualstudio.com/docs/nodejs/reactjs-tutorial)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Note

- If you just pulled the code from a repository it needs its dependancies installed

```bash
npm install
```

## Using React in Visual Studio Code

React is a popular JavaScript library developed by Facebook for building user interfaces. The Visual Studio Code editor supports React.js IntelliSense and code navigation out of the box.

![](https://code.visualstudio.com/assets/docs/nodejs/reactjs/welcome-to-react.png)

## Welcome to React

We'll be using the create-react-app generator for this tutorial. To use the generator as well as run the React application server, you'll need Node.js JavaScript runtime and npm (Node.js package manager) installed. npm is included with Node.js which you can download and install from Node.js downloads.

Tip: To test that you have Node.js and npm correctly installed on your machine, you can type node --version and npm --version in a terminal or command prompt.

```bash
node -v                
v18.16.0
npm --version
9.7.1
```

You can now create a new React application by typing:

```bash
pushd .
cd ~/src/repsys/volumes/reactjs
npx create-react-app my-app
```

where my-app is the name of the folder for your application. This may take a few minutes to create the React application and install its dependencies.

Note: If you've previously installed create-react-app globally via npm install -g create-react-app, we recommend you uninstall the package using npm uninstall -g create-react-app to ensure that npx always uses the latest version.

Let's quickly run our React application by navigating to the new folder and typing npm start to start the web server and open the application in a browser:

```bash
cd my-app
npm start
```

You should see the React logo and a link to "Learn React" on <http://localhost:3000> in your browser. We'll leave the web server running while we look at the application with VS Code.

To open your React application in VS Code, open another terminal or command prompt window, navigate to the my-app folder and type code .:

```bash
cd my-app
code .
```

## Markdown preview

In the File Explorer, one file you'll see is the application README.md Markdown file. This has lots of great information about the application and React in general. A nice way to review the README is by using the VS Code Markdown Preview. You can open the preview in either the current editor group (Markdown: Open Preview Ctrl+Shift+V) or in a new editor group to the side (Markdown: Open Preview to the Side Ctrl+K V). You'll get nice formatting, hyperlink navigation to headers, and syntax highlighting in code blocks.

![](https://code.visualstudio.com/assets/docs/nodejs/reactjs/markdown-preview.png)

## Syntax highlighting and bracket matching

Now expand the src folder and select the index.js file. You'll notice that VS Code has syntax highlighting for the various source code elements and, if you put the cursor on a parenthesis, the matching bracket is also selected.

![](https://code.visualstudio.com/assets/docs/nodejs/reactjs/bracket-matching.png)

## IntelliSense

As you start typing in index.js, you'll see smart suggestions or completions.

After you select a suggestion and type ., you see the types and methods on the object through IntelliSense.

VS Code uses the TypeScript language service for its JavaScript code intelligence and it has a feature called Automatic Type Acquisition (ATA). ATA pulls down the npm Type Declaration files (*.d.ts) for the npm modules referenced in the package.json.

If you select a method, you'll also get parameter help:

![](https://code.visualstudio.com/assets/docs/nodejs/reactjs/parameter-help.png)

## Go to Definition, Peek definition

Through the TypeScript language service, VS Code can also provide type definition information in the editor through Go to Definition (F12) or Peek Definition (Ctrl+Shift+F10). Put the cursor over the App, right click and select Peek Definition. A **[Peek window](https://code.visualstudio.com/docs/editor/editingevolved#_peek)** will open showing the App definition from App.js.

![peek](https://code.visualstudio.com/assets/docs/nodejs/reactjs/peek-definition.png)

Press Escape to close the Peek window.

## Hello World

Let's update the sample application to "Hello World!". Create a component inside index.js called HelloWorld that contains a H1 header with "Hello, world!" and replace the ```<App />``` tag in root.render with ```<HelloWorld />```.

```jsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';

function HelloWorld() {
  return <h1 className="greeting">Hello, world!</h1>;
}

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <HelloWorld />
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
```

Once you save the index.js file, the running instance of the server will update the web page and you'll see "Hello World!" when you refresh your browser.

Tip: VS Code supports Auto Save, which by default saves your files after a delay. Check the Auto Save option in the File menu to turn on Auto Save or directly configure the files.autoSave user setting.

## Debugging React

To debug the client side React code, we'll use the built-in JavaScript debugger.

Note: This tutorial assumes you have the Edge browser installed. If you want to debug using Chrome, replace the launch type with chrome. There is also a debugger for the Firefox browser.

## Set a breakpoint

To set a breakpoint in index.js, click on the gutter to the left of the line numbers. This will set a breakpoint which will be visible as a red circle.

## Configure the debugger

We need to initially configure the debugger. To do so, go to the Run and Debug view (Ctrl+Shift+D) and select the create a launch.json file link to create a launch.json debugger configuration file. Choose Web App (Edge) from the Select debugger dropdown list. This will create a launch.json file in a new .vscode folder in your project which includes a configuration to launch the website.

We need to make one change for our example: change the port of the url from 8080 to 3000. Your launch.json should look like this:

Note: This works but I think it is better to use Chrome and React Developer tools extension to debug.

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "chrome",
            "request": "launch",
            "name": "Launch Chrome against localhost",
            "url": "http://localhost:3000",
            "webRoot": "${workspaceFolder}/volumes/reactjs/my-app"
        },
    ]
}
```

Ensure that your development server is running (npm start). Then press F5 or the green arrow to launch the debugger and open a new browser instance. The source code where the breakpoint is set runs on startup before the debugger was attached, so we won't hit the breakpoint until we refresh the web page. Refresh the page and you should hit your breakpoint.

You can step through your source code (F10), inspect variables such as HelloWorld, and see the call stack of the client side React application.

![](https://code.visualstudio.com/assets/docs/nodejs/reactjs/debug-variable.png)

For more information about the debugger and its available options, check out our documentation on **[browser debugging](https://code.visualstudio.com/docs/nodejs/browser-debugging)**.
