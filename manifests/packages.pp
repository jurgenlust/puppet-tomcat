class tomcat::packages {
	package {
		tomcat6 :
			ensure => present,
	}
	package {
		libapr1 :
			ensure => present,
			require => Package["tomcat6"],
	}
	package {
		libtcnative-1 :
			ensure => present,
			require => Package["tomcat6"],
	}
}