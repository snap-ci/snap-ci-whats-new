PHP is in!

Snap now supports PHP. You can select your favorite version from the PHP language drop down on the configuration page. To check the versions Snap supports [click here](http://docs.snap-ci.com/the_ci_environment/languages/#php)..

Snap now detects when your build runs out of memory. We'll send you an email when this happens. You now have the option to get in touch with us and request more resources to run your build.

We now provide a few more environment variables for your builds:

* `TRACKING_PIPELINE` - set to `true` if the pipeline is a tracking pipeline
* `INTEGRATION_PIPELINE` - set to `true` if the pipeline is an integration pipeline
* `SNAP_CACHE_DIR` - if you store any files here, we'll try our best to keep it around across pipeline runs

Some users have had issues with Snap being unable to handle periods "." in branch names, we have fixed this.

We want to hear from you! If you have any feedback or features you would love to see in Snap, [click here](http://snap-ci.com/contact-us) and let us know.
