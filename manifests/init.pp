# Install & configure rsyslog for clients
class syslog ($nagios_checks = false) {
  file { 'rsyslog.conf':
    name    => '/etc/rsyslog.conf',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/syslog/rsyslog.conf',
    require => Package['rsyslog'],
  }

  package { 'rsyslog':
    ensure => installed,
  }

  # Start the rsyslog service
  service { 'rsyslog':
    ensure     => running,
    subscribe  => File['rsyslog.conf'],
    require    => [ File['rsyslog.conf'], Package['rsyslog'] ],
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  if $nagios_checks {
    @@nagios_service { "check_rsyslogd_${::fqdn}":
      check_command       => 'check_nrpe!check_rsyslogd',
      service_description => 'rsyslog',
      use                 => '3min-service',
    }

    @@nagios_servicedependency { "check_rsyslogd_${::fqdn}":
      dependent_host_name           => $::fqdn,
      dependent_service_description => 'rsyslog',
      service_description           => 'NRPE',
    }
  }
}
