# eWa
Whatsapp Exporter

docker build -t whatsapp-exporter-ios .

docker run --rm \
    -v /Users/3dy/Downloads/eWA/00008020-000475A13C42002E:/backup \
    -v /Users/3dy/Downloads/output:/output \
    whatsapp-exporter-ios -i -b /backup -o /output
