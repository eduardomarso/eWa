# eWa

docker build -t imessage-exporter .

docker run --rm \
  -v "/Users/3dy/Library/Application Support/MobileSync/Backup/00008110-0018159E1EC0401E:/backup" \
  -v "/Users/3dy/Downloads/output:/output" \
  imessage-exporter \
  -a iOS -p /backup -o /output -f html
