class sipb::profile::base {
  include zulip::profile::base

  $org_base_packages = [
    'fake-package',
  ]
  zulip::safepackage { $org_base_packages: ensure => installed }
}

# Note: This file is not currently used. Instead we have
#
#     puppet_classes = zulip::profile::standalone, sipb::profile::zz_server
#
# in `/etc/zulip/zulip.conf`.
