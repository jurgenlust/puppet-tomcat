# Create a user, a Tomcat instance and an init script for a webapp,
# optionally specifying JAVA_OPTS and webapp configuration such as JNDI 
# datasources in server.xml.
#
# The tomcat instance lives in ${webapp_base}/${username}/tomcat.
#
# The init-script will be named /etc/init.d/${username}.
# 
# Any libraries required to run the webapp should be placed in
# ${webapp_base}/${username}/tomcat/lib
#
# The following symlinks will be created:
# /etc/${username} -> ${webapp_base}/${username}/tomcat/conf
# /var/log/${username} -> ${webapp_base}/${username}/tomcat/logs
  
define tomcat::webapp(
	$username,
	$number = 1,
	$java_opts = "-Djava.awt.headless=true -Xmx128M",
	$server_host_config = "",
	$description = $title,
	$webapp_base = "/srv",
	$service_require = Class['tomcat'],
	$source = undef,
	$context = undef
) {
		tomcat::webapp::user { $username: 
			username => $username,
			webapp_base => $webapp_base,
			require => Class["tomcat"],
		}
		tomcat::webapp::tomcat { $username:
			username => $username, 
			number => $number,
			java_opts => $java_opts,
			server_host_config => $server_host_config,
			webapp_base => $webapp_base,
			require => Tomcat::Webapp::User[$username],
		}
		tomcat::webapp::service { $username:
			username => $username, 
			webapp_base => $webapp_base,
			require => [
				Tomcat::Webapp::Tomcat[$username],
				$service_require
			]
		}
		if ($source) {
			if ($context) {
				$webapp_context = $context
			} else {
				$webapp_context = $username
			}
			tomcat::webapp::war { $username:
				username => $username,
				webapp_base => $webapp_base,
				context => $webapp_context,
				source => $source,
				require => Tomcat::Webapp::Tomcat[$username],
				before => Tomcat::Webapp::Service[$username]
			}
		}
}