# New Relic Infrastructure + Packer on AWS Example

This script and Packer configuration file will create an Amazon Linux AMI image in the us-west-2 availability zone.

The AMI image will be configured with New Relic Infrastructure connected to an account (via the license key).

### Requirements

* New Relic Account + [License Key](https://docs.newrelic.com/docs/accounts-partnerships/accounts/account-setup/license-key)
* An AWS Account
* Packer by Hasicorp (download [here](https://www.packer.io/downloads.html)).

### Building the image

Building the image requires the New Relic License Key, AWS Key, and AWS Secret. They can be specified directly in the command line.

After cloning this repository, run the packer command in this directory with the correct variable values:

```sh
packer build -var 'aws_access_key=<access_key>' -var 'aws_secret_key=<secret_key>' -var 'newrelic_license_key=<license_key>' aws-linux-us-west-2.json
```

If this command succeeded, Packer will output an AWS AMI ID. Use this AMI to launch a new EC2 instance (see below).

### Starting an EC2 Instance with the Image

If Packer succeeded, the AMI will be listed in the EC2 Management Console. Select it and launch a new instance:

![ec2](https://cloud.githubusercontent.com/assets/27153/19950612/c34808ca-a115-11e6-9972-2b5b108d1041.png)

After a few minutes, the EC2 host that was just created will appear in New Relic Infrastructure:

![infra](https://cloud.githubusercontent.com/assets/27153/19950610/c105c516-a115-11e6-952c-dc6c40103b2b.png)

### Customizing

The script, `infra-install.sh`, should work for ubuntu or debain-based Linux distrubutions as well. The AWS AMI image ID in the `.json` file and the default user name (`ec2-user`) will need to be updated. 

Note: This is strictly for demo purposes, and is not an offically supported method to install New Relic infrastructure. For the official, most up-to-date documentation, go here: https://docs.newrelic.com/docs/infrastructure/new-relic-infrastructure/installation/install-infrastructure-linux
