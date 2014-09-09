Pull request integration

* Collaborate more easily as Snap now listens for pull requests issued against your repository and automatically attempts to merge and builds them!
* We not only tell you what if the pull request was good on the day it was issued, but also let you re-run the build so you know if it is good on the day you are ready to to merge it!
* Read more about pull-request integration in our [documentation](http://docs.snap-ci.com/working-with-branches/pull-requests/)

Little things, nice things and bug fixes

* The name of the person who triggers a manual stage is available as an environment variable to your build: SNAP_STAGE_TRIGGERED_BY
* You can remove an environment variable and and add another with the same name in without triggering an error. Oops!
* The value of a newly created environment variable is preserved across stages when editing a plan.
