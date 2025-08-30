<https://community.sap.com/t5/technology-blog-posts-by-sap/where-did-all-the-crystal-reports-xi-r1-and-r2-fixes-go/ba-p/12946731>

With Crystal Reports XI R1 being out of support for over a year now, and CR XI R2 quickly approaching end of support (June 30, 2011), all CR XI R1 and CR XI R2 Fix Packs and Service Packs have been removed and replaced by Crystal Reports XI R2A. One of a number of reasons for this change is simplification. Rather than worrying about 10+ Service Packs the task is simplified to at most two downloads. The process of updating your install to CR XI R2A may be different for CR XI R1 and CR XI R2. Bellow is a description of each update.
Updating CR XI R1 install to CR XI R2A

1) Note your existing CR XI R1 keycode
2) Uninstall your current CR XI R1 product
3) Download the Crystal Reports XI R2A SP4 Full Build
4) Download the Crystal Reports XI R2A SP6 Incremental Build
5) Install Crystal Reports XI R2A SP4 Full Build using the CR XI R1 keycode you noted in step 1 above
6) Install Crystal Reports XI R2A SP6 Incremental Build - you will not be prompted for a keycode
7) Once both of the above are installed, open the Crystal Reports Designer. In the Help menu, select About Crystal Reports... Check the version. It should be 11.5.12.1838.
Updating CR XI R2 install to CR XI R2A

1) If you have CR XI R2 SP4 or SP5 (see the wiki Crystal Reports 2008 (and 9.1, XI R1, XI R2) - Version and Download information for Service Packs download the Crystal Reports XI R2A SP6 Incremental Build
2) Install Crystal Reports XI R2A SP6 Incremental Build
3) If you have CR XI R2 SP3 or lower download the Crystal Reports XI R2A SP4 Incremental Build
4) Install the Crystal Reports XI R2A SP4 Incremental Build
5) Download the Crystal Reports XI R2A SP6 Incremental Build
6) Install the Crystal Reports XI R2A SP6 Incremental Build
7) Once the install of Crystal Reports XI R2A SP6 Incremental Build is completed, open the Crystal Reports Designer. In the Help menu, select "About Crystal Reports...". Check the version. It should be 11.5.12.1838.

As an FYI, version of CR XI R2A SP4 is 11.5.10.1263, but updating this to SP6 as per above is highly recommended.
Runtime for CR XI R2A

There are no new runtime MSM or MSI files. Runtime MSM and MSI files from CR XI R2 apply to CR XI R2A:

CR XI R2 (SP6) MSM for .NET
CR XI R2 (SP6) MSI for .NET
CR XI R2 SP6 MSM for RDC

Please note:

Any comments, queries, suggestions etc. should be posted to the SAP Crystal Reports design Space.
