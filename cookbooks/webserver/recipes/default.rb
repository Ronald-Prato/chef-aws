#
# Cookbook:: webserver
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

include_recipe 'webserver::install-aws'
include_recipe 'webserver::install-agent'