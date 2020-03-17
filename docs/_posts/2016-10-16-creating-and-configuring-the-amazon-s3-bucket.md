---
layout: page
title: Creating and configuring the Amazon S3 bucket
---

## Open the S3 management console

![][1]

[1]: images/aws-bucket-creation/open-the-s3-management-console.png

## Create a new S3 bucket with a recognizable name

![][2]

[2]: images/aws-bucket-creation/create-a-new-s3-bucket-with-a-recognizable-name.png

## Open the permission settings of the newly created bucket and create a new bucket policy

![][3]

[3]: images/aws-bucket-creation/open-the-permission-settings-of-the-newly-created-bucket-and-create-a-new-bucket-policy.png

## The bucket policy explained

A bucket policy contains a number of statements which allow or disallow certain actions. For this configuration, we've used two statements. The first statement grants permission to the created user to put objects into the bucket, and the second statements allows everyone (i.e. anonymous access) to retrieve an object from the bucket if they know the URL.

1. This needs to be replaced with the ARN of the user. If you don't know what this is, check out the user creation guide
1. Here we grant the permissions to write objects
1. And we limit that permission to the relevant bucket
1. This grants the permissions to everyone
1. And the relevant permissions is to retrieve an object

![][4]

[4]: images/aws-bucket-creation/the-bucket-policy-explained.png

```
{
    "Version": "2012-10-17",
    "Id": "Policy1476717073556",
    "Statement": [
        {
            "Sid": "Stmt1476717071703",
            "Effect": "Allow",
            "Principal": {
                "AWS": "<ARN of the user you created>"
            },
            "Action": [
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::<name of the bucket you created>/*"
        },
        {
            "Sid": "Stmt1476717071704",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::<name of the bucket you created>/*"
        }
    ]
}
```

## Add the bucket policy

Let's add the policy explained above. If you're curious you can also use the policy generator to create one yourself.

![][5]

[5]: images/aws-bucket-creation/add-the-bucket-policy.png

## Keep note of the identifier for the region in which the bucket was created

![][6]

[6]: images/aws-bucket-creation/keep-note-of-the-identifier-for-the-region-in-which-the-bucket-was-created.png

## This concludes the setup on the Amazon AWS side
