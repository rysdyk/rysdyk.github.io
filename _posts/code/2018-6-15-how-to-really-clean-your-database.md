---
layout: post
title: "How to really clean your postgres database"
date: 2018-6-15 05:00:00 -0500
categories: [rails, ruby, postgres, sql]
blog: code
tag: code
---

When in the course of human events it becomes necessary for one people to dissolve the outdated, conflicted, erring tables and columns, a decent respect to the opinions of mankind requires cleaning that database!

It's not hard to mess up a database. Git doesn't always play nice with databases. One common situation is running a migration on one git branch, and then switching to another branch and running migrations... and surprise, there is stuff in the schema from that other branch!

While git takes care of changes to your code, it doesn't change your underlying database. It's important to actually read the git diff regarding the schema before committing. It is early to include database info from some other branch! Furthermore, if you're working on a shared code base, somebody else might check in a dirty schema and you might pull it and use before you realize what has happened.

This post is about how to (really) clean your Ruby on Rails database. Examples will be done with Rails 4, Mac terminal and Postgres. However, concepts here are general enough to work on other Rails versions and other OS and DB. It's going to start simple and get more powerful/dangerous with each step.

# Step 1: Fresh Schema

This is some Rails 101, but never edit the schema. The schema is to migrations as the gemfile.lock is to the gemfile. Never edit gemfile.lock. If necessary just delete it, update your gemfile if necessary, and run `bundle install`.

Likewise, never edit the schema. Just delete it and run `rake db:migrate` for what hopefully will be a fresh, clean copy of the schema.

This is especially relevant to merge conflicts. Never edit the schema, just delete it and migrate.

# Step 2: Setup

For example, if your tests are looking a little funny: various things are suddenly failing even though the code related to those things hasn't changed. Here is the simplest way to clean things up for testing.

`RAILS_ENV=test rake db:setup`
`RAILS_ENV=test rake test`

This is a combination of a three db commands:
  - db:create
  - db:schema:load
  - db:seed

This should produce a clean database for testing.

However if that doesn't work, perhaps something is caught in memory.

# Step 3: Reset

WARNING: this will lose your data! Make sure you have a current dump (aka backup) of your data before doing this.

In other words, don't do this unless you know what you're doing.


`rake db:reset`

This is a combination of:
  - db:drop
  - db:setup

Since setup combines 3 db commands, rake db:reset is really a combination of 4 commands.

At this point you may want to restore a backup of your data...


# Step 4: Raw SQL in Postgres

If the above doesn't seems to work, it might be tempting to edit old migration files. This is probably not a great idea.

Instead, it might be time to manually go into Postgres and figure out what's going on.

log into postgres from mac command line: `psql postgres`

From here, you'll want to see your databases: `\l`

(that's backslash lowercase-letter-l)

This will list out all your databases. You should see the rails database that is name in config/database.yml.

From here, connect to the problematic database: `\c database_name`
The c is short for connect.

Once in here, you can list out all of the tables to see what is acutally in there: `\dt`

This should be a list of tables that looks alot like the schema. However, it is possible that there are extra or missing tables. Running some 'raw' SQL can help fix this issue, without screwing with old migration files.

Let's say there are a bunch of wrong columns and we just want to completely clean it out: get rid of everything and start from scratch:

`DROP SCHEMA public CASCADE;`
`CREATE SCHEMA public;`

Now, a `\dt` should show there are no relations, meaning no columns. Good! We just obliberated the underlying database!

Now running `rake db:migrate` will install the columns created in the migration.

For example, during this migration, there may be errors complaining that a certain column does or doesn't exist. No problem, we can add and remove them directly in the database. Again no touching old migrations:

`ALTER TABLE table_name ADD COLUMN column_name type;` or,
`ALTER TABLE table_name DROP COLUMN column_name;`

For example, I was trying to migrate and I kept getting an error: function uuid_generate_v4() does not exist. After some googling around, I found my database needed an extension to handle UUID. Many suggested running a new migration to handle this. However, this error was happening in an old migration, so I didn't want to screw with that. Instead we can edit. After connecting to my table, I ran:

`CREATE EXTENSION "uuid-ossp" SCHEMA public;`

Boom, no more uuid_generate_v4() errors and no need to alter my old migrations or schema.

And finally, to exit out of postgres type:
`\q`
to quit

Finally, remember the semi-colon at the end of an SQL statement, it won't work without it.

