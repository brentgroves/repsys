# **[Chisel](https://documentation.ubuntu.com/rockcraft/en/stable/explanation/chisel/#chisel-explanation)**

**[Back to Research List](../../../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../../../../README.md)**

**[Chisel](https://github.com/canonical/chisel)** is a software tool for extracting well-defined portions (aka slices) of Debian packages into a filesystem.

Using the analogy of a tool to carve and cut stone, Chisel is used in Rockcraft to sculpt minimal collections of files that only include what is needed for the rock to function properly.

See Cut existing slices with Chisel for information about using the tool.

## Package slices

Since Debian packages are simply archives that can be inspected, navigated and deconstructed, it is possible to define slices of packages that contain minimal, complementary, loosely-coupled sets of files based on package metadata and content. Such package slices are subsets of Debian packages, with their own content and set of dependencies to other internal and external slices.

The use of package slices provides Rockcraft with the ability to build minimal container images from the wider set of Ubuntu packages.

![i1](https://documentation.ubuntu.com/rockcraft/en/stable/_images/package-slices.svg)

This image illustrates the simple case where, at a package level, package B depends on package A. However, there might be files in A that B doesn’t actually need, but which are provided for convenience or completeness. By identifying the files in A that are actually needed by B, we can divide A into slices that serve this purpose. In this example, the files in the package slice, A_slice3, are not needed for B to function. To make package B usable in the same way, it can also be divided into slices.

With these slice definitions in place, Chisel is able to extract a highly-customised and specialised slice of the Ubuntu distribution, which one could see as a block of stone from which we can carve and extract only the small and relevant parts that we need to run our applications, thus keeping rocks small and less exposed to vulnerabilities.

Defining slices
A package’s slices can be defined via a YAML slice definitions file. Check the slice definitions reference for more information about this file’s format.

Note

To find examples of existing slice definitions files, check the Chisel releases repository at <https://github.com/canonical/chisel-releases>. Contributions are welcome and encouraged.
