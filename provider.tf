# Name: provider.tf
# Owner: Saurav Mitra
# Description: This terraform config will Configure Terraform Providers
# https://www.terraform.io/docs/language/providers/requirements.html

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# Configure Terraform Kubernetes Provider
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs

# $ export KUBE_CONFIG_PATH="KubeConfigFilePath"
# $ export KUBE_CTX="ContextName"
# $ export KUBE_INSECURE=true

provider "kubernetes" {
  # Configuration options
  config_path    = var.config_path
  config_context = var.config_context
  # insecure       = true
}

# provider "kubernetes" {
#   host                   = "https://5CA6BAD28ED8063139BDE3FA7C7337B1.gr7.ap-southeast-1.eks.amazonaws.com"
#   token                  = "k8s-aws-v1.aHR0cHM6Ly9zdHMuYW1hem9uYXdzLmNvbS8_QWN0aW9uPUdldENhbGxlcklkZW50aXR5JlZlcnNpb249MjAxMS0wNi0xNSZYLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFZUFlZWFQ0VTVEN09PRlAzJTJGMjAyMTA5MjglMkZ1cy1lYXN0LTElMkZzdHMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDIxMDkyOFQxNDA2MzVaJlgtQW16LUV4cGlyZXM9MCZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QlM0J4LWs4cy1hd3MtaWQmWC1BbXotU2lnbmF0dXJlPTJkNGZkMmFmMGI2Y2U5YzdhMDIxN2UyN2YzMjkyM2JmZDlhZGNmMDc2Mzk5MjAzYzgyY2M3OTliZTY2NjUyMDc"
#   cluster_ca_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJeE1Ea3lPREV6TURRd00xb1hEVE14TURreU5qRXpNRFF3TTFvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTUFKCit6N2FMQmVGUmc2S1RpV3pDL2w0OFA2Ri96UDg0eVpOa1pBUTBQRUQ1UW80bEhWNDVXVVBFQ2lXZStXOUhKTHkKQWRHb3pFTkdwaDEwL2E1Ynl6VmE5c3pSbTRWVzM3SVJlTTM2bTNEMkFpQlVuUWFEWjhMVjBJV1B2cThRVHM1Ywo2bFpBN3lobXY5Q2s2b2NJTld3Z2gyTEJxR3Vhd1k2YkdqdW9jb2NYTFVpL213dnFIYmdsUEtlVVBqbkNobmN3ClRMQmcvU1QzZFFMZFRqSllQSGJGWGM5d0s5SDhhSDJ4Z1ZuMGZGbmlGMzEyM2UzcDE2SmkzeEZKU2k1WGRuMkoKbmFiZjEwOXB6c013RnJJRmwwNU82d0gwRm9sdS9wQzh3aXRDMmhsZ3BLcGdmNEE4ejN4cmtlVmllK2dYN0RNWgo1TGJFcEc0K2gzSk5PNWwreHVzQ0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZEdEROTUFvbGxQWGg0cFZsMWRPUGRuV3VPQ3pNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFDSlppd3ZzNCs4WHJoMjVRMTA3Z2Q2bmc0M1dDZDhVb3djUEJuOUFiekQ5WkNYSkhJTQpkRmJSTWNhdjJFYUVRWDhKNFFiYWtIQWNKdi9iVXAwL1JldDhUUDBQU0t1MUxIbzBDTitySW9HSDloMTVoNWJ1CktFKy9OejFjemsxazdSQjVLOUFFY3FucXVTelB3Q0VQNnU1dWxzbytMRjYyUlJhcGkzWHpBa3RFaTZEei9CRHMKaVpvdVlYOGJWWkllcm9scEZzWGhDYXBxWWM1MDJUd3BpTjlhV3ozSklvRC90TlQ2Q0p2QXlZK1BZK0g5YVU2eApIaGRkVm8zSWVCTFlONHl3ci9UUlVCUWxpWlN2YUoxbXN6aS9JaHFzTzdSUmZnZjhzVmpEVU5jZEFPNEFUY1NYCmF2R2QwWVRWUzRBaFd3ZndRQmFFTVg5L1VoQlVadnR5VEpwZQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==")
# }
