# cocoda-workshop

> Material for workshops about [Cocoda mapping tool]

[Cocoda mapping tool]: https://coli-conc.gbv.de/cocoda/


## SWIB19: Controlled vocabulary mapping with Cocoda

Workshop at the [SWIB19](http://swib.org/swib19/) conference

## Summary

* Facilitators: Jakob Voß and Uma Balakrishnan (Verbundzentrale des GBV, Germany)
* Location: [Katholische Akademie Hamburg](http://swib.org/swib19/general-information.html)
* Date and Time: November 25th, 13:00-18:00

## Abstract

During the last years we developed the [web application Cocoda](https://coli-conc.gbv.de/cocoda/) for creating and managing mappings between library classification schemes, authority files, knowledge graphs, and similar knowledge organization systems. The workshop will introduce you to the technical background of Cocoda and vocabulary mappings. You will learn how to set up and configure your own instance of Cocoda and related services, and how to integrate additional vocabularies. We will explore the [JSKOS data format](https://gbv.github.io/jskos/jskos.html) and APIs, discuss integration of additional data sources and brainstorm about quality assurance and usability.

The participants are required to bring their own computer with ~NodeJS (at least version 8), git~ VirtualBox, and basic practical knowledge of processing JSON files. Participants are encouraged to bring their own vocabularies, mappings, and/or data sources

## Workshop Material

* A VirtualBox Virtual Machine is available at <https://coli-conc.gbv.de/download/> (file `cocoda.ova`). Please install and try to log in in advance! Username and password are both `cocoda`.
    * File `ubuntu-setup.md` in this repository documents setup of this virtual machine 
    * To update the current machien run `npm install -g jskos-cli` 

* Workshop [slides source](swib19.slides.md) are available in this repository.
