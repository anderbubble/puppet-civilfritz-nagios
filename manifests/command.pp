define nagios::command

(
  $ensure       = undef,
  $targetdir    = '/etc/nagios/objects/commands',
  $command_line = undef
)

{
  $target = "${targetdir}/${title}.cfg"
  $target_ensure = $ensure ?
  {
    absent  => absent,
    default => present,
  }

  nagios_command
  { $title:
    ensure       => $ensure,
    command_line => $command_line,
    target       => $target,
  }

  file
  { $target:
    ensure => $target_ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
  }

  File[$targetdir] -> Nagios_command[$title] -> File[$target] -> Service['nagios']
  Nagios_command[$title] ~> Service['nagios']
}
