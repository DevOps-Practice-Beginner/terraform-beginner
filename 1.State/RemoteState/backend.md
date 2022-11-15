1.Create S3 bucket
2. Create dynamo db table with key : LockID(Case sensitive)
3.Update the backend.tf and main.tf with S3,dynamo and subnet details



TF Commands:
tf init
tf fmt == Checking the files modified
tf plan
tf validate
tf apply 
