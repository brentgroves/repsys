# **[Keychain issues](https://code.visualstudio.com/docs/configure/settings-sync#_troubleshooting-keychain-issues)**

## Troubleshooting keychain issues

Note: This section applies to VS Code version 1.80 and higher. In 1.80, we moved away from keytar, due to its archival, in favor of Electron's safeStorage API.

Note: keychain, keyring, wallet, credential store are synonymous in this document.

Settings Sync persists authentication information on desktop using the OS keychain for encryption. Using the keychain can fail in some cases if the keychain is misconfigured or the environment isn't recognized.

To help diagnose the problem, you can restart VS Code with the following flags to generate a verbose log:

code --verbose --vmodule="*/components/os_crypt/*=1"

Linux
Towards the top of the logs from the previous command, you will see something to the effect of:

[9699:0626/093542.027629:VERBOSE1:key_storage_util_linux.cc(54)] Password storage detected desktop environment: GNOME
[9699:0626/093542.027660:VERBOSE1:key_storage_linux.cc(122)] Selected backend for OSCrypt: GNOME_LIBSECRET
Copy
We rely on Chromium's oscrypt module to discover and store encryption key information in the keyring. Chromium supports a number of different desktop environments. Outlined below are some popular desktop environments and troubleshooting steps that may help if the keyring is misconfigured.

## GNOME or UNITY (or similar)

If the error you're seeing is "Cannot create an item in a locked collection", chances are your keyring's Login keyring is locked. You should launch your OS's keyring (Seahorse is the commonly used GUI for seeing keyrings) and ensure the default keyring (usually referred to as Login keyring) is unlocked. This keyring needs to be unlocked when you log into your system.

## Other Linux desktop environments

First off, if your desktop environment wasn't detected, you can open an issue on VS Code with the verbose logs from above. This is important for us to support additional desktop configurations.

(recommended) Configure the keyring to use with VS Code
You can manually tell VS Code which keyring to use by passing the password-store flag. Our recommended configuration is to first install gnome-keyring if you don't have it already and then launch VS Code with code --password-store="gnome-libsecret".

If this solution works for you, you can persist the value of password-store by opening the Command Palette (Ctrl+Shift+P) and running the Preferences: Configure Runtime Arguments command. This will open the argv.json file where you can add the setting "password-store":"gnome-libsecret".

Here are all the possible values of password-store if you would like to try using a different keyring than gnome-keyring:

kwallet5: For use with kwalletmanager5.
gnome-libsecret: For use with any package that implements the Secret Service API (for example gnome-keyring, kwallet5, KeepassXC).
(not recommended) kwallet: For use with older versions of kwallet.
(not recommended) basic: See the section below on basic text for more details.
Don't hesitate to open an issue on VS Code with the verbose logs if you run into any issues.

## (not recommended) Configure basic text encryption

We rely on Chromium's oscrypt module to discover and store encryption key information in the keyring. Chromium offers an opt-in fallback encryption strategy that uses an in-memory key based on a string that is hardcoded in the Chromium source. Because of this, this fallback strategy is, at best, obfuscation, and should only be used if you are accepting of the risk that any process on the system could, in theory, decrypt your stored secrets.

If you accept this risk, you can set password-store to basic by opening the Command Palette (Ctrl+Shift+P) and running the Preferences: Configure Runtime Arguments command. This will open the argv.json file where you can add the setting "password-store":"basic".
