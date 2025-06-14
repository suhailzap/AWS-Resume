

Phase 1: Static Website with S3 and CloudFront

Our goal here is to host your HTML/CSS/JS files in a private S3 bucket and make them accessible to the world only through a secure and fast CloudFront distribution.

Step 1: Prepare Your Resume Files

Before touching AWS, make sure you have at least a basic index.html file ready. You can use the full resume you've designed, or just a placeholder to test the infrastructure.

Create a folder on your computer for the project, and inside it, create a simple index.html file.

index.html (Example):

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Name - Resume</title>
    <style>
        body { font-family: sans-serif; line-height: 1.6; color: #333; max-width: 800px; margin: 40px auto; padding: 20px; }
        h1 { color: #1a1a1a; }
    </style>
</head>
<body>
    <h1>My Awesome Resume</h1>
    <p>Infrastructure is live! Hosted on S3 and delivered securely via CloudFront.</p>
</body>
</html>

Step 2: Create the S3 Bucket

This bucket will store your website files. We will keep it private.

Navigate to the AWS Management Console and go to the S3 service.

Click Create bucket.

Bucket name: Choose a globally unique name. A good convention is yourname-resume-website.

AWS Region: Select a region close to you (e.g., us-east-1 or eu-west-2).

Block Public Access settings for this bucket: This is critical. Keep all boxes checked. We want to block all public access by default. The only service that will be allowed to access it is CloudFront.

Leave the rest of the settings as default and click Create bucket.

Step 3: Upload Your Files to S3

Click on the name of the bucket you just created.

Click the Upload button.

Click Add files, select your index.html (and any other CSS, JS, or image files/folders), and click Upload.

Your files are now in S3, but they are completely private and inaccessible from the internet. This is exactly what we want.

Step 4: Create the CloudFront Distribution

CloudFront will be the public-facing entry point to your website. It will fetch content from your private S3 bucket and serve it to visitors.

In the AWS Console, navigate to the CloudFront service.

Click Create a CloudFront distribution.

Origin domain: Click the field and select your S3 bucket from the dropdown list. It will look like yourname-resume-website.s3.us-east-1.amazonaws.com.

Origin access: This is the key security step.

Select Origin access control settings (recommended).

Click Create control setting. A new setting will be created with a default name. Keep the defaults and click Create.

You will now see a message saying "You must update the S3 bucket policy." CloudFront provides the exact policy you need! Click the Copy policy button. We will use this in the next step.

Viewer protocol policy: Select Redirect HTTP to HTTPS. This enforces a secure connection.

Default root object: This is important. Enter index.html. This tells CloudFront to serve the index.html file when someone visits the root URL (e.g., https://d1234abcd.cloudfront.net/).

Leave all other settings as default for now and click Create distribution.

Note: The distribution will take 5-10 minutes to deploy. Its status will change from "Deploying" to the date/time it was last modified.

Step 5: Update the S3 Bucket Policy

Now we'll use the policy CloudFront generated to grant it read-only access to our private S3 bucket.

Navigate back to the S3 service.

Click on your bucket, then go to the Permissions tab.

Scroll down to Bucket policy and click Edit.

Paste the policy you copied from the CloudFront settings page into the text box. It will look something like this:

{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::yourname-resume-website/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::YOUR_AWS_ACCOUNT_ID:distribution/YOUR_CLOUDFRONT_DISTRIBUTION_ID"
                }
            }
        }
    ]
}
IGNORE_WHEN_COPYING_START
content_copy
download
Use code with caution.
Json
IGNORE_WHEN_COPYING_END

Click Save changes.

Your S3 bucket is now locked down, allowing access only from your specific CloudFront distribution.

Step 6: Test Your Website

Go back to the CloudFront console.

Select your distribution.

In the Details tab, find the Distribution domain name (e.g., d123456abcdef.cloudfront.net).

Copy this domain name and paste it into your web browser.

You should see your index.html page load successfully over HTTPS!

If you try to access the S3 object URL directly, you will get an "Access Denied" error, which proves your security configuration is working correctly.

Congratulations!

You have successfully implemented the core infrastructure of your project plan. You now have:

A static website hosted in a secure, private S3 bucket.

A global Content Delivery Network (CloudFront) delivering your content quickly and securely.

HTTPS enforced for all visitor traffic.

Next Steps (from your plan):

When you're ready, you can move on to the next logical steps:

Register a Domain with Route 53: Get that professional resume.yourname.com domain.

Request an SSL Certificate with ACM: Get a free SSL certificate for your custom domain.

Configure DNS to CloudFront: Point your custom domain to your CloudFront distribution using Route 53.

