# 1️⃣ Policy de confiança para EC2 assumir a role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# 2️⃣ Role IAM
resource "aws_iam_role" "role_acesso_ssm" {
  name               = "role-acesso-ssm"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# 3️⃣ Anexar policies à role
locals {
  iam_policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
  ]
}

resource "aws_iam_role_policy_attachment" "attach" {
  for_each   = toset(local.iam_policies)
  role       = aws_iam_role.role_acesso_ssm.name
  policy_arn = each.value
}

# 4️⃣ Instance Profile
resource "aws_iam_instance_profile" "role_acesso_ssm" {
  name = "role-acesso-ssm"
  role = aws_iam_role.role_acesso_ssm.name
}

resource "aws_iam_role_policy_attachment" "role_acesso_ssm_policy" {
  role       = aws_iam_role.role_acesso_ssm.name
  policy_arn = aws_iam_policy.get_secret_bia_db.arn

}
