output "project01_ssh_sg" {
    value = aws_security_group.project01_ssh_sg.id
}

output "project01_web_sg" {
    value = aws_security_group.project01_web_sg.id
}

output "project01_lb_sg" {
    value = aws_security_group.project01_lb_sg.id
}