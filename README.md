
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Testing out holepunch for containerisation

In this repo I’ve included an example project associated with a
presentation initially given at R-Ladies Montpellier called ‘Gold star
reproducibility: straightforward containerisation’. The presentation is
included both as a keynote file (so you can enjoy the gifs) or as a pdf
(static. sad face).

The example project is extremely simple, as it was only for
illustration. I’ve written a meagre rmarkdown file
(‘my\_brilliant\_paper’) that includes use of one package: ggplot2.
The idea behind [holepunch](http://github.com/karthik/holepunch) is that
with a few simple functions you can set up your project so that it can
be accessed in a container hosted on a server by [binder](mybinder.org).
The readme for holepunch is a fantastic resource.

In the presentation, I demo’d this workflow with the following steps of
code, that prepared this repo. First, you write a description file.
Holepunch finds the packages you use without you having to troll through
and specify them. We can see in ours that in addition to ggplot2 it has added rmarkdown, knitr,
and tinytex, which are needed to knit ‘my\_brilliant\_paper’.

``` r
holepunch::write_compendium_description()
```

After it was created, I filled in my project name and description in the description file
itself. Next, we use this description file to write up a docker file.

``` r
holepunch::write_dockerfile('Saras Windecker')
```

A dockerfile is basically the set of instructions that are used to
prepare an ‘image’, where these items are downloaded. This image can be
launched to open up a ‘container’ inside which you have everything you
specified in the dockerfile. This is a non-computer scientists’ take on
this complicated process. 

Lastly, we generate the link to our binder, so that we can advertise it
and others can try and recreate our work inside a space that has
everything downloaded that is necessary to rerun the project.

``` r
holepunch::generate_badge()
```

This function prints the badge text to your console, that you can then
paste into a readme file. Let’s take a look at ours now:

[![Launch Rstudio
Binder](http://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/smwindecker/holepunch_test/master?urlpath=rstudio)

A complete example for a paper can be found
[here](https://github.com/Lingtax/PMT-flu-2018)\!

I will be revising this repo and its contents as I prepare to give this
presentation in the future. Any comments are welcome. Happy
containerising!
