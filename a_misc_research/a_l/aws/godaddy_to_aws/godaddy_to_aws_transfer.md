# **[Migrate GoDaddy Domain and DNS to AWS Route 53](https://www.virtuallyboring.com/migrate-godaddy-domain-and-dns-to-aws-route-53/)**

## references

- **[https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-transfer-to-route-53.html](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-transfer-to-route-53.html)**

## **[How to move a domain from Godaddy to AWS Route 53](https://stackoverflow.com/questions/12433420/how-to-move-a-domain-from-godaddy-to-aws-route-53)**

Here are the steps to migrate your internet domain name to AWS route 53 (DNS Manager).

Be careful where your mail server is hosted, either in the Godaddy mail service, Gmail (gsuite) or in your Cpanel server (VPS/Server). To empower your Domain DNS capabilities, you need to transfer the name servers, DNS records and domain name to AWS route53, thats why it's recommended to move to AWS Route 53. You can keep Godaddy to be owner of your yourdomain.com and manage your DNS by Route 53

STEPS:

1. Go to Godaddy DNS records and understand each of them and note them (Take a screenshot)

2. Go to AWS route 53, Crete a Public hosted Zone (Create your domain on AWS route 53). Here is a good tutorial about it:

<https://www.clickittech.com/aws/migrate-godaddy-to-aws-route53/>

Copy your Godaddy DNs records into your Public hosted zone previously created. Remember, each record needs to exist in the new aws zone.

Change your Name Servers to AWS Route 53. What does it means? In order to allow AWS route 53 to manage your domain, DNs records, etc. you need to change your actual Godadaddy Name server (NS) Records to AWS Records.

Go to Godaddy admin Panel and Login
Go to DNS Management
Under Name Servers Click on Change - > Custom - > Change Name Servers
You need to change from NSx.domaincontrol.com to the AWS Name servers.

More info: <https://www.clickittech.com/aws/migrate-godaddy-to-aws-route53/>

After 4-8 hours your Name Servers will be reflected and propagated around your country, world and networks.

Practically you are done with this.

Additionally, if you need to migrate your website or web app to AWS go to this tutorial, great explanation, see below:

<https://www.clickittech.com/aws-migration/transfer-domain-aws-migrate-move-website-aws/>
