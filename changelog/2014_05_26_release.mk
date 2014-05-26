Miscellaneous Improvements:

* Snap will let you re-run any previous build.
* The "rerun last pipeline" link has been removed.
* Grunt, Gulp and Bower are now installed and available.

Browser Tests and X-Server:

* All your tests run in an Xvfb server, and we make a `DISPLAY` variable for ease of use.
* If you have any `xvfb-run` commands in your build, you may safely remove them.
* Users who were using `--no-sandbox` for chromedriver may now remove that flag.
