# **[Configuring Keycloak](https://www.keycloak.org/server/configuration)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## references

- **[Configuring Keycloak for production](https://www.keycloak.org/server/configuration-production)**
- **[All configuration](https://www.keycloak.org/server/all-config)**
- **[guides](https://www.keycloak.org/guides)**
- **[quarkus](https://www.mastertheboss.com/keycloak/getting-started-with-keycloak-powered-by-quarkus/)**
- **[k8s without operator](https://www.keycloak.org/getting-started/getting-started-kube)**

## Configuring Keycloak

Understand how to configure and start Keycloak
This guide explains the configuration methods for Keycloak and how to start and apply the preferred configuration. It includes configuration guidelines for optimizing Keycloak for faster startup and low memory footprint.

## Configuring sources for Keycloak

Keycloak loads the configuration from four sources, which are listed here in order of application.

1. Command-line parameters
2. Environment variables
3. Options defined in the conf/keycloak.conf file, or in a user-created configuration file.
4. Sensitive options defined in a user-created Java KeyStore file.

When an option is set in more than one source, the one that comes first in the list determines the value for that option. For example, the value for an option set by a command-line parameter has a higher priority than an environment variable for the same option.

## Example: Configuring the db-url-host parameter

The following example shows how the db-url value is set in four configuration sources:

| Source                  | Format                  |
|-------------------------|-------------------------|
| Command line parameters | --db-url=cliValue       |
| Environment variable    | KC_DB_URL=envVarValue   |
| Configuration file      | db-url=confFileValue    |
| Java KeyStore file      | kc.db-url=keystoreValue |

Based on the priority of application, the value that is used at startup is cliValue, because the command line is the highest priority.

If --db-url=cliValue had not been used, the applied value would be KC_DB_URL=envVarValue. If the value were not applied by either the command line or an environment variable, db-url=confFileValue would be used. If none of the previous values were applied, the value kc.db-url=confFileValue would be used due to the lowest priority among the available configuration sources.

## Formats for configuration

The configuration uses a unified-per-source format, which simplifies translation of a key/value pair from one configuration source to another. Note that these formats apply to spi options as well.

- **Command-line parameter format**\
Values for the command-line use the ```--<key-with-dashes>=<value>``` format. For some values, an ```-<abbreviation>=<value>``` shorthand also exists.
- **Environment variable format**\
Values for environment variables use the uppercased ```KC_<key_with_underscores>=<value>``` format.
- **Configuration file format**\
Values that go into the configuration file use the ```<key-with-dashes>=<value>``` format.
**KeyStore configuration file format**\
Values that go into the KeyStore configuration file use the ```kc.<key-with-dashes> format. <value>``` is then a password stored in the KeyStore.

At the end of each configuration guide, look for the Relevant options heading, which defines the applicable configuration formats. For all configuration options, see **[All configuration](https://www.keycloak.org/server/all-config)**. Choose the configuration source and format that applies to your use case.

## Example - Alternative formats based on configuration source

The following example shows the configuration format for db-url-host for three configuration sources:

**command-line parameter**\
```bin/kc.[sh|bat] start --db-url-host=mykeycloakdb```

**environment variable**\
```export KC_DB_URL_HOST=mykeycloakdb```

**conf/keycloak.conf**\
```db-url-host=mykeycloakdb```

## Formats for command-line parameters

Keycloak is packed with many command line parameters for configuration. To see the available configuration formats, enter the following command:

```bin/kc.[sh|bat] start --help```

Alternatively, see **[All configuration](https://www.keycloak.org/server/all-config)** for all server options.

## Formats for environment variables

You can use placeholders to resolve an environment specific value from environment variables inside the keycloak.conf file by using the ${ENV_VAR} syntax:

```db-url-host=${MY_DB_HOST}```

In case the environment variable cannot be resolved, you can specify a fallback value. Use a : (colon) as shown here before mydb:

```db-url-host=${MY_DB_HOST:mydb}```

## Format to include a specific configuration file

By default, the server always fetches configuration options from the conf/keycloak.conf file. For a new installation, this file holds only commented settings as an idea of what you want to set when running in production.

You can also specify an explicit configuration file location using the [-cf|--config-file] option by entering the following command:

```bin/kc.[sh|bat] --config-file=/path/to/myconfig.conf start```

Setting that option makes Keycloak read configuration from the specified file instead of conf/keycloak.conf.

## Setting sensitive options using a Java KeyStore file

A Java KeyStore (JKS) is a repository of security certificates – either authorization certificates or public key certificates – plus corresponding private ...

Thanks to Keystore Configuration Source you can directly load properties from a Java KeyStore using the [--config-keystore] and [--config-keystore-password] options. Optionally, you can specify the KeyStore type using the [--config-keystore-type] option. By default, the KeyStore type is PKCS12.

The secrets in a KeyStore need to be stored using the PBE (password-based encryption) key algorithm, where a key is derived from a KeyStore password. You can generate such a KeyStore using the following keytool command:

```keytool -importpass -alias kc.db-password -keystore keystore.p12 -storepass keystorepass -storetype PKCS12 -v```

After executing the command, you will be prompted to Enter the password to be stored, which represents a value of the kc.db-password property above.

When the KeyStore is created, you can start the server using the following parameters:

```bin/kc.[sh|bat] start --config-keystore=/path/to/keystore.p12 --config-keystore-password=keystorepass --config-keystore-type=PKCS12```

In cryptography, **[PKCS #12](../../../m_z/pki/public_private_key_file_formats.md)** defines an archive file format for storing many cryptography objects as a single file. It is commonly used to bundle a private key with its X.509 certificate or to bundle all the members of a chain of trust. A PKCS #12 file may be encrypted and signed.

**[Password-based encryption (PBE)](https://www.crypto-it.net/eng/theory/pbe.html)**

## Format for raw Quarkus properties

In most cases, the available configuration options should suffice to configure the server. However, for a specific behavior or capability that is missing in the Keycloak configuration, you can use properties from the underlying Quarkus framework.

If possible, avoid using properties directly from Quarkus, because they are unsupported by Keycloak. If your need is essential, consider opening an enhancement request first. This approach helps us improve the configuration of Keycloak to fit your needs.

If an enhancement request is not possible, you can configure the server using raw Quarkus properties:

1. Create a quarkus.properties file in the conf directory.
2. Define the required properties in that file.

    You can use only a subset of the Quarkus extensions that are defined in the Quarkus documentation. Also, note these differences for Quarkus properties:

    - A lock icon for a Quarkus property in the Quarkus documentation indicates a build time property. You run the build command to apply this property. For details about the build command, see the subsequent sections on optimizing Keycloak.
    - No lock icon for a property in the Quarkus guide indicates a runtime property for Quarkus and Keycloak.
3. Use the [-cf|--config-file] command line parameter to include that file.

Similarly, you can also store Quarkus properties in a Java KeyStore.

Note that some Quarkus properties are already mapped in the Keycloak configuration, such as quarkus.http.port and similar essential properties. If the property is used by Keycloak, defining that property key in quarkus.properties has no effect. The Keycloak configuration value takes precedence over the Quarkus property value.

## Using special characters in values

Keycloak depends upon Quarkus and MicroProfile for processing configuration values. Be aware that value expressions are supported. For example, ```${some_key}``` evaluates to the value of some_key.

To disable expression evaluation, the \ character functions as an escape character. In particular, it must be used to escape the usage of $ characters when they appear to define an expression or are repeated. For example, if you want the configuration value my$$password, use my\$\$password instead. Note that the \ character requires additional escaping or quoting when using most unix shells, or when it appears in properties files. For example, bash single quotes preserve the single backslash --db-password='my\$\$password'. Also, with bash double quotes, you need an additional backslash --db-password="my\\$\\$password". Similarly in a properties file, backslash characters must also be escaped: kc.db-password=my\\$\\$password

## Starting Keycloak

You can start Keycloak in development mode or production mode. Each mode offers different defaults for the intended environment.

## Starting Keycloak in development mode

Use development mode to try out Keycloak for the first time to get it up and running quickly. This mode offers convenient defaults for developers, such as for developing a new Keycloak theme.

To start in development mode, enter the following command:

```bin/kc.[sh|bat] start-dev```

## Defaults

Development mode sets the following default configuration:

- HTTP is enabled
- Strict hostname resolution is disabled
- Cache is set to local (No distributed cache mechanism used for high availability)
- Theme-caching and template-caching is disabled

## Starting Keycloak in production mode

Use production mode for deployments of Keycloak in production environments. This mode follows a secure by default principle.

To start in production mode, enter the following command:

```bin/kc.[sh|bat] start```

Without further configuration, this command will not start Keycloak and show you an error instead. This response is done on purpose, because Keycloak follows a secure by default principle. Production mode expects a hostname to be set up and an HTTPS/TLS setup to be available when started.

## Production Mode Defaults

Production mode sets the following defaults:

- HTTP is disabled as transport layer security (HTTPS) is essential
- Hostname configuration is expected
- HTTPS/TLS configuration is expected

Before deploying Keycloak in a production environment, make sure to follow the steps outlined in **[Configuring Keycloak for production](https://www.keycloak.org/server/configuration-production)**.

By default, example configuration options for the production mode are commented out in the default conf/keycloak.conf file. These options give you an idea about the main configuration to consider when running Keycloak in production.

## Service Provider Interfaces (SPI)

Keycloak is designed to cover most use-cases without requiring custom code, but we also want it to be customizable. To achieve this Keycloak has a number of Service Provider Interfaces (SPI) for which you can implement your own providers.
