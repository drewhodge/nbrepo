# git: Common Git tasks

[]: # (This is a comment)
[]: # "And this is a comment"
[]: # 'Also this is a comment'
[//]: # (Yet another comment)
[comment]: # (Still another comment)
<!-- comment: 2 leading dashes -->
<!--- comment: 3 leading dashes -->


## Simple Git workflow

  From: http://jezenthomas.com/my-uncomplicated-git-workflow/

  I don't find it valuable to spend brain cycles context switching between
  thinking about what my production code should look like and trying to rememb     - Reviewed email.
     - Uploaded WR DTDs for Volodymyr and confirmed meeting for Thursday.
     - Deleted unneeded KLAUS docsets created by VxW7 writers.
     - KLIB-3276/3275--began work on KL nodes.
     - Support for the VxW 7 SR0600 writers--KLAUS docsets and imports.
     - Began creating new docset for VxW 7 SR0600 APIs.
     - Called-in to Zoomin weekly status meeting.
     - Called-in ot meeting with Helen and Gabriel re applying taxonomy and
       possible freeze dates.er
  which Git command and with wfrohich flags is appropriate in any given context.
  For this reason, my Git workflow is about as simple as I can make it.

  My workflow exists exclusively in the terminal, and leans heavily on Git
  aliases and a Ruby gem (don't laugh) called git-smart. The gem seems not to be
  actively maintained any more, but it still works regardless. I don't use
  git-flow, and I advise against using it because it is needlessly complex.

### Reasons for only using Git in the terminal:

   - I want to protect my arms, wrists, hands, and fingers by not
     having to shuffle a cursor around the screen with a mouse o
     trackpad. Typing only.
   - My terminal is easy on the eyes with its dark theme so I suffer
     from fewer headaches when working.
   - I am unable to fathom how anyone would find a GUI application
     like SourceTree less intimidating than Git's command-line
     interface.

### Pulling changes 

   A *typical working* session for me begins with
   pulling the latest changes from the remote repository. I use the
   =git smart-pull= command provided by the =git-smart gem= for this, and
   I have the command aliased in my global =.gitconfig= so I only need
   to type =git sp=. The =git-smart= gem will first run =git fetch origin=,
   and then figure out the best way to pull changes from remote,
   rebasing if necessary. It's also nice that it tells you which
   commands it's running and when, so you can learn more about Git
   while it makes decisions for you.

### Reviewing changes 

   After I have spent time working on a task, I will check the status
   of the working directory with the standard =git status= command,
   which I have aliased to =git st=. I use the standard output because I
   can scan it more quickly with my eyes. In most cases, I already
   know what the status of the working directory will be before
   checking the status, but I run the command anyway as a simple
   sanity check. I am usually able to scan the status in a fraction of
   a second.

   Assuming checking the status didn't give me any surprises, I
   inspect the work I did in greater detail with =git diff=. I don't
   alias this command, because I find it comfortable enough to type at
   speed. I do make an effort to keep my commits small, so I am
   usually able to scan the diff in about a second.

### Staging changes 

   Now I am ready to begin staging my changes. In the cases when I
   want to stage everything — and this is the most common case — I use
   the =git add --all= command, which I have aliased to =git aa=. If
   on the other hand I feel my work should be split into multiple
   commits, I'll stage hunks of changes with =git add -p=. I use this
   command often, but not often enough to justify creating an alias
   for it. Using the =-p= flag when staging puts you in an interactive
   patch mode that asks you which hunks to stage. Answer =y= for yes,
   =n= for no, and =q= to quit patching. Sometimes the hunk it presents
   to you contains more code than you wish to stage, and at that point
   you can answer =s= for split.

   Sometimes I feel the need to check once again which changes are
   staged, but git diff alone won't work here. For staged changes, you
   need to run =git diff --cached=, which I have aliased to =git dc=.

### Committing changes 

   When I'm ready to commit my changes, I run =git commit=, which I have
   aliased to git ci. I almost never use the =-m= flag when
   committing. Instead, Git opens up my text editor so I can
   comfortably write a proper commit message there.

   If I forget to add some changes to the commit and/or I want to
   change the commit message, I use =git ci --amend=. If I want to undo
   the commit entirely, I use =git reset HEAD~1=.

   If there are no other commits to make, I will run =git sp= again to
   ensure I have the latest changes locally, and then I run git push
   to share my work with my team.

### Working with branches 

   I'm generally not a fan of the pull-request model of collaboration,
   and I don't like the idea that a team of developers can't trust one
   another enough to commit directly to master. The pull-request model
   usually involves a synchronous code-review step, where the PR can
   not be merged into master until it has been approved by other
   members of the team. It's unfortunate that we have tools that cater
   to an asynchronous workflow, and yet use them synchronously
   anyway. The PR model can be a necessary evil however if a project
   doesn't have any tests.

   When I do need to use branches, I make liberal use of =git checkout=,
   which I have aliased to =git co=. If I want to create a new branch, I
   use =git checkout -b <branchname>=. If I want to switch back to the
   previous branch I was on (I sometimes shuffle quickly between a
   feature branch and master), I use git co -. The checkout command is
   also handy for clearing away unstaged changes that I don't care for
   anymore, with =git checkout -- .=.

   If I need to merge from a feature branch back into master, I use
   the =git smart-merge= command from =git-smart=. I don't use this
   often enough to bother creating an alias. This is another one of
   those commands that decides the best strategy for merging given
   some context, and it's always just done the right thing for me.

### The view from 10,000 feet 

   From time to time, I like to briefly check how the project has been
   progressing, and again git-smart pulls through for us here
   providing the =git smart-log= command, which I have aliased to git
   sl.

### Getting distracted 

   Sometimes I'll be half-way through working on a task and I will
   have to context-switch to another task. I don't want to commit my
   work in an unfinished state, but I do want a clean working
   directory. In this case, I use =git stash=. When I want to retrieve
   my unfinished work, I use =git stash apply=, followed by =git stash
   drop= assuming nothing went wrong when applying the latest
   stash. This is safer than using =git stash pop= directly.

### Problems in the wild 

   There is a caveat to using =git-smart=, and that is it doesn't play
   nicely with Git submodules. What happens is, a submodule that is
   yet to be updated will make the working directory appear dirty,
   when in reality it isn't. When git-smart sees a dirty working
   directory, it'll stash your changes before pulling, and then pop
   them after pulling, which will pop the wrong stash which could
   potentially cause problems. In practice, this shouldn't be an issue
   because submodules should be avoided anyway.

### Conclusion 

   Learning to harness the power of Git properly is a key factor in
   communicating with colleagues effectively, and it also makes
   projects far easier to maintain.

   Uninstall SourceTree. Abandon git-flow.


## Deleting

### Delete a file under version control

   git rm file1.txt
   git commit -m "remove file1.txt"

### Delete a branch

   *List local branches only*
   git branch

   *Local branch*
   git branch -d the_local_branch

   *Remote branch*
   git push origin --delete remote_branch_name


## Branching

** Create a new branch

   git checkout -b branch-name

** Fetch and track a remote branch

git checkout --track origin/daves_branch


## Adding and committing selectively

** Adding only modified files

   git add -u

** Adding untracked files to .gitignore

   git ls-files --others --exclude-standard >> .gitignore


## Diffing

** Diff two branches for changed files

   git diff --name-status branch-one..branch-two

** Diff specific file on two branches

   git diff mybranch master -- myfile.txt

*** Diff  local and remote branches

    git fetch origin
    git diff --name-only master origin/master 


## Pushing

** New local branch to origin

   $ git checkout -b feature_branch_name
   ... edit files, add and commit ...
   $ git push -u origin feature_branch_name


## Reverting

** Revert last 'add' operation

   git reset <file>

** Revert a merge

   git reset --hard <commit_before_merge>

or

   git reset --hard HEAD@{1}

** Revert last commit

   git reset --hard HEAD^

** Revert to a specific commit

[This will destroy any local modifications.]#
# Don't do it if you have uncommitted work you want to keep.
git reset --hard 0d1d7fc32

# Might need to force the push to otigin after doing this.
git push --force origin production


* Merging

** Merging into a master branch

git checkout ba
# Create a 'merge' branch
git checkout -b ba-merge
# Merge the master (production) branch into the new merge-branch.
git merge master
# Review new code, fix conflicts; then commit changes.
git commit
# Checkout the original branch.
git checkout ba
# Merge the updated master (production) branch.
git merge ba-merge
# Delete the merge-branch
git branch -d ba-merge
# Merge the master (production) branch into ba.
git merge master
# Merge ba into the master (production) branch.
git checkout ba
git merge master

Where ba is the feature/fix branch.

** Editing collision

   Most common type of merge conflict--occurs when the same content has been
   changes in a file on both branches.

   Git writes a special block into the file that contains the content of
   both changes--the conflict area.  The conflicting blocs are divided by
   ~=======~.

   #+BEGIN_EXAMPLE
   <<<<<<< HEAD
   change in one branch
   =======
   change in the other branch
   >>>>>>> branch-name
   #+END_EXAMPLE

   Use a text editor to resolve the conflict.

   1. Get information about the conflict -- run ~git status~
   2. Edit the file in a text editor to resolve the conflict.
   3. Add the corrected file to the staged area -- run ~git add file-name~

** Removed file

   This conflict occurs when an edited file is missing from one of the
   branches being merged.
   
   Resolve this conflict in either of two ways:

   1. Keep the new changes.
   
   #+BEGIN_EXAMPLE
   git add file-name
   git commit -m "Keeping changes."
   #+END_EXAMPLE

   2. Remove the file--that is, leave the file deleted.

   #+BEGIN_EXAMPLE
   git rm file-name
   git commit -m "Removing file-name."
   #+END_EXAMPLE

** Conflicts with binary files

=git checkout= accepts =--ours= or =--theirs= options for cases like this. So if
you have a merge conflict, and you know you just want the file from the branch
you are merging in, you can do:

=$ git checkout --theirs -- path/to/conflicted-file.txt=
to use that version of the file. 

Likewise, if you know you want your version (not the one being merged in) you can use

=$ git checkout --ours -- path/to/conflicted-file.txt=


* Stashing

** Stash local changes

   Useful if the working branch has changes you want to keep, but don't want
   to commit.

   git stash

** Show stash list

   git stash list

   $ git stash list
   stash@{0}: WIP on master: 049d078 added the index file
   stash@{1}: WIP on master: c264051 Revert "added file_size"
   stash@{2}: WIP on master: 21d80a5 added number to log

** Recover stash

   git stash apply stash@{1}


* Determine repo URL

  git remote show origin


* Git flow command line arguments 

https://github.com/nvie/gitflow/wiki/Command-Line-Arguments


** Example usage

  From: http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/

  #+begin_example

  $ git flow hotfix start assets
  Switched to a new branch 'hotfix/assets'

  Summary of actions:
  - A new branch 'hotfix/assets' was created, based on 'master'
  - You are now on branch 'hotfix/assets'

  Follow-up actions:
  - Bump the version number now!
  - Start committing your hot fixes
  - When done, run:

       git flow hotfix finish 'assets'


  $ git flow hotfix finish assets
  Switched to branch 'master'
  Merge made by the 'recursive' strategy.
   assets.txt | 1 +
   1 file changed, 1 insertion(+)
   create mode 100644 assets.txt
  Switched to branch 'develop'
  Merge made by the 'recursive' strategy.
   assets.txt | 1 +
   1 file changed, 1 insertion(+)
   create mode 100644 assets.txt
  Deleted branch hotfix/assets (was 08edb94).

  Summary of actions:
  - Latest objects have been fetched from 'origin'
  - Hotfix branch has been merged into 'master'
  - The hotfix was tagged '0.1.1'
  - Hotfix branch has been back-merged into 'develop'
  - Hotfix branch 'hotfix/assets' has been deleted

  #+end_example


* Git tagging
** Lightweight tag
** Annotated tag

   *Create an annotated tag*
   $ git tag -a v1.4 -m "my version 1.4"

   $ git tag -a 2016-10-17-production-j75-587-788-805 -m "Released sprint 28."

   *List tags in this repo*
   $ git tag
   v0.1
   v1.3
   v1.4

** Git show

   *Show tag information*
   $ git show

   Shows the tagger information, the date the commit was tagged, and the
   annotation message before showing the commit information.


* Rename a local and remote branch in git

   If you have named a branch incorrectly /and/ pushed it to a remote
   repository follow these steps to rename the branch:

   1. Rename your local branch.

     If you are on the branch you want to rename:

         ~git branch -m new-name~

     If you are on a different branch:

         ~git branch -m old-name new-name~!

    2. Delete the old-name remote branch and push the new-name local branch.

         ~git push origin :old-name new-name~

    3. Reset the upstream branch for the new-name local branch.

         Switch to the branch and then:

         ~git push origin -u new-name~

* View /n/ most recent commits

  To see the 3 most recent commits:

      ~git log -n~
      
      where /n/ is the number of commits you want to see.
