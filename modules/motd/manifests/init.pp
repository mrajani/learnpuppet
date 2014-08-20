# Class: motd
#
# This module manages the /etc/motd file using a template
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  include motd
#
# [Remember: No empty lines between comments and class definition]
class motd {
  $servers = [
    '0.debian.pool.ntp.org',
    '1.debian.pool.ntp.org',
    '2.debian.pool.ntp.org',
    '3.debian.pool.ntp.org',
  ]
  if $kernel == "Linux" {
    file { '/etc/motd':
      ensure  => file,
      backup  => false,
      content => template("motd/motd.erb"),
    }
  }
  notify {" Welcome to MOTD server $::system_role":}
  notify {" Welcome to console server $::console":}
  notify {" Welcome to servers $servers":}
}
