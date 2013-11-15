define nagios::timeperiod

(
  $ensure           = undef,
  $use              = undef,
  $exclude          = undef,
  $targetdir        = '/etc/nagios/objects/timeperiods',
  $timeperiod_alias = undef,
  $sunday           = undef,
  $monday           = undef,
  $tuesday          = undef,
  $wednesday        = undef,
  $thursday         = undef,
  $friday           = undef,
  $saturday         = undef
)

{
  $target = "${targetdir}/${title}.cfg"
  $target_ensure = $ensure ?
  {
    absent  => absent,
    default => present,
  }

  nagios_timeperiod
  { $title:
    require   => File[$target],
    notify    => Service['nagios'],
    ensure    => $ensure,
    target    => $target,
    use       => $use,
    exclude   => $exclude,
    alias     => $alias,

    sunday    => $sunday,
    monday    => $monday,
    tuesday   => $tuesday,
    wednesday => $wednesday,
    thursday  => $thursday,
    friday    => $friday,
    saturday  => $saturday,
  }

  file
  { $target:
    ensure  => $target_ensure,
    require => File[$targetdir],
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
  }
}
