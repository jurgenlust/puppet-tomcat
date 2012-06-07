define tomcat::webapp::war (
	$username,
	$context = "ROOT",
	$source,
	$webapp_base = "/srv"
) {
	file {
		"${webapp_base}/${username}/tomcat/webapps/${context}.war":
		ensure => file, 
		owner => $username,
		group => $username,
		mode => 0644,
		source => $source,
		require => Tomcat::Webapp::Tomcat[$username]
	}
}