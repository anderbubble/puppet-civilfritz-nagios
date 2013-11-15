define nagios::host

(
  $ensure = undef,
  $display_name = undef,
  $address = undef,
  $use = 'generic-host',
  $hostgroups = undef,
  $targetdir = '/etc/nagios/objects/hosts',
  $contacts = undef,
  $contact_groups = undef,
  $register = undef,
  $parents = undef,
  $notifications_enabled = undef,
  $check_command = undef,
  $check_interval = undef,
  $retry_interval = undef,
  $max_check_attempts = undef,
  $notification_interval = undef,
  $notification_period = undef
)

{
  $target = "${targetdir}/${title}.cfg"

  nagios_host
  { $title:
    ensure                => $ensure,
    display_name          => $display_name,
    require               => File[$targetdir],
    notify                => Service['nagios'],
    host_name             => $name,
    use                   => $use,
    address               => $address,
    target                => $target,
    hostgroups            => $hostgroups,
    contacts              => $contacts,
    contact_groups        => $contact_groups,
    parents               => $parents,
    register              => $register,
    notifications_enabled => $notifications_enabled,
    check_command         => $check_command,
    check_interval        => $check_interval,
    retry_interval        => $retry_interval,
    max_check_attempts    => $max_check_attempts,
    notification_interval => $notification_interval,
    notification_period   => $notification_period,
  }

  $target_ensure = $ensure ?
  {
    absent  => absent,
    default => present,
  }

  file
  { $target:
    ensure  => $target_ensure,
    require => Nagios_host[$title],
    notify  => Service['nagios'],
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
  }
}
