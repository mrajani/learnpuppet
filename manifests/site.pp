
node default {
    # class { 'ntp':
    #     service_ensure => 'stopped', 
    # }
     
    #include ::day2ops
    include ::motd
}

node 'nodeb.iono.corp' {
    include ::motd
    # include ::account    
}
