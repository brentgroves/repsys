# **[YAML Tutorial: Everything You Need to Get Started in Minutes](<https://www.cloudbees.com/blog/yaml-tutorial-everything-you-need-get-started>)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[pipe operator](https://www.bevansbench.com/blog/understanding-pipe-character-yaml-multiline-strings-explained)**

YAML Ain't Markup Language (YAML) is a data serialization language that is consistently listed as one of the most popular programming languages. It's often used as a format for configuration files, but its object serialization abilities make it a viable replacement for languages like JSON. This YAML tutorial will demonstrate the language syntax with a guide and some simple coding examples in Python. YAML has broad language support and maps easily into native data structures. It's also easy for humans to read, which is why it's a good choice for configuration. The YAML acronym was shorthand for Yet Another Markup Language. But the maintainers renamed it to YAML Ain't Markup Language to place more emphasis on its data-oriented features.

## **[YAML Multiline - with test parser!](https://yaml-multiline.info/)**

Find the right syntax for your YAML multiline strings

There are two types of formats that YAML supports for strings: block scalar and flow scalar formats. (Scalars are what YAML calls basic values like numbers or strings, as opposed to complex types like arrays or objects.) Block scalars have more control over how they are interpreted, whereas flow scalars have more limited escaping support.

### Block Scalars

A block scalar header has three parts:

**Block Style Indicator:** The block style indicates how newlines inside the block should behave. If you would like them to be kept as newlines, use the literal style, indicated by a pipe (|). If instead you want them to be replaced by spaces, use the folded style, indicated by a right angle bracket (>). (To get a newline using the folded style, leave a blank line by putting two newlines in. Lines with extra indentation are also not folded.)

**Block Chomping Indicator:** The chomping indicator controls what should happen with newlines at the end of the string. The default, clip, puts a single newline at the end of the string. To remove all newlines, strip them by putting a minus sign (-) after the style indicator. Both clip and strip ignore how many newlines are actually at the end of the block; to keep them all put a plus sign (+) after the style indicator.

**Indentation Indicator:** Ordinarily, the number of spaces you're using to indent a block will be automatically guessed from its first line. You may need a block indentation indicator if the first line of the block starts with extra spaces. In this case, simply put the number of spaces used for indentation (between 1 and 9) at the end of the header.

## YAML Tutorial Quick Start: A Simple File

Let's take a look at a YAML file for a brief overview.

```yaml
---
 doe: "a deer, a female deer"
 ray: "a drop of golden sun"
 pi: 3.14159
 xmas: true
 french-hens: 3
 calling-birds:
   - huey
   - dewey
   - louie
   - fred
 xmas-fifth-day:
   calling-birds: four
   french-hens: 3
   golden-rings: 5
   partridges:
     count: 1
     location: "a pear tree"
   turtle-doves: two
 ```

The file starts with three dashes. These dashes indicate the start of a new YAML document. YAML supports multiple documents, and compliant parsers will recognize each set of dashes as the beginning of a new one. Next, we see the construct that makes up most of a typical YAML document: a key-value pair. The “doe” is a key that points to a string value: “a deer, a female deer”. YAML supports more than just string values. The file starts with six key-value pairs. They have four different data types. “doe” and “ray” are strings. The “pi” is a floating-point number. The “xmas” is a boolean. The “french-hens” is an integer. You can enclose strings in single(‘) or double-quotes(“) or no quotes at all. YAML recognizes unquoted numerals as integers or floating point. The seventh item is an array. The “calling-birds” has four elements, each denoted by an opening dash. I indented the elements in “calling-birds” with two spaces. Indentation is how YAML denotes nesting. **The number of spaces can vary from file to file, but tabs are not allowed.** We'll look at how indentation works below. Finally, we see “xmas-fifth-day”, which has five more elements inside it, each of them indented. We can view “xmas-fifth-day” as a dictionary that contains two string, two integers, and another dictionary. YAML supports nesting of key-values, and mixing types. Before we take a deeper dive, let's look at how this document looks in JSON. I'll throw it in this handy **[JSON to YAML converter](https://www.json2yaml.com/).

```json
{
  "doe": "a deer, a female deer",
  "ray": "a drop of golden sun",
  "pi": 3.14159,
  "xmas": true,
  "french-hens": 3,
  "calling-birds": [
     "huey",
     "dewey",
     "louie",
     "fred"
  ],
  "xmas-fifth-day": {
  "calling-birds": "four",
  "french-hens": 3,
  "golden-rings": 5,
  "partridges": {
    "count": 1,
    "location": "a pear tree"
  },
  "turtle-doves": "two"
  }
}
```

JSON and YAML have similar capabilities, and you can convert most documents between the formats.

## Outline Indentation and Whitespace

Whitespace is part of YAML's formatting. Unless otherwise indicated, newlines indicate the end of a field. You structure a YAML document with indentation. The indentation level can be one or more spaces. The specification forbids tabs because tools treat them differently. Consider this document. The items inside are indented with two spaces.

```yaml
foo: bar
pleh: help
stuff:
  foo: bar
  bar: foo
```

Let's take a look at how a simple python script views this document. We'll save it as a file named foo.yaml. The PyYAML package will map a YAML file stream into a dictionary. We'll iterate through the outermost set of keys and values and print the key and the string representation of each value. You can find a processor for your favorite platform here.

```python
Import yaml 

from yaml import load
try:
    from yaml import CLoader as Loader
except ImportError:
    from yaml import Loader

if __name__ == '__main__':

    stream = open("foo.yaml", 'r')
    dictionary = yaml.load(stream)
    for key, value in dictionary.items():
        print (key + " : " + str(value))
```

The output is:

```bash
foo : bar
pleh : help
stuff : {'foo': 'bar', 'bar': 'foo'}
```

When we tell python to print a dictionary as a string, it uses the inline syntax we'll see below. We can see from the output that our document is a python dictionary with two strings and another dictionary nested inside it. YAML's simple nesting gives us the power to build sophisticated objects. But that's only the beginning.

## **[Break a String Using a Block-Chomping Indicator](https://kodekloud.com/blog/yaml-multiline-string/#:~:text=With%20the%20plus%20%22%2B%22%20syntax,the%20end%20of%20the%20string.)**

With the plus "+" syntax, you keep all the line breaks at the end of the string. With the minus "-" syntax, you remove all the line breaks at the end of the string. If you do not provide the block chomping indicator, one line break will be automatically added to the end of the string.

Break a String Using a Block-Chomping Indicator
You can mix the block scalar styles with a block-chomping indicator, using a "+" or "-" to handle the line breaks at the end of the string.

- With the plus "+" syntax, you keep all the line breaks at the end of the string.
- With the minus "-" syntax, you remove all the line breaks at the end of the string.
- If you do not provide the block chomping indicator, one line break will be automatically added to the end of the string.

## **[pipe operator](https://www.bevansbench.com/blog/understanding-pipe-character-yaml-multiline-strings-explained)**

What Does the Pipe Character Do in YAML?
YAML is a really popular language for writing configuration files, thanks to how straightforward and readable it is. A key feature it offers is the use of the pipe character | to write strings over multiple lines. This is especially useful when you need to keep the formatting exactly as intended. Let's dive into this with a practical example.

## Real-World Application

Understanding when to utilize YAML's pipe character | can streamline your configuration files, ensuring clarity and functionality. Let's look at how it works in various situations to see when it's really useful and when you might not need it.

Understanding Its Use with a Cron Job
Adding a cron job in YAML might first make you think you need the pipe character to keep things clear:

```yaml
cron_jobs:
  - "echo '* * * * * curl -s https://pocketgraph.lndo.site/cron/somekey' >> /etc/crontab"
```

This single-line command is straightforward and doesn't inherently require a multiline string. Demonstrating the use of | for such a simple command:

```yaml
cron_jobs:
  - |
    echo "* * * * * curl -s https://pocketgraph.lndo.site/cron/somekey" >> /etc/crontab
```

In this situation, using the | does keep the command intact, but it might be a bit too much. It's really better to use this feature when you have commands or scripts that stretch over several lines. This shows that even though you'll see the pipe character used this way in different YAML files, you should think carefully about when to use it. Focus on making things easy to read and on what the script needs, rather than using it just because you can.

## Where the Pipe Truly Shines: Complex Scripts

The necessity and effectiveness of the pipe character are unquestionable when embedding intricate scripts within your YAML configurations:

```yaml
backup_script:
  - |
    #!/bin/bash
    TIMESTAMP=$(date +'%Y-%m-%d_%H%M%S')
    BACKUP_DIR="/var/backup/$TIMESTAMP"
    mkdir -p $BACKUP_DIR
    pg_dumpall -U postgres > $BACKUP_DIR/alldb.sql
```

Here, the | is crucial. It makes sure the whole script is seen as one piece, keeping important things like new lines and spaces just right. This attention to detail is super important for scripts where every line, indent, and space can change how things work. By keeping the script's format correct, the pipe character helps make sure it runs exactly as it's supposed to, avoiding any mistakes or unexpected actions.

## Advanced Options

### Chomp Modifiers

Multiline values may end with whitespace, and depending on how you want the document to be processed you might not want to preserve it. YAML has the strip chomp and preserve chomp operators. To save the last character, add a plus to the fold or block operators.

```yaml
bar: >+
  this is not a normal string it
  spans more than
  one line
  see?
```

So, if the value ends with whitespace, like a newline, YAML will preserve it. To strip the character, use the strip operator.

```yaml
bar: |-
  this is not a normal string it
  spans more than
  one line
  see?
```

## Multiple documents

A document starts with three dashes and ends with three periods. Some YAML processors require the document start operator. The end operator is usually optional. For example, Java's Jackson will not process a YAML document without the start, but Python's PyYAML will. You'll usually use the end document operator when a file contains multiple documents. Let's modify our python code.

```python
import yaml

from yaml import load
try:
    from yaml import CLoader as Loader
except ImportError:
    from yaml import Loader

if __name__ == '__main__':
    stream = open("foo.yaml", 'r')
    dictionary = yaml.load_all(stream, Loader)

    for doc in dictionary:
        print("New document:")
        for key, value in doc.items():
            print(key + " : " + str(value))
            if type(value) is list:
                print(str(len(value)))
```

PyYAML's load_all will process all of the documents in a stream. Now, let's process a compound document with it.

```yaml
---
bar: foo
foo: bar
...
---
one: two
three: four
```

The script finds two YAML documents.

```bash
New document:
bar : foo
foo : bar
New document:
one : two
three : four
```
