---
bibliography: bibliography.bib
---

# Gold star reproducibility: tools for reproducible research in R

This repository supports a presentation called ‘Gold star reproducibility' given at R-Ladies Montpellier (2/7/19), R-Ladies Sydney (28/8/19), and University of New South Wales (28/8/19). The presentation is in the `rladies_reproducibility.key` and `rladies_reproducibility.pdf` files. I've written out some of my thoughts here, because there aren't a lot of details in the slides. 

## Why reproducibility?

A key tenet of scientific research is that our conclusions and the results they depend upon can be reliably reproduced. We are increasingly aware that this is not the case for many scientific disciplines (Baker 2016), for a variety of reasons. These include but are not limited to (Fidler et al. 2017):

- publication bias
- questionable research practices driven by a 'publish or perish' culture
- inadequate data reporting
- insufficient data and code sharing

## So what do we do? 

Tackling broader problems associated with irreproducibility requires systemic changes, but there are still steps individual researchers can take. Computational reproducibility, or the ability to rerun an analysis and get the same results, is one step. We have many open science tools to help us achieve this (Lowndes et al. 2017), some of which we discuss here. 

## Compendium 

Reproducible research relies upon an organisation system that holds all the components of a project together. We've begun to call this structure a research `compendium`, and is discussed in more detail in (Marwick, Boettiger, and Mullen 2018).

The key concepts for me, are: 

- organisation: separating your raw data from the code used to produce it
- documentation: clear metadata, including dependencies
- automation: a master script or other way (like the [drake](https://github.com/ropensci/drake) package workflows) to clarify the sequence of the components
- dissemination: clear ways to share

A range of R packages have been developed to make it easier to set up projects in line with these principles. There is a great list of these resources [here](https://github.com/jdblischak/r-project-workflows). 

## Containerisation

Even after setting up a project according to these principles, code can fail to reproduce. Have you ever had trouble re-running an analysis due to changes in one of the packages you used? Or had trouble sharing code with a collaborator because you're working on different versions of R? I have! 

Containerisation is one solution. I'll give a brief explanation of concepts related to containerisation here, but disclaimer, I am not a computer scientist! I am attempting to explain these concepts in a way that would have helped me, a non-computer scientist, to grasp them more quickly. 

Containerisation refers to creating a virtual computing environment. It is more lightweight than a virtual machine, because you only specify the exact items you would like to be installed in your environment, rather than having an entire ecosystem in it. It is popularly implemented with a software called [docker](https://www.docker.com/). 

Although there are many ways to use docker, in the context of creating a computing environment for a compendium, there are three main terms important to understand. I'm going to make an analogy with tiny houses to explain them. Bear with the laboured analogy. 

### Terms

A **'dockerfile'** is the instructions for building up your tiny house. It says, take this set of building materials, and give me a kitchen, a loft, a portico and a window garden bed, please. But maybe instead it's, please give me R 3.6.0 and the `tidyverse`. A dockerfile can live on your computer, or you can push it up to something like Github to share it. 

A **'docker image'** is a built tiny house. You've taken the instructions in your Dockerfile and built the additions to your house. A docker image is your built virtual environment containing the installed versions of everything you specified. This built image can live on your computer or you can push it up to the cloud, such as to [dockerhub](http://dockerhub.com), where other people can use it.

A **'docker container'** is an instance of stepping inside your tiny house. You have driven it to Banff, or wherever your dream destination is, everything you need (that you specified in the build...) is there and you finally step in. A docker container is an instance of entering your virtual environment. Once there, you can make use of everything you specified in the build. 

Whew. Hope that went down well. 

### Tools

There are many tools and packages to build the bridge between R and docker. [containerit](https://github.com/o2r-project/containerit) and [holepunch](http://github.com/karthik/holepunch) are two such packages. Both help to automatically create a dockerfile. `containerit` is a great resource and very flexible. I demonstrate `holepunch` here for two reasons that are also tied to the main functions:

1. `holepunch` helps users automatically populate a `DESCRIPTION` file with meta data including the packages the project uses, and then leverages this to add the packages to the dockerfile. The resulting dockerfile can be found in the `.binder` folder. I like this approach because it builds on the principles of research compendiums by encouraging transparent meta data. 

``` r
holepunch::write_compendium_description()
holepunch::write_dockerfile()
```

2. `holepunch` does not require docker to be pre-installed. This provides an good starting point to begin learning about how to employ docker and to begin to containerise repositories without the headaches of installation. Typically, it is necessary to have docker installed on your computer so that it can build the docker image from your dockerfile. Instead, `holepunch` relies on [binder](http://mybinder.org) to build the docker image for you. One consequence of this is that you cannot, for example, push it to docker hub as a built image for others to use.
  
``` r
holepunch::generate_badge()
```

This function produces the text to paste into a `README` file so there is an easy link to open the binder instance of your project. Let’s take a look at ours now:

[![Launch Rstudio Binder](http://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/smwindecker/holepunch_rladies/master?urlpath=rstudio)

A complete example for a paper can be found [here](https://github.com/Lingtax/PMT-flu-2018)\!

Any comments on this repo are welcome. Happy containerising\!

# References
Baker, Monya. 2016. “1,500 Scientists Lift the Lid on Reproducibility.” Nature News 533 (7604): 452. https://doi.org/10.1038/533452a.

Fidler, Fiona, Yung En Chee, Bonnie C. Wintle, Mark A. Burgman, Michael A. McCarthy, and Ascelin Gordon. 2017. “Metaresearch for Evaluating Reproducibility in Ecology and Evolution.” BioScience 67 (3): 282–89. https://doi.org/10.1093/biosci/biw159.

Lowndes, Julia S. Stewart, Benjamin D. Best, Courtney Scarborough, Jamie C. Afflerbach, Melanie R. Frazier, Casey C. O’Hara, Ning Jiang, and Benjamin S. Halpern. 2017. “Our Path to Better Science in Less Time Using Open Data Science Tools.” Nature Ecology & Evolution 1 (6): 0160. https://doi.org/10.1038/s41559-017-0160.

Marwick, Ben, Carl Boettiger, and Lincoln Mullen. 2018. “Packaging Data Analytical Work Reproducibly Using R (and Friends).” e3192v2. PeerJ Inc. https://doi.org/10.7287/peerj.preprints.3192v2.
