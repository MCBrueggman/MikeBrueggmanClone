Exercise Working with Remotes
=============================

All throughout the exercise, you should repeatedly check the merge history
using the --graph option of the Git log command (you may find the --oneline 
option to be useful as well.)


## Part 1 - Adding a remote repository

1. In your GitHub account, create a new repository. Copy the URL for it
	and add it to your repo from the last exercise as a remote repository 
    called origin.

	Push the local main branch to the remote repository.


## Part 2 - Merge commits - Fast-Forward

2. Merge the help-feature branch into the main branch. It should use 
	a fast-forward merge. You can check whether it did so using the --graph
	option of the Git log command.

	Once you are satisfied it was successful, delete the feature branch.

	Push the changes to the main branch to the remote repository.


## Part 3 - Merge commits - Merge Commit

3. Set up a merge commit by creating a new branch called login-feature,
	adding or editing a file or two and committing the changes.

	Switch back to the main branch, add or edit a different file than you
	modified on the feature branch, then commit the changes.

	Finally, merge the feature branch back into main. It should use a 
	merge commit this time, since there were changes on both branches.
	Verify this using the --graph option of the Git log command.

	Once you are satisfied it was successful, delete the feature branch.

	Push the changes to the main branch to the remote repository.


## Part 4 - Merge commits - Rebasing

4. Set up another merge commit by creating a new branch called account-feature,
	adding or editing a file or two and committing the changes.

	Switch back to the main branch, add or edit a different file than you
	modified on the feature branch, then commit the changes.

	Attempt to merge the changes using the fast-forward-only option, and note
	the failure message.

	Switch back to the feature branch and rebase it using the current state
	of the main branch.

	Finally, switch back to the main branch and attempt the fast-forward-only
	merge. This time it should succeed.

	Once you are satisfied it was successful, delete the feature branch.

	Push the changes to the main branch to the remote repository.


