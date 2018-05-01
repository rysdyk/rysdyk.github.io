---
layout: post
title: "Joins vs Includes in Rails"
date: 2018-04-22 05:00:00 -0500
categories: [rails, ruby, sql]
blog: code
tag: code
---

Many Rails tutorials and demo apps do not contain databases with hundreds or thousands of records. Therefore it can be hard to appreciate what an N+1 problem is and how to handle it.

What is a N+1 issue:

In a rails app, if you're loading 10 records on a page, making one query per record may not be a big deal. However if you're loading 1,000 records then 1,000 queries, even a fraction of a second each, can take several minutes.

Here is a code example how you might accidentally create an N+1

{% highlight ruby %}
# team.rb
  class Team < ApplicationRecord
    has_many :players
  end

# player.rb
  class Player < ApplicationRecord
    belongs_to :team
  end

# teams_controller.rb
  class TeamsContoller < ApplicationController
    def show
      @team = Team.find(params[:id])
    end
  end

# team/show.html.erb
  <% @team.players.each do |player| %>
    <span><%= player.name %>, <%= player.position %>, <%= player.number %></span>
  <% end %>

{% endhighlight %}

If a team has 53 players, team/show.html.erb will generate 53 queries for each player. Even 53 queries will run noticably slow. With even more records, it only gets worse.

Refactor:

{% highlight ruby %}
# teams_controller.rb
  def show
    @team = Team.includes(:players).find(params[:id])
  end
{% endhighlight %}

Instead of 53 separate queries, this does one (maybe 2???) "bigger" queries up front which gather all the player info with team from the database. Then we we loop through the all the players, we no longer need to ask the database for information. Much faster.

Rails 'joins' and 'includes' are the simplest way to avoid N+1 issues.

Joins and Includes can be confusion because they look very similar and sometimes they behave very similarly. Therefore, in order to understand includes vs joins, its helpful to know some SQL concepts:

Includes = Left Outer Join
Joins = Inner Join

Includes tries to grab all the information. All the associations. This is useful for situation where you want information from the associations (like the teams-players example above.)

Joins doesn't load all the associations.

In SQL, a venn diagram is useful to understand inner vs outer joins.



Rails 3 vs 4

Includes changed a bit in Rails 3 vs Rails 4.
