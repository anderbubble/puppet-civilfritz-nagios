class nagios::package
{
  include nagios::params

  package
  { 'nagios':
    ensure => present,
  }
}
