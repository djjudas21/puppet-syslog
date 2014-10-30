# syslog

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)

## Overview

A one-maybe-two sentence summary of what the module does/what problem it solves.
This is your 30 second elevator pitch for your module. Consider including
OS/Puppet version it works with.

This module installs rsyslog on clients - it is not intended for syslog servers.
It provides a resource type that can be used to insert arbitrary syslog rules.

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

To install rsyslog and its base config:

```puppet
include syslog
```

To install an arbitrary syslog rule:

```puppet
syslog::rule { 'radiusd-log':
  command => "if \$programname == \'radiusd\' then /var/log/radius/radius.log\n&~",
  order   => '12',
}
```

When using `syslog::rule`, you can use any valid rsyslog syntax.

## Limitations

Written for CentOS 6. No testing on other platforms although it should be possible
to make it work on pretty much everything with minimal changes.
