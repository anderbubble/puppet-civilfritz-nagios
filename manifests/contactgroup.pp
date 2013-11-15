define nagios::contactgroup

(
  $ensure             = undef,
  $targetdir          = '/etc/nagios/objects/contactgroups',
  $members            = undef,
  $contactgroup_alias = undef
)

{
  $target = "${targetdir}/${title}.cfg"
  $target_ensure = $ensure ?
  {
    absent  => absent,
    default => present,
  }

  nagios_contactgroup
  { $title:
    ensure            => $ensure,
    require           => File[$targetdir],
    contactgroup_name => $name,
    members           => $members,
    target            => $target,
    alias             => $contactgroup_alias,
  }

  file
  { $target:
    ensure  => $target_ensure,
    require => Nagios_contactgroup[$title],
    notify  => Service['nagios'],
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
  }
}
