More love for artifacts

* You may now specify glob patterns as artifacts. Examples such as `target/*.jar` or `target/**/*.{deb,rpm}` will now work in Snap.
* Snap now allows files as artifacts.

Read more about artifacts in our [documentation](http://docs.snap-ci.com/pipeline/#artifact)

Even moar `sudo`!

* Snap earlier allowed limited `sudo` access for installing packages and managing services. We now offer you the convenience and power of full sudo access.
* You can now configure your build machine to your heart's content. Need extensive configuration - just throw in chef/puppet command in your configuration!

More freedom in defining stage names

* Stage names can now have numbers, hyphens and underscores. Examples are: `Fast_Feedback-1`, `Smoke-Deploy` and so on.
