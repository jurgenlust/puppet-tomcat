define tomcat::webapp::tomcat ($username,
	$number = 1,
	$java_opts = "-Djava.awt.headless=true -Xmx128M",
	$server_host_config = "",
	$webapp_base = "/srv") {
		
	file {
		"${webapp_base}/${username}/tomcat" :
			ensure => directory,
			owner => $username,
			group => $username,
			mode => 0755,
			require => [Class["tomcat"], Tomcat::Webapp::User[$username]],
	}
	file {
		"${webapp_base}/${username}/tomcat/logs" :
			ensure => directory,
			owner => $username,
			group => $username,
			mode => 0755,
			require => File["${webapp_base}/${username}/tomcat"],
	}
	file {
		"${webapp_base}/${username}/tomcat/temp" :
			ensure => directory,
			owner => $username,
			group => $username,
			mode => 0755,
			require => File["${webapp_base}/${username}/tomcat"],
	}
	file {
		"${webapp_base}/${username}/tomcat/webapps" :
			ensure => directory,
			owner => $username,
			group => $username,
			mode => 0755,
			require => File["${webapp_base}/${username}/tomcat"],
	}
	file {
		"${webapp_base}/${username}/tomcat/work" :
			ensure => directory,
			owner => $username,
			group => $username,
			mode => 0755,
			require => File["${webapp_base}/${username}/tomcat"],
	}
	file {
		"${webapp_base}/${username}/tomcat/bin" :
			ensure => directory,
			owner => $username,
			group => $username,
			mode => 0755,
			require => File["${webapp_base}/${username}/tomcat"],
	}
	file {
		"${webapp_base}/${username}/tomcat/conf" :
			ensure => directory,
			owner => $username,
			group => $username,
			mode => 0755,
			require => File["${webapp_base}/${username}/tomcat"],
	}
	file {
		"${webapp_base}/${username}/tomcat/lib" :
			ensure => directory,
			owner => $username,
			group => $username,
			mode => 0755,
			require => File["${webapp_base}/${username}/tomcat"],
	}
	file {
		"${webapp_base}/${username}/tomcat/bin/bootstrap.jar" :
			ensure => link,
			target => "/usr/share/tomcat6/bin/bootstrap.jar",
			require => File["${webapp_base}/${username}/tomcat/bin"],
	}
	file {
		"${webapp_base}/${username}/tomcat/bin/setenv.sh" :
			ensure => file,
			owner => $username,
			group => $username,
			mode => 0755,
			require => File["${webapp_base}/${username}/tomcat/bin"],
			content => template('tomcat/bin/setenv.sh.erb'),
	}
	file {
		"${webapp_base}/${username}/tomcat/bin/shutdown.sh" :
			ensure => file,
			owner => $username,
			group => $username,
			mode => 0755,
			require => File["${webapp_base}/${username}/tomcat/bin"],
			content => template('tomcat/bin/shutdown.sh.erb'),
	}
	file {
		"${webapp_base}/${username}/tomcat/bin/startup.sh" :
			ensure => file,
			owner => $username,
			group => $username,
			mode => 0755,
			require => File["${webapp_base}/${username}/tomcat/bin"],
			content => template('tomcat/bin/startup.sh.erb'),
	}
	file {
		"${webapp_base}/${username}/tomcat/conf/server.xml" :
			ensure => file,
			owner => $username,
			group => $username,
			mode => 0644,
			require => File["${webapp_base}/${username}/tomcat/conf"],
			content => template('tomcat/conf/server.xml.erb'),
	}
	file {
		"${webapp_base}/${username}/tomcat/conf/catalina.policy" :
			ensure => file,
			owner => $username,
			group => $username,
			mode => 0644,
			source => "puppet:///modules/tomcat/conf/catalina.policy",
			require => File["${webapp_base}/${username}/tomcat/conf"],
	}
	file {
		"${webapp_base}/${username}/tomcat/conf/catalina.properties" :
			ensure => file,
			owner => $username,
			group => $username,
			mode => 0644,
			source => "puppet:///modules/tomcat/conf/catalina.properties",
			require => File["${webapp_base}/${username}/tomcat/conf"],
	}
	file {
		"${webapp_base}/${username}/tomcat/conf/context.xml" :
			ensure => file,
			owner => $username,
			group => $username,
			mode => 0644,
			source => "puppet:///modules/tomcat/conf/context.xml",
			require => File["${webapp_base}/${username}/tomcat/conf"],
	}
	file {
		"${webapp_base}/${username}/tomcat/conf/logging.properties" :
			ensure => file,
			owner => $username,
			group => $username,
			mode => 0644,
			source => "puppet:///modules/tomcat/conf/logging.properties",
			require => File["${webapp_base}/${username}/tomcat/conf"],
	}
	file {
		"${webapp_base}/${username}/tomcat/conf/tomcat-users.xml" :
			ensure => file,
			owner => $username,
			group => $username,
			mode => 0644,
			source => "puppet:///modules/tomcat/conf/tomcat-users.xml",
			require => File["${webapp_base}/${username}/tomcat/conf"],
	}
	file {
		"${webapp_base}/${username}/tomcat/conf/web.xml" :
			ensure => file,
			owner => $username,
			group => $username,
			mode => 0644,
			source => "puppet:///modules/tomcat/conf/web.xml",
			require => File["${webapp_base}/${username}/tomcat/conf"],
	}
	file {
		"/etc/${username}" :
			ensure => link,
			target => "${webapp_base}/${username}/tomcat/conf",
	}
	file {
		"/var/log/${username}" :
			ensure => link,
			target => "${webapp_base}/${username}/tomcat/logs",
	}
}