This [Redmine](http://www.redmine.org) 4 plugin stores file attachments on [Amazon S3](http://aws.amazon.com/s3) instead of the local filesystem.

!!! Actually, I don't like this solution, but it works for me and it was fast implementation ...

-> Much more I would appreciate if Redmine switch to Active Storage which is part of Rails and works like a charm for locals storage end even for cloud storages.

## Installation instructions

clone the plugin into plugins and name it "amazon_s3"

copy the default configuration into your Redmine setup  
```cp plugins/amazon_s3/config/amazon_s3.example.yml config/amazon_s3.yml```

update your dependencies  
```bundle```

delete the .git directory of the plugin and commit it to your favorite version control system  
```rm -Rf plugins/redmine_s3/.git```

## Attributions and license

This project is a fork of https://github.com/x3ro/redmine_amazon_s3 which, in turn, was forked from the [ka8725/redmine_s3](https://github.com/ka8725/redmine_s3) which, in turn, was forked from the [original gem](http://github.com/tigrish/redmine_s3).

See the `LICENSE` file.
