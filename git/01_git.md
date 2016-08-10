!SLIDE small
# Version Control Workflow

* Safe and recoverable changesets
* Seamless collaboration with others
* Viewing complete change history of code
* Reverting problematic changes

Process:

1. Update local working directory
2. Edit code and make any changes required
3. Validate and style check code locally
4. Test code locally by applying test manifests
5. Update Puppet Master manifest repository
6. Test on development nodes in agent mode


!SLIDE smbullets
# Git - Distributed Version Control

* Free and open source distributed version control system
* Tiny footprint with lightning fast performance
* Cryptographic integrity of every bit of your project is ensured
* Makes a full clone of the entire repository
* Every user essentially has a full backup of the main repository
* Allows disconnected operation, even for commit and diff operations


!SLIDE small
# git status

    @@@Sh
    $ git status
    On branch master
    nothing to commit, working directory clean

    $ git status
    On branch master
    
    Initial commit

    Untracked files:
      (use "git add <file>..." to include in what will be committed)

           site.pp

    no changes added to commit (use "git add" and/or "git commit -a")

* Tells you the state of your working directory
* Run this command often, especially before commits


!SLIDE small
# git add

**Stages code to be committed**

    @@@Sh
    $ git add site.pp
    $ git status
    On branch master

    Initial commit

    Changes to be committed:
      (use "git reset HEAD <file>..." to unstage)

	new file:   site.pp

* This allows you to iteratively build up a commit
* You can add files or directories one at a time or many at once
* You choose which changes in your working directory to commit


!SLIDE small
# git commit

**Commits a changeset to your repository**

    @@@Sh
    $ git commit -m 'initial commit'
    [master (root-commit) d798484] initial commit
     1 files changed, 44 insertions(+), 0 deletions(-)
     create mode 100644 site.pp

* After all changed files have been staged with `git add`
* Takes a cryptographically-verified snapshot of your staged changes
* Saves a checkpoint into your repository
* Specify a commit message in one of two ways:
 * Opens your default editor by default
 * May be passed on the command-line with "-m"


!SLIDE small
# git push

**Pushes updates to a remote repository**

    @@@Sh
    $ git push origin master
    Counting objects: 3, done.
    Compressing objects: 100% (2/2), done.
    Writing objects: 100% (3/3), 932 bytes, done.
    Total 3 (delta 0), reused 0 (delta 0)
    remote: Updating Puppet Environment training
    remote: From /var/repositories/training
    remote:  * branch            master     -> FETCH_HEAD
    To training@master.training.vm:/var/repositories/training.git
      * [new branch]      master -> master       ...

* Your `origin` repository is located on the Master
* A `post-update` hook will update the environment working directory


!SLIDE small
# Git Development Workflow

1. `git pull origin master`
2. Edit, validate, test locally (`puppet apply <code.pp>`)
3. `git add <code.pp>`
4. `git commit`
5. `git push origin master`
6. Test on development infrastructure

~~~SECTION:handouts~~~

****

More about Git

More commands and topics you may want to research:

* git diff
* git log
* git show
* git blame
* git branch & git checkout

Resources you may be interested in:

* Free online Git book:
 * http://git-scm.com/book

* Learn Git in your browser:
 * http://try.github.com/

~~~ENDSECTION~~~


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Git

* Objective:
 * Manage your `apache` module with Git
* Steps:
 * Initialize a new Git repository
 * Clone the repository
 * Copy your `apache` module into the clone
 * Add the `apache` module
 * Commit your changes
 * Push your changes


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Git

## Objective:

****

* Manage your `apache` module with Git

## Steps:

****

* Initialize a new Git repository
* Clone the repository
* Copy your `apache` module into the clone
* Add the `apache` module
* Commit your changes
* Push your changes


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Git

****

    @@@Sh
    $ cd /home/training/
    $ git init --bare apache.git
    $ git clone /home/training/apache.git apache
    $ cp -Rf /home/training/puppet/modules/apache/* /home/training/apache/
    $ cd /home/training/apache/
    $ git add .
    $ git commit -m 'apache module'
    $ git push origin master
