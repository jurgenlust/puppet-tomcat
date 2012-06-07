class tomcat::java {
	package {
		openjdk-6-jre :
			ensure => present,
	}
	package {
		openjdk-6-jdk :
			ensure => present,
	}
}