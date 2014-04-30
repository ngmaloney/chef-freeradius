Description
====

Installs Freeradius

Requirements
====



Usage
====

To enable LDAP Support, please override the following attributes in a wrapper cookbook as such

    node.override['freeradius']['enable_sql'] = false
    node.override['freeradius']['enable_ldap'] = true
    node.override['freeradius']['ldap_server'] = 'localhost'
    node.override['freeradius']['ldap_port'] = '636'
    node.override['freeradius']['ldap_basedn'] = 'dc=contoso,dc=local'
    
    node.override['freeradius']['clients'] = {
      'localhost' => {
        'ipaddr' => '127.0.0.1',
        'netmask' => '0',
        'secret' => 'password',
        'nastype' => 'other'
      },
      'production' => {
        'ipaddr' => '10.0.0.0',
        'netmask' => '8',
        'secret' => 'password',
        'nastype' => 'other'
      }
    }


License and Author
====

Author:: Nicholas Maloney (<ngmaloney@gmail.com>)

Copyright:: 2012 NM Consulting

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
