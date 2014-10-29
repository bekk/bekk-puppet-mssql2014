# Microsoft SQL Server puppet module.

This module installs Microsoft SQL Server 2014 on Windows 2012R2. It is based on the [Puppetlabs MSSQL module](https://forge.puppetlabs.com/puppetlabs/mssql)

## Installation

This module depends on DISM module to enable .net 3.5 on Windows Server:

* [dism module](http://forge.puppetlabs.com/puppetlabs/dism)

## Usage

Example:
```puppet
class {'mssql2014':
    media          => 'D:',
    instancename   => 'MSSQLSERVER',
    features       => 'SQL,AS,RS,IS',
    agtsvcaccount  => 'SQLAGTSVC',
    agtsvcpassword => 'sqlagtsvc2014demo',
    sqlsvcaccount  => 'SQLSVC',
    sqlsvcpassword => 'sqlsvc2014demo',
    instancedir    => "C:\\Program Files\\Microsoft SQL Server",
    ascollation    => 'Latin1_General_CI_AS',
    sqlcollation   => 'SQL_Latin1_General_CP1_CI_AS',
    admin          => 'Administrator'
    }
```

See http://msdn.microsoft.com/en-us/library/ms144259.aspx for more information about these options.
