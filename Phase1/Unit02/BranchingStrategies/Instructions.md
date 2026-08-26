Exercise Branching Strategies
=============================

This exercise will practice using the Gitflow Workflow for a project.
Throughout this exercise use the Conventional Comments standards
for creating your commit messages.


## Part 1 - Setup long-running branches for Gitflow workflow

1. The main branch will be used as the production code, so create a new
	branch called "dev" from main.

	Optionally, you can remove the remote repo, if you wish to keep the Git
	log clean throughout this exercise.


## Part 2 - Develop a new feature on a feature branch

2. Create a new feature branch, called "feature-1", from the dev branch.
	Switch to the new feature branch and add or edit one or more files.

	Stage and commit the changes, using a message that indicates the feature
	is finished being created.


3. Merge the feature branch back into the dev branch and delete the feature branch.


## Part 3 - Create a release branch

4. The changes to dev are ready for deployment, so create a release branch
	from the dev branch, and switch to it.

	Assume that a bug is detected when the release branch goes through the QA
	process. Modify a file or two, stage and commit the changes (on the release
	branch).


## Part 4 - Deploy the release to production

5. Now that the bug is fixed, the release branch is ready to be deployed, so
	merge it into the main branch, but do not delete the release branch yet.


## Part 5 - Fix the bug in the dev branch

6. The bug was fixed on the release branch, but it still exists in dev, so 
	switch to the dev branch and merge in the release branch. Now the bug should
	be fixed everywhere.

	Delete the release branch - it is no longer needed.

