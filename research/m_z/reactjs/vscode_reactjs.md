# **[Using React in Visual Studio Code](../../../volumes/reactjs/my-app/vscode_reactjs.md)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

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

```jsx
pushd .
cd ~/src/repsys/volumes/reactjs
npx create-react-app my-app
```
