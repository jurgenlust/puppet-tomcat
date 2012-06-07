define tomcat::webapp::user(
	$username,
	$webapp_base = "/srv"
) {
	file { $webapp_base:
		ensure => directory,
		require => Class["tomcat"],
	}
	group { $username:
		ensure => present,
	}
	user { $username:
		ensure => present,
		comment => "${username} owner",
		gid => $username,
		managehome => true,
		home => "${webapp_base}/${username}",
		shell => "/bin/sh",
		require => [
			Group[$username],
			File[$webapp_base]	
		]
	}
	
} 