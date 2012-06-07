define tomcat::webapp::service (
	$username,
	$description = $title,
	$webapp_base = "/srv"
) {
	file { "/etc/init.d/${username}":
			ensure => file,
			owner => root,
			group => root,
			mode => 0755,
			content => template("tomcat/service/init.erb"),
			require => Tomcat::Webapp::Tomcat[$username]
	}
	service { $username:
			ensure => running,
			enable => true,
			require => File["/etc/init.d/${username}"],
	}
}