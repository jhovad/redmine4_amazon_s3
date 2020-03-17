---
layout: default
---

## Prerequisite: Setting up Amazon S3

The recommended setup for this plugin is to have a dedicated AWS user for the bucket where the Redmine data is going to be stored. How to create such a user is explained in [this guide]({{ site.baseurl }}{% post_url 2016-10-17-creating-an-aws-user %}). After creating a user, you should check out the [guide on how to create the S3 bucket]({{ site.baseurl }}{% post_url 2016-10-16-creating-and-configuring-the-amazon-s3-bucket %}).



## Important security note

**After files are uploaded they are made public to anyone who knows the URL.**



## Installation of the Redmine plugin

1. Change into your Redmine installation's root directory
2. Clone the plugin
  * `git clone https://github.com/x3ro/redmine_amazon_s3 plugins/amazon_s3`
3. Copy the default configuration into your Redmien setup
  * `cp plugins/amazon_s3/config/amazon_s3.example.yml config/amazon_s3.yml`
5. Update your dependencies
  * `bundle install --without development test`
6. Delete the `.git` directory of the plugin and commit it to your favorite version control system
  * `rm -Rf plugins/redmine_s3/.git`



## Configuration of the Redmine plugin

To perform this step, you should have the following information from Amazon AWS:

* Access key and secret of the user which has access to the target S3 bucket
* Name of the target bucket
* Region identifier where the bucket was created

Now open the `config/amazon_s3.yml` file you've previously copied and fill in the blanks. Each option is explained in the configuration file itself, or [here](https://github.com/x3ro/redmine_amazon_s3/blob/master/config/amazon_s3.example.yml).


## Options Overview

* After files are uploaded they are made public, unless private is set to true.
* Files can use private signed urls using the private option
* Private file urls can expire a set time after the links were generated using the expires option
* If you're using a Amazon S3 clone, then you can do the download relay by using the proxy option.




# Development

## Running tests

Run unit tests from the root of your redmine installation (the plugin must be installed and configured for this). 

    bin/rake amazon_s3:test

Note that, if you have the test environment configured in your `amazon_s3.yml` and run the test suite, you will incur a small amount of S3 charges.

<br>
<br>

# List of documentation articles

For completeness, here's a list of all documentation articles:

<div class="home">

  <ul class="post-list">
    {% for post in site.posts %}
      <li>
        <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>

        <h2>
          <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
        </h2>
      </li>
    {% endfor %}
  </ul>

  <p class="rss-subscribe">subscribe <a href="{{ "/feed.xml" | prepend: site.baseurl }}">via RSS</a></p>

</div>
