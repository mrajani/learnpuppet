node default {

}
node 'nodeb.iono.corp' {
  include ::motd

  #### Start Apache #########
  class { 'apache': 
    default_vhost => false,
    ip => undef, 
  }
  
  #apache::listen { '8141': }
  #apache::listen { '8142': }

  apache::vhost { 'app1.iono.corp':
    port         => '8141',
    docroot      => '/var/www/app1',
    directories  => [
      {
        'path'     => '/var/www/app1',
        'provider' => 'directory',
        'allow_override' => 'all',
        'allow'     => 'from all',
      }
    ],
  }

  apache::vhost { 'app2.iono.corp':
    port         => '8142',
    docroot      => '/var/www/app2',
    directories  => [
      {
        'path'     => '/var/www/app2',
        'provider' => 'directory',
        'allow_override' => 'all',
        'allow'     => 'from all',
      }
    ],
  }

  apache::vhost { 'app3.iono.corp':
    port         => '8143',
    docroot      => '/var/www/app3',
    directories  => [
      { 
        'path'     => '/var/www/app3',
        'provider' => 'directory',
        'deny'     => 'from all',
      }    
    ], 
  }

  #### End Apache ###########

  #### Start HAproxy ########

  class { 'haproxy': 
    defaults_options => {
      'log'     => 'global',
      'option'  => 'redispatch',
      'retries' => '3',
      'timeout' => [
        'http-request 10s',
        'queue 1m',
        'connect 10s',
        'client 1m',
        'server 1m',
        'check 10s'
      ],
      'maxconn' => '8000'
    }
  }

  haproxy::listen { 'admin':
    ipaddress   => $::ipaddress_eth1,
    ports       => 8899,   
    options     => {
      'mode'    => 'http',
      'stats'   => 'uri /',
    }
  }

  haproxy::frontend { "http-in":
    ports      => 80,
    ipaddress  => '*',
    options    => {
      'default_backend' => "servers-http",
    },
  }
  
  haproxy::backend { "servers-http":
    options    => {

    }
  }

  haproxy::balancermember { 'master00':
    listening_service => 'servers-http',
    server_names      => 'localhost1',
    ipaddresses       => $::ipaddress_eth1,
    ports             => 8141,
    options           => 'check',
  }

  haproxy::balancermember { 'master01':
    listening_service => 'servers-http',
    server_names      => 'localhost2',
    ipaddresses       => $::ipaddress_eth1,
    ports             => 8142,
    options           => 'check',
  }

  #### End HAproxy ###########
}
