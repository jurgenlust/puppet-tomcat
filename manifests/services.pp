# The default Tomcat service should be stopped and disabled.
# We prefer running webapps in separate Tomcat instances.
class tomcat::services {
	service {
		"tomcat6" :
			ensure => stopped,
			enable => false,
			require => Package["tomcat6"],
	}
}