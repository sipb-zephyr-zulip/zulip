class sipb::zmirror::personals inherits sipb::zmirror::base {
  concat::fragment { '01-supervisor-zmirror':
    order   => '10',
    target  => $zulip::common::supervisor_conf_file,
    content => " ${zulip::common::supervisor_system_conf_dir}/zmirror/*.conf",
  }

  file { ['/home/zulip/logs', '/home/zulip/api-keys', '/home/zulip/zephyr_sessions', '/home/zulip/ccache',
          '/home/zulip/mirror_status', "${zulip::common::supervisor_system_conf_dir}/zmirror"]:
    ensure => directory,
    mode   => '0755',
    owner  => 'zulip',
    group  => 'zulip',
  }

  file { '/etc/cron.d/test_zephyr_personal_mirrors':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/kandra/cron.d/test_zephyr_personal_mirrors',
  }
}
