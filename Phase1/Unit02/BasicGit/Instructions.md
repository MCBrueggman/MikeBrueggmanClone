Exercise Basic Git Commands
===========================

## Part 1. Creating and configuring a repository

1. Use the bash command line to initialize a new repository inside 
	a directory named "GitExercise".

2. Create a .gitignore file that prevents Git from including
	this instructions file. Add any other exclusions you wish.


## Part 2. Adding some content

3. Add a ReadMe.md document to the repository and enter some content
	into the file. Check the Git status.
	
4. Stage both the ReadMe and .gitignore files and check the Git 
	status again. Commit the changes using an appropriate message 
	and check the Git status one last time.


## Part 3. Working with branches

5. Create and checkout a new branch called "help-feature".

6. Create a directory called "help" and inside that directory, create
	a file called Instructions.txt. Add some simple text content to
	the file.

	Stage and commit the changes, using "adds initial help docs" 
	for the commit message.

7. Checkout the main branch and observe what happens with the
	help directory. Checkout the help-feature branch once again
	and notice the return of the help directory.


## Part 4. Reverting and resetting

8. Add some additional content to the Instructions.txt file
	and stage the changes. Add some more content but do not stage
	these changes.

	View the Git status. Commit the staged changes using an appropriate
	commit message and then view the Git status once more. Only the
	first set of changes should have been committed. The second set
	should still be in the working tree, unstaged.

9. Try to apply an offsetting commit to revert the last commit on the branch
	referenced by HEAD. It should fail because you have some uncommitted changes.
	Stash the changes and then try the revert again. Use Git log to verify the 
	commit and also verify that the changes were made to the content of the file 
	in the working tree. Apply your stashed changes - you will get a merge conflict.
	You can ignore the conflict until the next step.

10. To clean up the merge commit mess, you decide to roll back the application
	to an earlier state. Remove the last couple of commits by using a hard reset
	to the commit with the message "adds initial help docs". You may need
	to use the Git log command to find the desired commit id.
