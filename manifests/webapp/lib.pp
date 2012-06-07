define tomcat::webapp::lib (
	$username,
	$filename,
	$source,
	$webapp_base = "/srv"
) {
	file {
		"${webapp_base}/${username}/tomcat/lib/${filename}.jar":
		ensure => file, 
		owner => $username,
		group => $username,
		mode => 0644,
		source => $source,
		require => Tomcat::Webapp::Tomcat[$username]
	}
}