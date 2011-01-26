# Kalipso # 

Command line client and library for uploading sites to Kalipso.

## Installation ##

    gem install kalipso

## Basic usage ##

List your kalipso sites:

    $ kalipso sites

Add a site:

    $ kalipso add

(this will auto-assign a site name)

Or specify a name:

    $ kalipso add my_site

This will add the site to your account on Kalipso.

Link a site to a local directory:

    $ kalipso link my_site .

Upload a site:

    $ kalipso upload my_site


#### Copyright ####

Copyright (c) 2011 Paul Campbell. See LICENSE.txt for
further details.

