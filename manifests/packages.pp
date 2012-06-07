class tomcat::packages {
	package {
		tomcat6 :
			ensure => present,
			require => Class["tomcat::java"],
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