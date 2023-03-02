label       = "rp-playground"
k8s_version = "1.24"
region      = "ap-west"
pools = [
  {
    type : "g6-standard-2"
    count : 3
  }
]
#token should be exported from commandline
#export TF_VAR_token="YourToken"
#token = "E5f8efa7f78e882802caf24b4f7f14e5efa1b211e575269f59d38e542b86012c"