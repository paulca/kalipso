# Kalipso # 

Command line client and library for uploading sites to Kalipso.


## Basic setup ##

Add a folder as a Kalipso site:

    $ cd Sites/my_site
    $ kalipso sites:add .

(this will auto-assign a site name)

Or specify a name:

    $ kalipso sites:add . --name my_site

This will add the site to your account on Kalipso.

## Listing your sites ##

List your sites

    $ kalipso sites
    SITENAME => /path/to/local

## Uploading a site ##

    $ kalipso upload SITENAME
    http://SITENAME.diddlydum.com


== Copyright

Copyright (c) 2011 Paul Campbell. See LICENSE.txt for
further details.

