Re-run older builds is now supported!

* Snap will let you re-run any previous build.
* The "rerun last pipeline" link has been removed.

Improvements to tests that need X-Server (selenium etc):

* We have improved how browser based tests run.
* All your tests run in an XVfb server, and we make a `DISPLAY` variable for ease of use.
