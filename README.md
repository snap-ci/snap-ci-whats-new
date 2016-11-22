snap-ci-whats-new
=================

What's new with Snap!

This repository contains the content that renders the what's new section at https://snap-ci.com/whats_new. For questions, comments or issues, [please contact the Snap.ci support team.](https://snap-ci.com/contact-us)

Generating Colorized Diffs
==========================

Download `package.diff` from the container builds and save them as `centos.diff` and `ubuntu.diff`

Run `rake diff[centos.diff]` and `rake diff[ubuntu.diff]` -- this writes files to the appropriate locations in the `assets/` folder

Add files to git as normal, commit, etc.
