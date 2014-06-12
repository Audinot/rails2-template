README
======

### Introduction

This is a sample app template for older versions of Ruby and Rails. It
includes:

    Ruby 1.8.7
    Rails 2.3.14
    Thin server
    PostgreSQL
    .gitignore file

This template is meant to be deployed on Heroku (hence postgres) and works
on "Chrubuntu" 12.04.

NOTE: From what I understand, the "About your application's environment"
tab on the default ("Welcome aboard") page does NOT work on Heroku. This
produces a routing error because the GET path is deprecated on Heroku.
Everything else works just fine; in fact you can check the environment
tab from your own computer.

bundle exec thin start

Thin server should tell you it's listening on 0.0.0.0:3000, so you can
check it out in your browser.

### Download

git clone https://github.com/Audinot/rails2-template.git

### Guide

Set it up yourself with this guide! (Using Rails 2.3.14 and Ruby 1.8.7)
I'm using "Chrubuntu" (Linux Ubuntu on a Chromebook) 12.04, so this guide
will have a very Linux-ish flavour. These commands should work fine in a
Mac OSX terminal. You might want to check the Windows equivalent first
before running these commands in the Windows command prompt!

1. Before starting your app, set up your databases.

```
sudo su postgres -c psql

create database appname_development;
create database appname_production;
create database appname_test;
```

2. Let's make a new role (user) for this database.

```
create role appuser with createdb login password 'password';
```
Make sure you use your appname and put your password between the quotes!

3. Give the new role access to the newly created databases.

```
grant all privileges on database appname_development to appuser;
grant all privileges on database appname_production to appuser;
grant all privileges on database appname_test to appuser;
```

4. Log out of postgres with `\q`.

5. Start your new app! You will need a text editor. I'm using vim, but you
can use nano, gedit, textmate, notepad, etc.

```
cd whatever/folder
rails appname --database=postgresql
cd appname/config
vim database.yml
```

6. In your database.yml file, add the username and password you created
earlier to the information. (There should be a blank space waiting for
the password, and the username might already be filled in for you. Make
sure it's correct!)

7. You'll want a Ruby gem called 'Bundler' now. Heroku absolutely requires
this... Plus it makes your life easier. Install it first:

```
sudo gem install bundler
```
Once installed, you need to generate a Gemfile. This is a list of the
Ruby gems your project requires. Run `bundle init` and Bundler will
create a file for you. Open it with your favourite editor and fill it in
with the basic gems Heroku needs to run your project:
```
# Basic Gemfile to run Rails2 project in Heroku
source "https://rubygems.org"

# Don't forget to list your Rails version!
gem "rails", "2.3.14"

# Don't use the default WEBrick server Rails gives you. Try Thin instead.
gem "thin"

# The rdoc gems are specified because Rails2 uses a depracated rdoc gem
# by default.
gem "rdoc"
gem "rdoc-data"

# Heroku needs the activerecord gem to work with your database.
gem "activerecord-postgresql-adapter"

ruby "1.8.7"
```
Save this Gemfile and install all the gems listed with 'bundle install'.

8. Open the Rakefile in your favourite editor and look at the requirements.
If you're using the same Ruby/Rails version as I am, you'll probably see 
this line: `require rake/rdoctask`. Change it to `require 'rdoc/task' and 
save it; Heroku can't use the old deprecated rdoctask module.

9. Now that your Rakefile is up to date, you can use `rake` commands to 
start up your database.
```
rake db:migrate
rake db:setup
```
NOTE: if you get a peer authentification error, your postgres config file 
is a bit off. You can fix it by switching to look for an md5 password.
```
sudo vim /etc/postgresql/9.1/main/pg_hba.conf
```
Change anything that says `peer` to `md5` instead, then run the `rake` 
commands again, and everything will be fine.

10. You're going to make a Procfile, which is a file Heroku uses to 
determine what services to start whenever someone makes an HTTP request 
(looks at your app). In this case, all we need Heroku to do is start the 
Thin server we installed earlier. I use `vim Procfile` and just add this:
```
web: bundle exec thin start -p $PORT -e production
```

11. Create a new git repository to store your app. If you're a git master, 
you can skip the instructions. Heroku uses git to get your app running 
online, so if you've never used git, you'll want to follow this quick
tutorial here.

First, sign up on [Github](https://github.com) for a free account. Then 
create a new repository. It's a good idea to name this 'repo' after your 
Rails app so you can find it easily.

Git, and github, will store EVERY file in your app online, even the files 
you don't need hosted! To keep your private files, well, *private,* create 
a new `.gitignore` file. Don't forget the dot! I got mine from [Github's 
own repo,](https://github.com/github/gitignore/blob/master/Rails.gitignore 
"Github's Rails .gitignore").

 I got mine from [Github's 
own repo,](https://github.com/github/gitignore/blob/master/Rails.gitignore 
"Github's Rails .gitignore") and copied it into my app's root folder. I 
also added `/rdoc/` at the beginning of the file.

If you haven't downloaded Git, it's as simple as `sudo apt-get install git`
in the command line. Or download the installer from github.com and follow 
the wizard.

Now you can start using git in your project. Let's start up (initialize) 
git, add all your files to it, and save (commit) them to git's memory.
```
git init
git add -A
git commit -m "Initial commit"
```
To see if it worked, you can use `git log` and look for the "Initial 
commit" message. If you don't see it, just try the above commands again.

Now we can get the code online in the git repo created earlier.
```
git remote add origin https;//github.com/Username/repo-name.git
git push -u origin master
```

12. Last stretch! Deploy your new project to Heroku. This step will make a 
new Heroku repo, 'push' your code online, and get Heroku's database synced.
```
heroku create
git push heroku master
heroku run db:migrate
heroku run db:setup
```
Done! To see your sweet masterpiece running online, just use `heroku open`.

NOTE: Heroku keeps asking you to specify an app? This can happen if you 
have multiple Heroku repos. Use `heroku open --app app-name-12345 (the 
name of the repo you got after `heroku create`).

Thank you!
----------

It took me a long time to find all the information I needed to get Rails2 
running on Heroku. While there are plenty of templates and  guides for 
various versions of Ruby + Rails + Heroku, I found no guide that collected 
all of the steps in one place for beginners. Most guides simply suggest 
upgrading to newer versions of Rails, which I recommend for the most part. 
However, in my case, it simply wasn't possible! My ChruBuntu netbook is 
quite limited, but I still wanted to run my Ruby apps.

I hope this guide helps others out there with outdated laptops or limited 
netbooks. Remember to tell your laptop you love it, even for all its 
quirks and bugs.
