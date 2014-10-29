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
  $instancename   = $mssql::params::instancename,
  $features       = $mssql::params::features,
  $agtsvcaccount  = $mssql::params::agtsvcaccount,
  $agtsvcpassword = $mssql::params::agtsvcpassword,
  $sqlsvcaccount  = $mssql::params::sqlsvcaccount,
  $sqlsvcpassword = $mssql::params::sqlsvcpassword,
  $instancedir    = $mssql::params::instancedir,
  $ascollation    = $mssql::params::ascollation,
  $sqlcollation   = $mssql::params::sqlcollation,
  $securitymode   = $mssql::params::securitymode,
  $admin          = $mssql::params::admin,
  $sapwd          = $mssql::params::sapwd,
) inherits mssql::params {

  # validation
  validate_string($media)
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

  User {
    ensure   => present,
    before => Exec['install_mssql2014'],
  }

  user { 'SQLAGTSVC':
    comment  => 'SQL 2014 Agent Service.',
    password => $agtsvcpassword,
  }
  user { 'SQLSVC':
    comment  => 'SQL 2014 Service.',
    groups   => 'Administrators',
    password => $sqlsvcpassword,
  }

  file { 'C:\sql2014install.ini':
    content => template('mssql/config.ini.erb'),
  }

  dism { 'NetFx3':
    ensure => present,
  }

  exec { 'install_mssql2014':
    command   => "${media}\\setup.exe /Action=Install /IACCEPTSQLSERVERLICENSETERMS /QS /CONFIGURATIONFILE=C:\\sql2014install.ini /SQLSVCPASSWORD=\"${sqlsvcpassword}\" /AGTSVCPASSWORD=\"${agtsvcpassword}\" ",
    cwd       => $media,
    path      => $media,
    logoutput => true,
    creates   => $instancedir,
    timeout   => 1200,
    require   => [ File['C:\sql2014install.ini'],
                   Dism['NetFx3'] ],
  }
}
