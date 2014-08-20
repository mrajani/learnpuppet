class ntp::params {

      $package_ensure   = 'present'
      $package_enable   = true
      $service_ensure   = 'running'
    
      case $::osfamily {
          'Debian' : {
                 $package_name  = 'ntp'
                 $service_name  = 'ntp'
           }
          'RedHat' : {
                 $package_name  = 'ntp'
                 $service_name  = 'ntpd'
           }
           default: {
               fail("${module_name} does not support ${::osfamily}")
           }
      }
}
