define nagios::servicegroup

(
  $ensure = undef,
  $targetdir = '/etc/nagios/objects/servicegroups',
  $servicegroup_alias = undef,
  $members = undef,
  $servicegroup_members = undef,
  $notes = undef,
  $notes_url = undef,
  $action_url = undef
)

{
  $target = "${targetdir}/${title}.cfg"
  $target_ensure = $ensure ?
  {
    absent  => absent,
    default => present,
  }

  nagios_servicegroup
  { $title:
    ensure               => $ensure,
    servicegroup_name    => $name,
    target               => $target,
    alias                => $servicegroup_alias,
    members              => $members,
    servicegroup_members => $servicegroup_members,
    notes                => $notes,
    notes_url            => $notes_url,
    action_url           => $action_url,
  }

  file
  { $target:
    ensure => $target_ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
  }

  File[$targetdir] -> Nagios_Servicegroup[$title] -> File[$target] -> Service['nagios']
  Nagios_servicegroup[$title] ~> Service['nagios']
}
