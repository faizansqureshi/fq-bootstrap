# need to understand the policy and their usage 

# Foundation write policy
resource "aws_iam_policy" "fq_foundation_write" {
  name        = "FQFoundationPolicy"
  description = "Allow access to foundation Policy"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
          "Action": [
                "iam:ListRoles",
                "iam:ListRoleTags",
                "iam:ListRolePolicies",
                "iam:ListPolicyVersions",
                "iam:ListInstanceProfilesForRole",
                "iam:ListInstanceProfiles",
                "iam:ListEntitiesForPolicy",
                "iam:ListAttachedRolePolicies",
                "iam:GetRolePolicy",
                "iam:GetRole",
                "iam:GetPolicyVersion",
                "iam:GetPolicy"
            ],
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "UncheckedIAMReadActions"
        },
        {
            "Action": [
                "iam:UpdateRole",
                "iam:UpdateAssumeRolePolicy",
                "iam:UntagRole",
                "iam:UntagPolicy",
                "iam:TagRole",
                "iam:TagPolicy",
                "iam:PutRolePolicy",
                "iam:PutRolePermissionsBoundary",
                "iam:DetachRolePolicy",
                "iam:DeleteRolePolicy",
                "iam:DeleteRolePermissionsBoundary",
                "iam:DeleteRole",
                "iam:DeletePolicyVersion",
                "iam:DeletePolicy",
                "iam:CreateRole",
                "iam:CreatePolicyVersion",
                "iam:CreatePolicy",
                "iam:AttachRolePolicy"
            ],
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "UncheckedIAMWriteActions"
        }
    ],
    "Version": "2012-10-17"
})
      }
    
# S3 Terraform policy for foundation S3 bucket
resource "aws_iam_policy" "tfstate_write" {
  name        = "ServiceQuoataPolicy"
  description = "Service Quota Policy full Access"
    policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Action" : [
          "s3:ListObjectsV2",
          "s3:ListObjects",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = var.s3_bucket_arn
      },
      {
        "Action" : [
          "s3:PutObject",
          "s3:ListObjectsV2",
          "s3:ListObjects",
          "s3:HeadObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Effect   = "Allow",
        Resource = var.s3_bucket_arn
      }
    ],
    "Version" : "2012-10-17"

  })
  
}
  
