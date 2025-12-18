# **[Presentation Domain Data Layering](https://martinfowler.com/bliki/PresentationDomainDataLayering.html)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Presentation Domain Data Layering

One of the most common ways to modularize an information-rich program is to separate it into three broad layers: presentation (UI), domain logic (aka business logic), and data access. So you often see web applications divided into a web layer that knows about handling HTTP requests and rendering HTML, a business logic layer that contains validations and calculations, and a data access layer that sorts out how to manage persistent data in a database or remote services.

![](https://martinfowler.com/bliki/images/presentationDomainDataLayering/all_basic.png)

On the whole I've found this to be an effective form of modularization for many applications and one that I regularly use and encourage. It's biggest advantage (for me) is that it allows me to reduce the scope of my attention by allowing me to think about the three topics relatively independently. When I'm working on domain logic code I can mostly ignore the UI and treat any interaction with data sources as an abstract set of functions that give me the data I need and update it as I wish. When I'm working on the data access layer I focus on the details of wrangling the data into the form required by my interface. When I'm working on the presentation I can focus on the UI behavior, treating any data to display or update as magically appearing by function calls. By separating these elements I narrow the scope of my thinking in each piece, which makes it easier for me to follow what I need to do.

This narrowing of scope doesn't imply any sequence to programming them - I usually find I need to iterate between the layers. I might build the data and domain layers off my initial understanding of the UX, but when refining the UX I need to change the domain which necessitates a change to the data layer. But even with that kind of cross-layer iteration, I find it easier to focus on one layer at a time as I make changes. It's similar to the switching of thinking modes you get with **[refactoring's two hats](https://martinfowler.com/articles/workflowsOfRefactoring/#2hats)**.

## Skipped some stuff

I've mentioned three layers here, but it's common to see architectures with more than three layers. A common variation is to put a service layer between the domain and presentation, or to split the presentation layer into separate layers with something like Presentation Model. I don't find that more layers breaks the essential pattern, since the core separations still remain.

![](https://martinfowler.com/bliki/images/presentationDomainDataLayering/all_more.png)

The dependencies generally run from top to bottom through the layer stack: presentation depends on the domain, which then depends on the data source. A common variation is to arrange things so that the domain does not depend on its data sources by introducing a mapper between the domain and data source layers. This approach is often referred to as a **[Hexagonal Architecture](http://alistair.cockburn.us/Hexagonal+architecture)**.

These layers are logical layers not physical tiers. I can run all three layers on my laptop, I can run the presentation and domain model in a desktop with a database on a server, I can split the presentation with a rich client in the browser and a Backed For Frontend on the server. In that case I treat the BFF as a presentation layer as it's focused on supporting a particular presentation option.

Although presentation-domain-data separation is a common approach, it should only be applied at a relatively small granularity. As an application grows, each layer can get sufficiently complex on its own that you need to modularize further. When this happens it's usually not best to use presentation-domain-data as the higher level of modules. Often frameworks encourage you to have something like view-model-data as the top level namespaces; that's OK for smaller systems, but once any of these layers gets too big you should split your top level into domain oriented modules which are internally layered.

![](https://martinfowler.com/bliki/images/presentationDomainDataLayering/all_top.png)

One common way I've seen this layering lead organizations astray is the AntiPattern of separating development teams by these layers. This looks appealing because front-end and back-end development require different frameworks (or even languages) making it easy for developers to specialize in one or the other. Putting those people with common skills together supports skill sharing and allows the organization to treat the team as a provider of a single, well-delineated type of work. In the same way, putting all the database specialists together fits in with the common centralization of databases and schemas. But the rich interplay between these layers necessitates frequent swapping between them. This isn't too hard when you have specialists in the same team who can casually collaborate, but team boundaries add considerable friction, as well as reducing an individual's motivation to develop the important cross-layer understanding of a system. Worse, separating the layers into teams adds distance between developers and users. Developers don't have to be full-stack (although that is laudable) but teams should be.
