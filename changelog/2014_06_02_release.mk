Pipeline parallelization!

* Pipelines are capable of running in parallel. For more information about this feature <a href="http://docs.snap-ci.com/speeding_up_builds/pipeline_parallelism/" target='_blank'>click here</a>
* This feature may require you setup your pipeline with setup tasks. Setup tasks should assume that the stage may run on a new build machine and should perform the setup accordingly. Use `bundle install ...`, `npm install ...` or `pip install ...` for setup tasks.

Stage/Deployment history

* Snap now gives you the ability to view the history of a particular stage. This will let you visualize when a particular stage ran and if there are any pending commits on that stage. <a href='https://snap-ci.com/snap-ci/docs.snap-ci.com/branch/master/stage_history/Production'>Click here</a> to see an example of stage history visualization.
