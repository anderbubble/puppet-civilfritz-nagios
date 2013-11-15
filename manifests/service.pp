define nagios::service

(
  $ensure = undef,
  $host_name = undef,
  $check_command = undef,
  $use = 'local-service',
  $targetdir = '/etc/nagios/objects/services',
  $contact_groups = undef,
  $contacts = undef,
  $notification_interval = undef,
  $register = undef,
  $passive_checks_enabled = undef,
  $active_checks_enabled = undef,
  $flap_detection_enabled = undef,
  $max_check_attempts = undef,
  $check_interval = undef,
  $retry_interval = undef,
  $service_description = undef,
  $freshness_threshold = undef,
  $check_freshness = undef,
  $servicegroups = undef,
  $notifications_enabled = undef,
  $notification_period = undef
)

{
  $target = "${targetdir}/${title}.cfg"

  $service_description_real = $service_description ?
  {
    undef   => $name,
    default => $service_description,
  }  

  nagios_service
  { $title:
    ensure                 => $ensure,
    require                => File[$targetdir],
    notify                 => Service['nagios'],
    host_name              => $host_name,
    check_command          => $check_command,
    service_description    => $service_description_real,
    servicegroups          => $servicegroups,
    use                    => $use,
    target                 => $target,
    contacts               => $contacts,
    contact_groups         => $contact_groups,
    notifications_enabled  => $notifications_enabled,
    notification_interval  => $notification_interval,
    register               => $register,
    passive_checks_enabled => $passive_checks_enabled,
    active_checks_enabled  => $active_checks_enabled,
    flap_detection_enabled => $flap_detection_enabled,
    max_check_attempts     => $max_check_attempts,
    freshness_threshold    => $freshness_threshold,
    check_freshness        => $check_freshness,
    check_interval         => $check_interval,
    retry_interval         => $retry_interval,
    notification_period    => $notification_period,
  }

  $target_ensure = $ensure ?
  {
    absent  => absent,
    default => present,
  }

  file
  { $target:
    ensure  => $target_ensure,
    require => Nagios_service[$title],
    notify  => Service['nagios'],
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
  }
}
