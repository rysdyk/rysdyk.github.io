---
layout: post
title:  "Bootstrap Grid by Example: How to use containers, rows, columns"
date:   2018-4-30 05:00:00 -0500
categories: [bootstrap, html, css]
blog: code
tag: code
---

There is a lot of poorly written bootstrap out there. Much of it revolves around the most fundamental aspect of boostrap: the grid.

This is a basic guide to the Bootstrap grid, mostly for Bootstrap v3, but also applicable to v4.

# The Grid
* there are three fundamental elements:
  * **containers**: container and container-fluid. Container will only expand to a max-width, while container-fluid will go to full width of screen. Container should never be nest inside other containers.
  * **rows**: A row is a column wrapper. Without columns, no need for a row.
  * **columns**: to divide content into 2 or more horizontal sections. Columns should typically be directly need inside a row. A single column doesn't need to be a column at all. Columns are mobile-first.

# Bootstrap grid examples:

## Example 1
{% highlight html %}
<!-- anti-pattern -->
<div class="container-fluid">
    <div class="row">
        <p>content!</p>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <p>more content!</p>
        </div>
    </div>
</div>

<!-- instead -->
<div class="container-fluid">
    <p>content!</p>
    <p>more content!</p>
</div>
{% endhighlight %}

## Example 2
{% highlight html %}
<!-- anti-pattern -->
<div class="container-fluid">
    <div class="col-sm-6">
        <div class="row">
            <p>content!</p>
        </div>
    </div>
    <div class="col-sm-6">
        <div class="row">
            <p>more content!</p>
        </div>
    </div>
</div>

<!-- instead -->
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-6">
            <p>content!</p>
        </div>
        <div class="col-sm-6">
            <p>more content!</p>
        </div>
    </div>
</div>
{% endhighlight %}

## Example 3
{% highlight html %}
<!-- anti-pattern -->
<body>
    <div class="col-sm-6">
        <p>content!</p>
    </div>
    <div class="col-sm-6">
        <p>more content!</p>
    </div>
</body>

<!-- instead -->
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6">
                <p>content!</p>
            </div>
            <div class="col-sm-6">
                <p>more content!</p>
            </div>
        </div>
    </div>
</body>
{% endhighlight %}

## Example 4
{% highlight html %}
<!-- anti-pattern -->
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            <p>content!</p>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            <p>more content!</p>
        </div>
    </div>
</div>

<!-- instead -->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
            <p>content!</p>
        </div>
        <div class="col-md-6">
            <p>more content!</p>
        </div>
    </div>
</div>
{% endhighlight %}

## Example 5
{% highlight html %}
<!-- anti-pattern -->
<div class="container-fluid">
    <div class="row">
        <div class="container">
            <div class="col-md-6">
                <div class="row">
                    <p>content!</p>
                </div>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            <p>more content!</p>
        </div>
    </div>
</div>

<!-- instead -->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
            <p>content!</p>
        </div>
        <div class="col-md-6">
            <p>more content!</p>
        </div>
    </div>
</div>
{% endhighlight %}

# Full-Width BG Example

Full-width backgrounds are popular in web-design. Here's a common situation where the header and footer and full width:

{% highlight html %}
<header class="full-width-bg">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-3">
                <p>Title!</p>
            </div>
            <div class="col-md-9">
                <p>more content!</p>
            </div>
        </div>
    </div>
</header>

<section class="full-width-bg">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">
                <p>content!</p>
            </div>
            <div class="col-md-6">
                <p>more content!</p>
            </div>
        </div>
    </div>
</section>

<section class="full-width-bg">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">
                <p>content!</p>
            </div>
            <div class="col-md-6">
                <p>more content!</p>
            </div>
        </div>
    </div>
</section>

<footer class="full-width-bg">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-4">
                <p>content!</p>
            </div>
            <div class="col-md-4">
                <p>more content!</p>
            </div>
            <div class="col-md-4">
                <p>more content!</p>
            </div>
        </div>
    </div>
</footer>
{% endhighlight %}
