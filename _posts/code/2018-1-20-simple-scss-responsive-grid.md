---
layout: post
title:  "Simple Responsive SCSS Grid"
date:   2018-1-20 06:00:00 -0600
categories: [scss, css, front-end]
blog: code
tag: code
---

CSS grids are great, but a whole framework (Bootstrap, Foundation, etc) for a simple grid is unnecessary -- many mbs and thousands of lines of code for a little organization and responsiveness?!

This is a simple grid I've been using in a few lines of scss:

{% highlight scss %}
// grid.scss
@mixin clearfix {
	&:before, &:after {
		clear: both;
		content: '';
		display: block;
	}
}

.container {
	margin: 0 auto;
	width: 90%;
	@include clearfix;
}

.row {
	display: block;
	@include clearfix;
}

@mixin columns($size) {
	box-sizing: border-box;
	float: left;
	padding: 0 10px;
	width: 100%;

	@media screen and (min-width: 700px) {
		width: 100% * ($size/12);
	}
}
{% endhighlight %}

And here is how it's used:

{% highlight html %}
<!-- page.html -->
<div class="container">
	<div class="row">
		<div class="className"></div>
		<div class="className"></div>
		<div class="className"></div>
	</div>
</div>
{% endhighlight %}

{% highlight scss %}
// stylesheet.scss (with grid imported)

.className {
	@include columns(4);
}
{% endhighlight %}

Done. Mobile-first, responsive columns. Above 700px (or whatever is specified) div.className becomes 3 columns and below it's one column.

A sidenote: keeping up with different device widths and pixel densities isn't sustainable. I've found it's fine to set one or two breakpoints where the structure of the page can dramatically change; meanwhile, the content is always responsive within those breakpoints. Everything is responsive, yet simple and device agnostic. More on this idea: [Stop Using Device Breakpoints][Stop Using Device Breakpoints].

It's trivial to set up multiple breakpoints:

{% highlight scss %}
$screen-md: 900px;
$screen-lg: 1200px;

.className {
	@include columns(6);
	@media screen and (min-width: $screen-md) { @include columns(4); }
	@media screen and (min-width: $screen-lg) { @include columns(3); }
}
{% endhighlight %}

Not only is this simple, it's also semantic! No need to bloat the html with column classes: `<div class="className col-xs-12 col-sm-6 col-md-3 col-lg-2"></div>`. Styling stays in the styling - what a concept! 

[Stop Using Device Breakpoints]: https://adamsilver.io/articles/stop-using-device-breakpoints/