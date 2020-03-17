---
layout: page
title: Migrating existing attachements to Amazon S3
---

Migrating attachements from an existing Redmine installation is a simple matter of uploading the files to the correct location in your [Amazon S3 bucket]({{ site.baseurl }}{% post_url 2016-10-16-creating-and-configuring-the-amazon-s3-bucket %}). To do this, I'd recommend to use the official AWS command-line tools:

* [AWS CLI installation guide](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)
* [AWS CLI configuration guide](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

### Important:

Note that you cannot use the same AWS user which you might have created based on [this guide]({{ site.baseurl }}{% post_url 2016-10-17-creating-an-aws-user %}), since file migration requires more privileges than operating the `amazon_s3` plugin.

This guide does not cover the creation of such a user, please refer to the AWS documentation. If you're lazy (like me), you could create credentials for your own AWS account, migrate the files and then delete said credentials again.



## File migration

Navigate to your Redmine root directory on the system you wish to migrate the files from. In the root directory there should be a folder named `files`. If that is not the case, you may have configured Redmine differently and should adapt the following commands accordingly. 

Make sure you've installed and configured the AWS CLI tools, and run:

    $ aws s3 sync files s3://<target-bucket-name>/<attachments_folder-config-option>

If you did not change the default value of the `attachments_folder` configuration option, the command should read 

    $ aws s3 sync files s3://<target-bucket-name>/attachments

After the process finishes, that's it. Thumbnails will be re-generated automatically by Redmine and do not need to be synchronized.



## Troubleshooting

> I'm getting an error that the signature version is not correct :(

Run `aws configure set default.s3.signature_version s3v4` and try again
