class nagios::config
(
  $cgi_authorized_for_system_information = hiera('nagios::cgi_authorized_for_system_information', 'nagiosadmin'),
  $cgi_authorized_for_configuration_information = hiera('nagios::cgi_authorized_for_configuration_information', 'nagiosadmin'),
  $cgi_authorized_for_system_commands = hiera('nagios::cgi_authorized_for_system_commands', 'nagiosadmin'),
  $cgi_authorized_for_all_services = hiera('nagios::cgi_authorized_for_all_services', 'nagiosadmin'),
  $cgi_authorized_for_all_hosts = hiera('nagios::cgi_authorized_for_all_hosts', 'nagiosadmin'),
  $cgi_authorized_for_all_service_commands = hiera('nagios::cgi_authorized_for_all_service_commands', 'nagiosadmin'),
  $cgi_authorized_for_all_host_commands = hiera('nagios::cgi_authorized_for_all_host_commands', 'nagiosadmin')
)

{
  file
  { '/etc/nagios/nagios.cfg':
    source => "puppet:///modules/nagios/nagios.cfg.${::osfamily}",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file
  { '/etc/nagios/cgi.cfg':
    content => template('nagios/cgi.cfg.erb'),
    owner  => 'root',
    group  => '0',
    mode   => '0644',
  }

  $object_dirs = [
                  '/etc/nagios/objects/commands',
                  '/etc/nagios/objects/hosts',
                  '/etc/nagios/objects/hostgroups',
                  '/etc/nagios/objects/services',
                  '/etc/nagios/objects/servicegroups',
                  '/etc/nagios/objects/contacts',
                  '/etc/nagios/objects/contactgroups',
                  '/etc/nagios/objects/timeperiods',
                  ]

  file
  { $object_dirs:
    ensure => directory,
    owner  => 'nagios',
    group  => 'nagios',
    mode   => '0750',
  }
}
