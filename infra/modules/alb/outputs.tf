output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.main.arn
}

output "alb_arn_suffix" {
  description = "Sufijo del ARN del ALB"
  value       = aws_lb.main.arn_suffix
}

output "alb_dns_name" {
  description = "Nombre DNS del ALB"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB"
  value       = aws_lb.main.zone_id
}

output "alb_id" {
  description = "ID del ALB"
  value       = aws_lb.main.id
}

output "target_group_arn" {
  description = "ARN del Target Group"
  value       = aws_lb_target_group.main.arn
}

output "target_group_name" {
  description = "Nombre del Target Group"
  value       = aws_lb_target_group.main.name
}

output "listener_http_arn" {
  description = "ARN del listener HTTP"
  value       = aws_lb_listener.http.arn
}

output "listener_https_arn" {
  description = "ARN del listener HTTPS"
  value       = length(aws_lb_listener.https) > 0 ? aws_lb_listener.https[0].arn : null
}