# Install an rsyslog included snippet
define syslog::rule($command, $order = 10) {
  file { "${order}-${title}.conf":
    name    => "/etc/rsyslog.d/${order}-${title}.conf",
    content => $command,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['rsyslog'],
    notify  => Service['rsyslog'],
  }
}
