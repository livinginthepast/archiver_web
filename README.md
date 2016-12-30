Archiver Web
============

This Rails application is a content management system for image and video assets.

## Dependencies

* bower
```
brew install node
npm install -g bower
```

## Usage

```
bundle
bundle exec rake reset
```

## Authentication

Authentication uses Google OAUTH by default, authenticating with a google apps
domain associated with the currently accessed domain.

During development, when a developer may potentially be away from the internet,
they may manually log in using the developer OAUTH plugin, at https://litp.dev/auth/developer.

## AWS configuration

* Log into AWS console
* Go to S3 service
* Create two buckets, altered to be an original name
  * Check which region you pick for the bucket
  * `######-originals`
  * `######-thumbnails`
  * Consider adding a lifecycle rule to delete assets after a day or two
  * Add the following CORS rule to the originals bucket
  ```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <AllowedHeader>Authorization</AllowedHeader>
  </CORSRule>
  <CORSRule>
    <AllowedOrigin>https://litp.dev</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <AllowedMethod>POST</AllowedMethod>
    <AllowedMethod>PUT</AllowedMethod>
    <MaxAgeSeconds>360</MaxAgeSeconds>
    <ExposeHeader>Access-Control-Allow-Origin</ExposeHeader>
    <ExposeHeader>Accept-Ranges</ExposeHeader>
    <ExposeHeader>Content-Range</ExposeHeader>
    <ExposeHeader>Content-Encoding</ExposeHeader>
    <ExposeHeader>Content-Length</ExposeHeader>
    <AllowedHeader>*</AllowedHeader>
  </CORSRule>
</CORSConfiguration>
  ```
* Go to IAM
  * Create a new group. Give it an arbitrary name.
  * Do not add any policy for now
  * Open `Inline Policies`
  * Add the following, replacing the buckets with whatever names were created above
  ```
{
  "Version": "2012-10-17",
  "Statement": [
  {
    "Action": [
      "s3:ListBucket"
    ],
    "Effect": "Allow",
    "Resource": [
      "arn:aws:s3:::######-originals",
      "arn:aws:s3:::######-thumbnails"
    ]
  },
  {
    "Action": [
      "s3:GetObject",
    "s3:PutObject"
    ],
    "Effect": "Allow",
    "Resource": [
      "arn:aws:s3:::######-originals/*",
      "arn:aws:s3:::######-thumbnails/*"
    ]
  }
  ]
}
  ```
* Create a new user
  * Name is arbitrary
  * Access type is `Programmatic Access`
  * Add it to the group created above
* Add the access key id and secret access key to `.envrc`
```
export DEV_AWS_REGION=#######                       # ie us-west-1
export DEV_AWS_ORIGINAL_BUCKET=######-originals
export DEV_AWS_THUMBNAIL_BUCKET=######-thumbnails
export DEV_AWS_ACCESS_KEY_ID=XXXXXXXX
export DEV_AWS_SECRET_KEY=XXXXXXXXX
```

Note that if the file is not uploaded, there are multiple places this could have
failed. If you get a failure in the CORS preflight, then there are at least two
possibilities:
* utter failure - check the CORS permissions on the bucket
* 301 response - the bucket region does not match the region we are uploading to.

If there is a 403 response to the upload, then the permission on the IAM user are
incorrect.
