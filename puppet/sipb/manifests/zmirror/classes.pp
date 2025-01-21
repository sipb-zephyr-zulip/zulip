class sipb::zmirror::classes inherits sipb::zmirror::base {
  file { "${zulip::common::supervisor_conf_dir}/zmirror.conf":
    ensure  => file,
    require => Package[supervisor],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/kandra/supervisor/conf.d/zmirror.conf',
    notify  => Service['supervisor'],
  }

  file { '/etc/cron.d/zephyr-mirror':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/kandra/cron.d/zephyr-mirror',
  }

  file { '/etc/default/zephyr-clients':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/kandra/zephyr-clients',
  }

  # TODO: Do the rest of our setup, which includes at least:
  # Putting tabbott/extra's keytab on the system at /home/zulip/tabbott.extra.keytab
}
