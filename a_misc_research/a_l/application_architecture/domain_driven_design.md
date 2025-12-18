# **[An Introduction To Domain-Driven Design](https://learn.microsoft.com/en-us/archive/msdn-magazine/2009/february/best-practice-an-introduction-to-domain-driven-design)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

Domain-Driven Design(DDD) is a collection of principles and patterns that help developers craft elegant object systems. Properly applied it can lead to software abstractions called domain models. These models encapsulate complex business logic, closing the gap between business reality and code.

In this article, I'll cover the basic concepts and design patterns germane to DDD. Think of this article as a gentle introduction to designing and evolving rich domain models. To provide some context to the discussion, I'm using a complex business domain with which I'm familiar: insurance policy management.

If the ideas presented here appeal to you, I highly recommend that you deepen your toolbox by reading the book **[Domain-Driven Design: Tackling Complexity in the Heart of Software](https://www.amazon.com/gp/product/0321125215/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0321125215&linkCode=as2&tag=martinfowlerc-20)**, by Eric Evans. More than simply the original introduction to DDD, it is a treasure trove of information by one of the industry's most seasoned software designers. The patterns and core tenets of DDD that I will discuss in this article are derived from the concepts that are detailed in this book.

## Cutting Contexts by Architectural Need

Bounded Contexts needn't be organized solely by the functional area of an application. They're very useful in dividing a system to achieve desired architectural examples. The classic example of this approach is an application that has both a robust transactional footprint and a portfolio of reports.

It's often desirable in such circumstances (which might occur pretty often) to break out the reporting database from the transactional database. You want the freedom to pursue the right degree of normalization for developing reliable reports, and you want to use an Object-Relational Mapper so that you can keep coding transactional business logic in the object-oriented paradigm. You can use a technology such as Microsoft Message Queue (MSMQ) to publish data updates coming from the model and incorporate them into data warehouses optimized for reporting and analysis purposes.

This might come as a shock to some, but it's possible for database administrators and developers to get along. Bounded Contexts give you a glimpse of this promised land. If you're interested in architectural Bounded Contexts, I highly recommend keeping tabs on Greg Young's blog. He's quite experienced with and articulate about this approach and produces a fair amount of content on the subject.
