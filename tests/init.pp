# This example installs the Tomcat 6 packages and creates 2 user instances:
#
# The first instance will be available at http://$fqdn:8180/examples.
# 
# The second instance does not have a war file yet. Once a jira.war file is
# added to its webapp folder, the application will be available at
# http://$fqdn:8280/jira. The war-file can be added later using the
# defined resource tomcat::webapp::war.
include tomcat

tomcat::webapp { 'examples':
	username => 'example',
	source => "puppet:///modules/tomcat/example/examples.war",
}

tomcat::webapp { 'jira':
	username => 'jira',
	number => 2,
	java_opts => "-server -Dorg.apache.jasper.runtime.BodyContentImpl.LIMIT_BUFFER=true -Dmail.mime.decodeparameters=true -Xms128m -Xmx512m -XX:MaxPermSize=256m -Djava.awt.headless=true",
	description => "Atlassian JIRA",
	webapp_base => "/opt",
	server_host_config => template("tomcat/example/context.erb")
}