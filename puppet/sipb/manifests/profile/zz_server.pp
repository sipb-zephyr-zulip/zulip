class sipb::profile::zz_server {
  include sipb::zmirror::classes
  include sipb::zmirror::personals

  $zz_server_packages = [ # convenience packages, mostly
    'screen',
    'mosh',
  ]
  package { $zz_server_packages:
    ensure => installed,
  }
}
