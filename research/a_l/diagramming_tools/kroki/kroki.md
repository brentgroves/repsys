# **[kroki](https://docs.kroki.io/kroki/setup/usage/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[github](https://github.com/yuzutech/kroki)**

## Creates diagrams from textual descriptions

Kroki provides a unified API with support for BlockDiag (BlockDiag, SeqDiag, ActDiag, NwDiag, PacketDiag, RackDiag), BPMN, Bytefield, C4 (with PlantUML), D2, DBML, Ditaa, Erd, Excalidraw, GraphViz, Mermaid, Nomnoml, Pikchr, PlantUML, Structurizr, SvgBob, Symbolator, TikZ, UMLet, Vega, Vega-Lite, WaveDrom, WireViz... and more to come!

📢 We're planning the future of Kroki, and we need your insights!

Please take a moment to fill out our **[short questionnaire](https://forms.gle/2wLAsNCppAFqJ4a58)** – your feedback is crucial in helping us grow.

## Features

- Ready to use
- Diagrams libraries are written in a variety of languages: Haskell, Python, JavaScript, Go, PHP, Java... some also have C bindings. Trust us, you have better things to do than install all the requirements to use them. Get started in no time!
- **Simple:** Kroki provides a unified API for all the diagram libraries. Learn once use diagrams anywhere!
- **Free & Open source:** All the code is available on GitHub and our goal is to provide Kroki as a free service.
- **Fast:** Built using a modern architecture, Kroki offers great performance.

## Try

```plantuml
skinparam ranksep 20
skinparam dpi 125
skinparam packageTitleAlignment left

rectangle "Main" {
  (main.view)
  (singleton)
}
rectangle "Base" {
  (base.component)
  (component)
  (model)
}
rectangle "<b>main.ts</b>" as main_ts

(component) ..> (base.component)
main_ts ==> (main.view)
(main.view) --> (component)
(main.view) ...> (singleton)
(singleton) ---> (model)
```

**[plantuml](https://kroki.io/plantuml/svg/eNpljzEPgjAQhff-iguTDFQlcYMmuru5mwNO0tCWhjY6GP-7LRJTdHvv7r67d26QxuKEGiY0gyML5Y65b7GzEvblIalYbAfs6SK9oqOSvdFkPCi6ecYmaj2aXhFkZ5QmgycD2Ogg-V3SI4_OyTjgR5OzVwqc0NECNEHydtR2NGH3TK2dHjtSP3zViPmQd9W2ERmgg-iv3jGW4MC5-L-wTEJdi1XeRENRiFWOtMfnrclriQ5gJD-Z3x9beAM=)**

```blockdiagram
blockdiag {
  Kroki -> generates -> "Block diagrams";
  Kroki -> is -> "very easy!";

  Kroki [color = "greenyellow"];
  "Block diagrams" [color = "pink"];
  "very easy!" [color = "orange"];
}
```

**[example](https://kroki.io/blockdiag/svg/eNpdzDEKQjEQhOHeU4zpPYFoYesRxGJ9bwghMSsbUYJ4d10UCZbDfPynolOek0Q8FsDeNCestoisNLmy-Qg7R3Blcm5hPcr0ITdaB6X15fv-_YdJixo2CNHI2lmK3sPRA__RwV5SzV80ZAegJjXSyfMFptc71w==)**

## Examples

Looking for inspiration? Visit the **[examples](https://kroki.io/examples.html)** page.

## **[Getting Started](https://hub.docker.com/r/yuzutech/kroki)**

## Usage

See also the **[installation⁠ docs](https://docs.kroki.io/kroki/setup/configuration/)** in the **[Kroki documentation](https://docs.kroki.io/⁠)**

start a kroki instance

```bash
docker run --name some-kroki -d yuzutech/kroki
```

This image includes EXPOSE 8000 (the kroki port), so standard container linking will make it automatically available to the linked containers. If you want to map port 8000 in the container to a port on your host, please use the --publish or -p flag:

```bash
docker run -p8000:8000 --name some-kroki -d yuzutech/kroki
# test
http://localhost:8000/graphviz/svg/eNpLyUwvSizIUHBXqPZIzcnJ17ULzy_KSanlAgB1EAjQ
```

connect with companion containers

We recommend using docker-composer to connect with companion containers, such as kroki-bpmn, kroki-excalidraw and kroki-mermaid

```yaml
version: "3"
services:
  core:
    image: yuzutech/kroki
    environment:
      - KROKI_MERMAID_HOST=mermaid
      - KROKI_BPMN_HOST=bpmn
      - KROKI_EXCALIDRAW_HOST=excalidraw
    ports:
      - "8000:8000"
  mermaid:
    image: yuzutech/kroki-mermaid
    ports:
      - "8002:8002"
  bpmn:
    image: yuzutech/kroki-bpmn
    ports:
      - "8003:8003"
  excalidraw:
    image: yuzutech/kroki-excalidraw
    ports:
      - "8004:8004"
```

## HTTP Clients

You can interact with Kroki using any HTTP client. In the following example, we will demonstrate how to send requests using cURL and HTTPie.

Using cURL to interact with the API is straightforward, open a terminal and type:

```bash
curl https://kroki.io/graphviz/svg --data-raw 'digraph G {Hello->World}'
```

If you are more familiar with HTTPie, you can send a JSON request:

```bash
http https://kroki.io/ diagram_type='graphviz' output_format='svg' diagram_source='digraph G {Hello->World}'
```
