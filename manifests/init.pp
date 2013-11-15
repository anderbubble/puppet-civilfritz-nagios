class nagios
{
  class { 'nagios::package': } ->
  class { 'nagios::config': } ~>
  class { 'nagios::daemon': }
}
