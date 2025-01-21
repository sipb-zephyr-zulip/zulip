class sipb::profile::base {
  include zulip::profile::base

  $org_base_packages = [
    'fake-package',
  ]
  zulip::safepackage { $org_base_packages: ensure => installed }
}
