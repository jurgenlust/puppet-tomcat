define tomcat::webapp::ajp(
	$apache_hostname = $fqdn,
	$webapp_hostname = "localhost",
	$number,
	$contextroot,
	$scheme = "http"
) {
	$context = $contextroot ? {
		'ROOT' => '',
		default => $contextroot
	}
	
	if (!defined(File["/etc/apache2/tomcat-webapps"])) {
		file { "/etc/apache2/tomcat-webapps":
			ensure => directory,
			owner => 'root',
			group => 'root',
			mode => 0755,
			require => Package["apache2"],
		}
	}
	
	file { "/etc/apache2/tomcat-webapps/${contextroot}":
		ensure => file,
		owner => 'root',
		group => 'root',
		mode => 0644,
		content => template("tomcat/ajp/proxy.erb"),
		require => File["/etc/apache2/tomcat-webapps"],
	}	
}