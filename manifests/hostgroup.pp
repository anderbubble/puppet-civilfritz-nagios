define nagios::hostgroup

(
  $ensure=undef,
  $targetdir='/etc/nagios/objects/hostgroups',
  $hostgroup_alias=undef,
  $members=undef,
  $hostgroup_members=undef,
  $notes=undef,
  $notes_url=undef,
  $action_url=undef
)

{
  $target = "${targetdir}/${title}.cfg"
  $target_ensure = $ensure ?
  {
    absent  => absent,
    default => present,
  }

  nagios_hostgroup
  { $title:
    ensure            => $ensure,
    hostgroup_name    => $name,
    target            => $target,
    alias             => $hostgroup_alias,
    members           => $members,
    hostgroup_members => $hostgroup_members,
    notes             => $notes,
    notes_url         => $notes_url,
    action_url        => $action_url,
  }

  file
  { $target:
    ensure => $target_ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
  }

  File[$targetdir] -> Nagios_hostgroup[$title] -> File[$target] -> Service['nagios']
  Nagios_hostgroup[$title] ~> Service['nagios']
}
