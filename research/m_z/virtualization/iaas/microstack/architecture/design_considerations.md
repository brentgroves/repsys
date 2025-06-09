# **[Design considerations](https://canonical-openstack.readthedocs-hosted.com/en/latest/explanation/design-considerations/)**

**[Back to Research List](../../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../../../README.md)**

There are a few design considerations that need to be taken into account before proceeding with Canonical OpenStack deployment. Understanding them and adjusting the design to fit individual requirements helps avoid costly changes at further stages of the project.

## Network architecture

In general, Canonical OpenStack is agnostic to the underlying network architecture. However, the best price-performance can be achieved by using as few tiers as possible. The most typical scenarios include a one-tier architecture and a two-tier architecture (aka Spine-Leaf).
