output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.jenkins_server.public_ip
}

output "jenkins_url" {
  description = "Jenkins UI URL"
  value       = "http://${aws_instance.jenkins_server.public_ip}:8080"
}

output "sonarqube_url" {
  description = "SonarQube UI URL"
  value       = "http://${aws_instance.jenkins_server.public_ip}:9000"
}
