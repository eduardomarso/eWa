# eWa

docker build -t message-exporter .

docker run --rm \
  -v "/Users/3dy/Library/Application Support/MobileSync/Backup/*:/backup" \
  -v "/Users/3dy/Downloads/output:/output" \
  message-exporter
