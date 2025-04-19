# VSCode Extensions

**[Ubuntu Desktop Install](../../ubuntu22-04/desktop-install.md)**\
**[Setup Development System](../../../development/report_system/setup_dev_system/setup_dev_system.md)**\
**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## How to install extensions

Launch VS Code Quick Open (Ctrl+P), paste the following command, and press enter.

## Markdown

- **[Back and Forth](https://marketplace.visualstudio.com/items?itemName=nick-rudenko.back-n-forth)**\
```ext install nick-rudenko.back-n-forth```
- **[Markdown Lint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)**\
```ext install DavidAnson.vscode-markdownlint```\

    **[configure format on save setting](https://code.visualstudio.com/docs/getstarted/settings#_language-specific-editor-settings)**

    VS Code provides different scopes for settings:

    User settings - Settings that apply globally to any instance of VS Code you open.\
    Workspace settings - Settings stored inside your workspace and only apply when the workspace is opened.

    To automatically format when saving or pasting into a Markdown document, configure Visual Studio Code's editor.formatOnSave or editor.formatOnPaste settings like so:\
    User Settings\
    editor.format On Save: checked\
    editor.format On Save Mode: file\
    Workspace Settings\
    "[markdown]": {
        "editor.formatOnSave": true,
        "editor.formatOnPaste": true
    },

Issue: the markdown formatter was not running after save so I added
You can open this file from VSCode's setting search by searching for "editor.codeActionsOnSave".

```json

    "editor.codeActionsOnSave": {
      "source.fixAll.markdownlint": true
    }

```

to the ~/home/brent/.config/Code/User/settings.json file.

```json
{
    "workbench.colorTheme": "Default Dark+",
    "git.enableSmartCommit": true,
    "git.autofetch": true,
    "editor.tabSize": 2,
    "editor.detectIndentation": false,
    "terminal.integrated.inheritEnv": false,
    "debug.javascript.autoAttachFilter": "smart",
    "remote.localPortHost": "allInterfaces",
    "redhat.telemetry.enabled": true,
    "window.zoomLevel": 0,
    "go.toolsManagement.autoUpdate": true,
    "workbench.editor.empty.hint": "hidden",
    "editor.formatOnSave": true,
    "editor.formatOnPaste": true,
    "editor.codeActionsOnSave": {
      "source.fixAll.markdownlint": true
    }
}
```

- **[Markdown PDF](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf)**\
```ext install yzane.markdown-pdf```
- **[Markdown Preview Mermaid](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid)**\
```ext install bierner.markdown-mermaid```
- **[Mermaid Markdown Syntax Highlighting](https://marketplace.visualstudio.com/items?itemName=bpruitt-goddard.mermaid-markdown-syntax-highlighting)**\
```ext install bpruitt-goddard.mermaid-markdown-syntax-highlighting```

## **[Web Development](https://medium.com/@gautammanak1/10-must-have-vscode-extensions-for-web-development-44b0d129ae56)**

- **[JavaScript Booster](https://marketplace.visualstudio.com/items?itemName=sburg.vscode-javascript-booster)**\
```ext install sburg.vscode-javascript-booster```
- **[ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)**\
```ext install dbaeumer.vscode-eslint```
- **[Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)**\
```ext install ritwickdey.LiveServer```
- **[CSS Peek](https://marketplace.visualstudio.com/items?itemName=pranaygp.vscode-css-peek#:~:text=Peek%3A%20load%20the%20css%20file,the%20symbol%20(%20Ctrl%2Bhover%20))**\
```ext install pranaygp.vscode-css-peek```
- **[IntelliSense for CSS class names in HTML](https://marketplace.visualstudio.com/items?itemName=Zignd.html-css-class-completion)**\
```ext install Zignd.html-css-class-completion```
- **[JavaScript (ES6) code snippets](https://marketplace.visualstudio.com/items?itemName=xabikos.JavaScriptSnippets)**
```ext install xabikos.JavaScriptSnippets```
- **[IntelliCode](https://marketplace.visualstudio.com/items?itemName=VisualStudioExptTeam.vscodeintellicode)**
```ext install VisualStudioExptTeam.vscodeintellicode```
- **[HTML Preview](https://marketplace.visualstudio.com/items?itemName=george-alisson.html-preview-vscode)**
```ext install george-alisson.html-preview-vscode```
