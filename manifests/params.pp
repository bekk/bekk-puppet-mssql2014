# == class: mssql2014::params
#
# This class manages MSSQL paraameters
#
# == Parameters
#
# $instanceid
# $instancename
# $features
# $agtsvcaccount
# $agtsvcpassword
# $sqlsvcaccount
# $sqlsvcpassword
# $instancedir
# $ascollation
# $sqlcollation
# $admin
#
class mssql2014::params {
  $instanceid     = 'MSSQLSERVER'
  $instancename   = 'MSSQLSERVER'
  $features       = 'SQL,Tools'
  $agtsvcaccount  = 'SQLAGTSVC'
  $agtsvcpassword = 'D0gf00d'
  $sqlsvcaccount  = 'SQLSVC'
  $sqlsvcpassword = 'D0gf00d'
  $instancedir    = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Binn\sqlservr.exe'
  $ascollation    = 'Latin1_General_CI_AS'
  $sqlcollation   = 'SQL_Latin1_General_CP1_CI_AS'
  $securitymode   = 'SQL'
  $admin          = 'Administrator'
  $sapwd          = 'D0gf00d'
  $sqluserdbdir   = "${instancedir}\\${instanceid}\\MSSQL\\Data"
  $sqluserdblogdir  = "${instancedir}\\${instanceid}\\MSSQL\\Data"
  $sqlbackupdir   = "${instancedir}\\${instanceid}\\MSSQL\\Data"
}
