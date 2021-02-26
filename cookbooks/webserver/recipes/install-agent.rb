#
# Cookbook:: webserver
# Recipe:: install-agent
#
# Copyright:: 2021, The Authors, All Rights Reserved.

package 'unzip'

directory '/home/ec2-user/agent' do
  owner 'ec2-user'
  group 'ec2-user'
  mode '0755'
  action :create
end

template '/home/ec2-user/agent/alarm-config.json' do
  source 'config.json.erb'
end

bash 'Install Agent' do 
  cwd '/home/ec2-user'
  code <<-EOH
    cd agent
    wget https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/AmazonCloudWatchAgent.zip
    unzip AmazonCloudWatchAgent.zip
    sudo ./install.sh
    sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:alarm-config.json -s
  EOH
end