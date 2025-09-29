# Trust Policy
data "aws_iam_policy_document" "ecs_instance_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"] # ou "ecs-tasks.amazonaws.com" dependendo do caso
    }
  }
}

# IAM Role
resource "aws_iam_role" "ecs_instance_role" {
  name_prefix        = "ecs-instance-role-tf"
  assume_role_policy = data.aws_iam_policy_document.ecs_instance_role.json
}

# Anexa a policy do ECS
resource "aws_iam_role_policy_attachment" "ecs_instance_role_policy" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}


resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ecs_node" {
  name_prefix = "ecs-node-profile-tf-profile"
  path        = "/ecs/instance/"
  role        = aws_iam_role.ecs_instance_role.name
}