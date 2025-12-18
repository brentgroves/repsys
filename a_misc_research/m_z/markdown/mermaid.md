https://mermaid.js.org/intro/syntax-reference.html
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;

```

- **[ER diagrams in Markdown](https://mermaid.js.org/intro/syntax-reference.html)**

```mermaid
erDiagram
          CUSTOMER }|..|{ DELIVERY-ADDRESS : has
          CUSTOMER ||--o{ ORDER : places
          CUSTOMER ||--o{ INVOICE : "liable for"
          DELIVERY-ADDRESS ||--o{ ORDER : receives
          INVOICE ||--|{ ORDER : covers
          ORDER ||--|{ ORDER-ITEM : includes
          PRODUCT-CATEGORY ||--|{ PRODUCT : contains
          PRODUCT ||--o{ ORDER-ITEM : "ordered in"
```

