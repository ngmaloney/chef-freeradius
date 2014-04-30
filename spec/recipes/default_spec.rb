require_relative '../spec_helper'

describe 'freeradius::default' do
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set[:datacenter][:domain] = 'local'
      node.set[:freeradius][:clients] = {
        'localhost' => {
          'ipaddr' => '127.0.0.1',
          'netmask' => '0',
          'secret' => 'secret',
          'nastype' => 'other'
        },
        'test' => { 
          'ipaddr' => '10.0.0.0',
          'netmask' => '8',
          'secret' => 'secret',
          'nastype' => 'other'
        }
      }
    end.converge(described_recipe)
  end
  let(:chef_run_centos) do 
    ChefSpec::Runner.new(platform: 'centos', version: '5.9') do |node|
      node.set[:datacenter][:domain] = 'local'
      node.set[:freeradius][:clients] = {
        'localhost' => {
          'ipaddr' => '127.0.0.1',
          'netmask' => '0',
          'secret' => 'secret',
          'nastype' => 'other'
        },
        'test' => {
          'ipaddr' => '10.0.0.0',
          'netmask' => '8',
          'secret' => 'secret',
          'nastype' => 'other'
        }
      }
    end.converge(described_recipe)
  end

  it 'creates the client file' do
    template_content = <<HERE
# -*- text -*-
##
## clients.conf -- client configuration directives
##
##      $Id$

client localhost {
  ipaddr = 127.0.0.1
  netmask = 0
  secret = secret
  nastype = other
}
client test {
  ipaddr = 10.0.0.0
  netmask = 8
  secret = secret
  nastype = other
}
HERE
    expect(chef_run).to render_file("/etc/freeradius/clients.conf").with_content(template_content)
  end

  it 'installs freeradius' do
    expect(chef_run).to install_package('freeradius')
  end

  it 'installs freeradius on centos' do
    expect(chef_run_centos).to install_package('freeradius2')
  end

  it 'starts freeradius service ubuntu' do
    expect(chef_run).to start_service('freeradius')
  end
  
  it 'starts radiusd service centos' do
    expect(chef_run_centos).to start_service('radiusd')
  end

end
