output "ECS-cluster-id" {
   value  = "${aws_ecs_cluster.my_cluster.id}"
}
output "ECS-cluster-name" {
   value  = "${aws_ecs_cluster.my_cluster.name}"
}

