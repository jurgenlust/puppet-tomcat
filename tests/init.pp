# This example installs the Tomcat 6 packages and creates 2 user instances:
#
# The first instance will be available at http://localhost:8180/example.
# 
# The second instance does not have a war file yet. Once a jira.war file is
# added to its webapp folder, the application will be available at
# http://localhost:8280/jira. The war-file can be added later using the
# defined resource tomcat::webapp::war.
#
# In addition, Apache is installed and the proxy_ajp module enabled, pointing
# to the example webapp. This makes the example webapp available on
# http://localhost/example.
include tomcat

tomcat::webapp { 'examples':
	username => 'example',
	number => 1,
	source => "puppet:///modules/tomcat/example/examples.war",
}

tomcat::webapp { 'jira':
	username => 'jira',
	number => 2,
	java_opts => "-server -Dorg.apache.jasper.runtime.BodyContentImpl.LIMIT_BUFFER=true -Dmail.mime.decodeparameters=true -Xms128m -Xmx512m -XX:MaxPermSize=256m -Djava.awt.headless=true",
	description => "Atlassian JIRA",
	webapp_base => "/opt",
	server_host_config => template("tomcat/example/context.erb"),
	service_require => Tomcat::Webapp::Lib['jira-log4j'],
}

tomcat::webapp::lib { 'jira-log4j':
	username => 'jira',
	filename => 'log4j',
	source => "puppet:///modules/tomcat/example/log4j.jar",
	webapp_base => "/opt",
}

package { "apache2":
	ensure => present
}

service { "apache2":
	ensure => running,
	require => Package["apache2"],
}

exec { "enable-mod-proxy-ajp":
	command => "/usr/sbin/a2enmod proxy_ajp",
	require => Package["apache2"],
}

file { "/etc/apache2/sites-available/default":
	ensure => file,
	content => template('tomcat/example/default-site.erb'),
	require => Exec["enable-mod-proxy-ajp"],
}

tomcat::webapp::ajp { 'example':
	contextroot => 'example',
	number => 1,
	require => File["/etc/apache2/sites-available/default"],
	notify => Service["apache2"]	
}

