class sipb::zmirror::base {
  include zulip::supervisor

  # Needed for python:pyvenv
  #package { 'python-venv':
  #  ensure => present,
  #  name   => 'python3-venv',
  #}

  $zmirror_packages = [# Packages needed to run the mirror
    'libzephyr4-krb5',
    'zephyr-clients',
    'krb5-config',
    'krb5-user',
    # Packages needed to for ctypes access to Zephyr
    'python3-dev',
    'python3-typing-extensions',
  ]
  package { $zmirror_packages:
    ensure => installed,
  }

#  class { 'python':
#    manage_python_package => false,
#    manage_dev_package => false,
#  }
#
#  # Requires running:
#  # puppet module install --modulepath=$PWD/puppet:/srv/zulip-puppet-cache/ puppet/python
#  python::pyvenv { '/home/zulip/zmirror-venv':
#    #ensure => 'present',
#    #version => 'system',
#    #venv_dir => '/home/zulip/zmirror-venv',
#    owner => 'zulip',
#  }
#
#  python::pip { 'zulip':
#    virtualenv => '/home/zulip/zmirror-venv',
#    owner => 'zulip',
#    editable => true,
#    url => 'https://github.com/zulip/python-zulip-api',
#  }
  # I don't understand why the above didn't work, but:
  # sudo -uzulip virtualenv ~zulip/zmirror-venv && sudo -uzulip ~zulip/zmirror-venv/bin/pip install -e 'git+https://github.com/zulip/python-zulip-api#egg=zulip&subdirectory=zulip'
  # is fine


  file { '/etc/krb5.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/kandra/krb5.conf',
  }

  file { '/usr/lib/nagios/plugins/zulip_zephyr_mirror':
    require => Package[$zulip::common::nagios_plugins],
    recurse => true,
    purge   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/kandra/nagios_plugins/zulip_zephyr_mirror',
  }

  # Allow the relevant UDP ports
  concat::fragment { 'iptables-zmirror.v4':
    target => '/etc/iptables/rules.v4',
    source => 'puppet:///modules/kandra/iptables/zmirror.v4',
    order  => '20',
  }
  concat::fragment { 'iptables-zmirror.v6':
    target => '/etc/iptables/rules.v6',
    source => 'puppet:///modules/kandra/iptables/zmirror.v6',
    order  => '20',
  }
}
