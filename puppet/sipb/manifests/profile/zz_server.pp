class sipb::profile::zz_server {
  include sipb::zmirror::classes
  include sipb::zmirror::personals
  include kandra::firewall

  kandra::firewall_allow{ 'ssh': }
  kandra::firewall_allow{ 'http': }
  kandra::firewall_allow{ 'https': }

  $zz_server_packages = [ # convenience packages, mostly
    'screen',
    'mosh',
  ]
  package { $zz_server_packages:
    ensure => installed,
  }
}
