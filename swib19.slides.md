---
title: Controlled vocabulary mapping with Cocoda
author: Jakob Voß
date: 2019-11-25
---

# Welcome!

* Uma Balakrishnan (project lead) <balakrishnan@gbv.de> 

* Jakob Voß (technical coordination) <voss@gbv.de> 

* Stefan Peters (development) <peters@gbv.de> 

  $\Rightarrow$ <https://meet.jit.si/cocoda>


<https://coli-conc.gbv.de/contact/>

<https://github.com/gbv/cocoda-workshop> (material)

<https://etherpad.wikimedia.org/p/cocoda> (share notes)

# Sorry!

* We have been overbooked accidently! (I planned for 12)

* Our main developer is not here

* Please help out each other!

# Outline

* When
    * 13:00 Welcome & introduction
    * 13:30 start hacking
    * 15:30 cake break!
    * 17:30 end hacking

* What
    1. **[coli-conc]**, the project
    2. **[cocoda]**, the web application
    3. **[JSKOS]**, the data format

# coli-conc data, software and services

* KOS registry / BARTOC\
  <https://github.com/gbv/kos-registry>

* Data dumps _(need some maintainance)_

* Software: <https://coli-conc.gbv.de/publications/software/>
  _(including prototypes, internal modules and outdated stuff)_

* Services $\rightarrow$ see APIs used in Cocoda
  <https://coli-conc.gbv.de/registry/>

# Cocoda software: it's open source!

* git repositories at GitHub
* we use GitHub issue tracker
* releases at GitHub or via npmjs _(+ packagist & CPAN)_

# Cocoda software architecture

---

![](img/architecture.jpg){height=100% width=60%}

# Cocoda software architecture

* Web client: Vue.js JavaScript Framework, ES6

* Backend services (several web services)
    * JSKOS API
    * Login-Server (OAuth, LDAP, ...)
    * Skosmos API
    * OpenRefine Reconciliation API
    * ...

* Mostly in NodeJS _(no requirement)_

* MongoDB databases _(no requirement)_

# Cocoda components

* accounts (indirect authentification via login-server)

* databases and services (backends)

* vocabularies (=concept schemes)

* concepts

* mappings

* annotations

* concept lists

# Accounts

* Single-Sign on

* ORCID, GitHub, Wikidata, StackExchange, LDAP...

* Referenced with URI and optional name in mappings and annotations

*Please use Wikidata-Account for writing into Wikidata!*

# Try it out!

<https://coli-conc.gbv.de/cocoda/> (several instances)

<https://coli-conc.gbv.de/cocoda/dev/> (most recent)

*Let's do some mappings (e.g. Wikidata-Iconclass, RVK-BK, ...)*

\hfill

* Please self-organize in groups,\
  wrap-up comments from each group afterwards!

# JSKOS data format

* JSKOS data format for Knowledge Organization Systems

* <https://gbv.github.io/jskos/>

* Eventually SKOS + extensions in JSON-LD

* Available in Cocoda via source-icons "![](img/code.svg){height=1em width=1em}"

# JSKOS overview: resources

* items
    * concepts
    * concept schemes
    * mappings
    * concordances
    * registries
* occorrences

# JKOS overview: fields

* item
    * uri
    * prefLabel
    * notation
    * type
    * ...

* concept
    * narrower, broader...

* concept schemes
    * topConcepts
    * notationPattern
    * ...

* mappings
    * fromScheme, toScheme
    * from, to
    * type

# JSKOS API

* Implemented and described at [JSKOS Server]

* Most API calls available via source-icon "![](img/code.svg){height=1em width=1em}"\
  try web developer tools otherwise

    * GET concepts (/data), schemes (/voc), mappings, annotations...
    * GET suggest & search
    * PUT/POST/DELETE mappings, annotations

# Let's get hacking!

* Start your virtual machine
* Open locally running Cocoda instance
* Try out and find more

# Building blocks and repositories

* cocoda - the web application
* jskos-server - JSKOS database and API
* jskos-data - data and scripts *of* vocabularies
* kos-registry - data and scripts *about* vocabularies

Not included here: login-server, wikidata-jskos...

# Change Cocoda configuration

* Located in `cocoda/config/cocoda.json`
* Hot reload with `npm run serve`
* Update build with `npm run build`

# Import vocabularies and mapping data

...

# Prepare your own vocabularies and mapping data

* Create JSKOS data format as newline delimited json
* validate with `jskos-validate`

# Export data from JSKOS server

* See API calls to jskos server, linked in the Cocoda UI

# Experienced programmers: modify Cocoda source code

Only required to extend and modify core functionality and layout

~~~bash
npm run serve
~~~

Local instance is available at <http://localhost:8081>, hot-reloading on
changes of the source files (`src/`)

Please send pull-requests and communicate changes via <https://github.com/gbv/cocoda/issues>!

[coli-conc]: https://coli-conc.gbv.de/
[cocoda]: https://coli-conc.gbv.de/cocoda/
[jskos]: http://gbv.github.io/jskos/
[JSKOS Server]: https://github.com/gbv/jskos-server
