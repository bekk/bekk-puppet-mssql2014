# == class: MSSQL2014
#
# == Parameters
#
# $media
# location of installation files.  This is a required parameter, because
# without it, how can we install SQL server?
#
# == Authors
#
# PuppetLabs/ININ
#
class mssql2014 (
  # See http://msdn.microsoft.com/en-us/library/ms144259.aspx
  # Media is required to install
  $media,
  $instanceid     = $mssql2014::params::instanceid,
  $instancename   = $mssql2014::params::instancename,
  $features       = $mssql2014::params::features,
  $agtsvcaccount  = $mssql2014::params::agtsvcaccount,
  $agtsvcpassword = $mssql2014::params::agtsvcpassword,
  $sqlsvcaccount  = $mssql2014::params::sqlsvcaccount,
  $sqlsvcpassword = $mssql2014::params::sqlsvcpassword,
  $instancedir    = $mssql2014::params::instancedir,
  $ascollation    = $mssql2014::params::ascollation,
  $sqlcollation   = $mssql2014::params::sqlcollation,
  $securitymode   = $mssql2014::params::securitymode,
  $admin          = $mssql2014::params::admin,
  $sapwd          = $mssql2014::params::sapwd,
  $sqluserdbdir   = $mssql2014::params::sqluserdbdir,
  $sqluserdblogdir  = $mssql2014::params::sqluserdblogdir,
  $sqlbackupdir   = $mssql2014::params::sqlbackupdir,
) inherits mssql2014::params {

  # validation
  validate_string($media)
  validate_string($instanceid)
  validate_string($instancename)
  validate_string($features)
  validate_string($agtsvcaccount)
  validate_string($agtsvcpassword)
  validate_string($sqlsvcaccount)
  validate_string($sqlsvcpassword)
  validate_string($instancedir)
  validate_string($ascollation)
  validate_string($sqlcollation)
  validate_string($securitymode)
  validate_string($admin)
  validate_string($sapwd)
  validate_string($sqluserdbdir)
  validate_string($sqluserdblogdir)
  validate_string($sqlbackupdir)

  User {
    ensure   => present,
    before => Exec['install_mssql2014'],
  }

  user { 'SQLAGTSVC':
    comment  => 'SQL 2014 Agent Service',
    password => $agtsvcpassword,
  }
  user { 'SQLSVC':
    comment  => 'SQL 2014 Service',
    groups   => 'Administrators',
    password => $sqlsvcpassword,
  }

  file { 'C:\sql2014install.ini':
    content => regsubst(template('mssql2014/config.ini.erb'), '(?<!r)\n', "\r\n", 'G'),
  }

  dism { 'NetFx3':
    ensure => present,
    all => true,
  }

  exec { 'install_mssql2014':
    command   => "${media}\\setup.exe /IACCEPTSQLSERVERLICENSETERMS /QS /CONFIGURATIONFILE=C:\\sql2014install.ini /SQLSVCPASSWORD=\"${sqlsvcpassword}\" /AGTSVCPASSWORD=\"${agtsvcpassword}\" /SQLUSERDBDIR=\"${sqluserdbdir}\" /SQLUSERDBLOGDIR=\"${sqluserdblogdir}\" /SQLBACKUPDIR \"${sqlbackupdir}\"",
    cwd       => $media,
    path      => $media,
    logoutput => true,
    creates   => $instancedir,
    timeout   => 1800,
    require   => [ File['C:\\sql2014install.ini'],
                   Dism['NetFx3'] ],
  }
}
