# == Class: account
#
# This class actually does nothing :) You probably add some users (see user.pp) and some groups (see group.pp).
#
class account (
      $user = hiera('user'),
      $group = hiera('group') 
      ) {
      user { $user:
              ensure  => present,
              gid     => $group,
              require => Group[$group]
              
      }
      group { $group:
              ensure => present,
      }
}
