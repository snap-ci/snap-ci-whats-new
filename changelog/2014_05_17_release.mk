Here are some things we released:

* `sudo yum install --assumeyes packagename`. A lot of users asked us to install packages specific to their needs. Starting now you can install whatever packages you need.
* `sudo gem install gemname`. You can also install some global gems if you want to. Want a newer bundler, upgrade/downgrade rubygems, go right ahead.
* Parallel bundle install - We've upgraded bundler to v1.5.2. Snap will now perform bundle installs in parallel. All existing users get this for free - no need to edit your build plan.
