# **[Graphviz Markdown Preview](https://marketplace.visualstudio.com/items?itemName=geeklearningio.graphviz-markdown-preview)**

## references

<https://graphviz.org/gallery/>

<https://dreampuf.github.io/GraphvizOnline/>
<https://edrawmax.wondershare.com/visio-alternative/open-source-visio-alternative.html>

## Graph Visualization

Graph visualization is a way of representing structural information as diagrams of abstract graphs and networks. Automatic graph drawing has many important applications in software engineering, database and web design, networking, and in visual interfaces for many other domains.

Graphviz is open source graph visualization software. It has several main graph layout programs. See the Gallery for some sample layouts. It also has web and interactive graphical interfaces, and auxiliary tools, libraries, and language bindings.

The Mac OS X edition of Graphviz, by Glen Low, won two 2004 Apple Design Awards.

Adds Graphviz support to VSCode's builtin markdown preview

Installation
Launch VS Code Quick Open (Ctrl+P), paste the following command, and press enter.
```ext install geeklearningio.graphviz-markdown-preview```

```graphviz
digraph finite_state_machine {
    rankdir=LR;
    size="8,5"

    node [shape = doublecircle]; S;
    node [shape = point ]; qi

    node [shape = circle];
    qi -> S;
    S  -> q1 [ label = "a" ];
    S  -> S  [ label = "a" ];
    q1 -> S  [ label = "a" ];
    q1 -> q2 [ label = "ddb" ];
    q2 -> q1 [ label = "b" ];
    q2 -> q2 [ label = "b" ];
}
```
