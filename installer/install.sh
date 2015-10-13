#!/bin/bash

install_dir=${install_dir:-/var/lib}
initd_dir=${initd_dir:-/etc/init.d}
daemon_script="aws_dynamodb_local"

url="http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest"

# Check preinitialization
# rm -rf dynamodb_local_latest

if [ -f dynamodb_local_latest.tar.gz ];
then
  echo "AWS DynamoDB Local already exists"
else
  echo "Downloading latest AWS DynamoDB Local..."
  wget --no-check-certificate $url -O dynamodb_local_latest.tar.gz
fi

echo "Installing AWS DynamoDB Local..."
mkdir -p $install_dir/aws_dynamodb_local
tar xzvf dynamodb_local_latest.tar.gz -C $install_dir/aws_dynamodb_local/

echo "Installing daemon script..."
cp -upv `dirname $0`/$daemon_script $initd_dir/
chmod 755 $initd_dir/$daemon_script
chkconfig --add $initd_dir/$daemon_script

cat <<EOT


Installing AWS DynamoDB Local has done.
You can start with the following commands:
	Start:
	/etc/init.d/aws_dynamodb_local start

	Stop:
	/etc/init.d/aws_dynamodb_local stop

For more information about DynamoDB you can get from the following page.
	http://aws.amazon.com/en/dynamodb/

Thanks!

EOT

