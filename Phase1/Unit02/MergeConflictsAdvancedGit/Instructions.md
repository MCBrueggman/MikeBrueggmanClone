Exercise Merge Conflicts and Advanced Git
==========

## Part 1 Handle merge conflicts

1. Set up a merge commit by creating a new branch called discussion-feature
	and edit an existing file.

	Switch back to the main branch, make changes to the same line(s) of the same
	file that you modified on the feature branch, then commit the changes.

	Attempt to merge the feature branch back into the main branch, note the
	merge conflict message.

	Edit the offending file, combining the changes and removing the merge conflict
	markers. Stage and commit the changes to complete the merge.

	Once you are satisfied it was successful, delete the feature branch.

	Push the changes to the main branch to the remote repository.


## Part 2 - Cherry-picking

2. Create a new branch called admin-panel based on the dev branch.
	This branch will represent your work developing a new feature.
	Add/modify some files and make a couple of commits to the new branch
	while doing so.

3. Create another new branch called user-profile based on the dev branch.
	This branch will represent some other developer's work. Add/modify some 
	files and make a couple of commits to this new branch, as well. 
	For one of the commits, add a file called emailer.txt and name the
	commit "adds emailer".

4. Now, your development on the admin-panel could use the emailer component
	created by the other developer. There's no need to wait until the 
	user-profile branch is completed. Switch back to your admin-panel branch
	and cherry-pick the emailer commit from the user-profile branch.



## Part 3 - Amending commits

5. Make a couple more file changes and add a commit to your admin-panel
	branch. Name this final commit "finishes admin panel." Then you realize
	that you need to make one more change to your feature. Make one more 
	change to a file and then stage that change and amend the lates commit
	with it.


## Part 4 - Squashing commits

6. Your branch is now finished, but before merging back in to the dev
	branch, you want to squash all the commits into one. Run interactive
	rebasing on your branch to squash your commits. Edit the commit
	message to be something simple about adding an admin panel to the
	application.

7. Verify that there is only one commit on your branch, and then merge
	it back into the dev branch.

