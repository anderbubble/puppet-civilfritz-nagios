define nagios::contact

(
  $ensure                       = undef,
  $use                          = 'generic-contact',
  $email                        = undef,
  $targetdir                    = '/etc/nagios/objects/contacts',
  $host_notification_period     = undef,
  $service_notification_period  = undef,
  $host_notification_options    = undef,
  $service_notification_options = undef,
  $can_submit_commands          = undef
)

{
  $target = "${targetdir}/${title}.cfg"
  $target_ensure = $ensure ?
  {
    absent  => absent,
    default => present,
  }

  nagios_contact
  { $title:
    ensure                       => $ensure,
    contact_name                 => $name,
    email                        => $email,
    target                       => $target,
    use                          => $use,
    host_notification_period     => $host_notification_period,
    service_notification_period  => $service_notification_period,
    host_notification_options    => $host_notification_options,
    service_notification_options => $service_notification_options,
    can_submit_commands          => $can_submit_commands,
  }

  file
  { $target:
    ensure => $target_ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
  }

  File[$targetdir] -> File[$target] -> Nagios_contact[$title] ~> Service['nagios']
}
