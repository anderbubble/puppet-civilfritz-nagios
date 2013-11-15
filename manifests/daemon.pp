class nagios::daemon
{
  service
  { 'nagios':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
