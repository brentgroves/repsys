# **[Command line options in the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-options.html)**

In the AWS CLI, command line options are global parameters you can use to override the default configuration settings, any corresponding profile setting, or environment variable setting for that single command. You can't use command line options to directly specify credentials, although you can specify which profile to use.

## How to use command line options

Most command line options are simple strings, such as the profile name profile1 in the following example:

```bash
$ aws s3 ls --profile profile1
amzn-s3-demo-bucket1
amzn-s3-demo-bucket2
...
```

Each option that takes an argument requires a space or equals sign (=) separating the argument from the option name. If the argument value is a string that contains a space, you must use quotation marks around the argument. For details on argument types and formatting for parameters, see **[Specifying parameter values in the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters.html)**.
