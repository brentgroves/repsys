# **[Power BI semantic models in Microsoft Fabric](https://learn.microsoft.com/en-us/fabric/data-warehouse/semantic-models)**

In Microsoft Fabric, Power BI semantic models are a logical description of an analytical domain, with metrics, business friendly terminology, and representation, to enable deeper analysis. This semantic model is typically a star schema with facts that represent a domain, and dimensions that allow you to analyze, or slice and dice the domain to drill down, filter, and calculate different analyses.

When you create a semantic model on a lakehouse or warehouse, you choose which tables to add. From there, you can **[manually update a Power BI semantic model](https://learn.microsoft.com/en-us/fabric/data-warehouse/semantic-models#manually-update-a-power-bi-semantic-model)**.

 Note

Starting September 5, 2025, Power BI default semantic models are no longer created automatically when a warehouse, lakehouse, or mirrored item is created. If your item doesn't have a semantic model already, you can create a Power BI semantic model. Existing default semantic models will be converted to regular semantic models. For more information, see Sunsetting Default Semantic Models.
