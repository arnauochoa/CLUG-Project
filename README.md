Project for the C-programming subject.
Genetic algorithm for image segmentation.


How to use git version control:

1- Update branch develop to see if the partner has updated:

	--> git fetch origin (if there are updates, the names of the updated branch will appear, otherwise, the next command is not needed).
	--> git rebase -pk origin/develop
	Now the develop branch is updated with the partner

2- Do work:
  New branch from develop (first check if develop is updated with 1.):

	--> git checkout -b feature/(branchName)

  Work on that branch and commit every new functionality that is added

	--> git add .
	--> git commit -m "functionality added"

  When the work corresponding to that branch is done, merge it into develop (3.)

3- Merge work into develop
  Before merging, always check for updates (see 1.)
  If there are new changes in develop, add those changes to the current branch, otherwise the next command is not necessary:

		-->git rebase -pk develop

	Once updated:

	--> git checkout develop
	--> git merge --no-ff feature/(branchName)
  When the merge is done, some editor will be opened so the user can add a merge message. There's no need to change that, save and quit (e.g. for vim: wq + ENTER)
  Once the work is added to the local version of develop, it can be uploaded.

4- Upload develop

	--> git push origin develop

5-Basic commands

	--> git add . (add work to do a commit)
	--> git commit -m "commit message" (commit in the current branch, do as many as you want)
	--> git push origin feature/(branchName) (to upload a branch to the server, e.g. work isn't finished).
	--> git status (information of the current branch and the modified files)
	--> git branch -l (list of current branches)
	--> git branch -d feature/(branchName) (delete local branch)
	--> git push origin --delete feature/(branchName) (delete remote branch)
