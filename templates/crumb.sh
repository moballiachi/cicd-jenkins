crumb=$(curl -u "admin:admin" -s 'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')

echo "[INFO] $crumb"

subcrumb=$(echo $crumb| cut -d':' -f 2)
echo $subcrumb

#curl -u "admin:admin" -H "$crumb" -X POST  http://50.116.18.24:8080/job/remote-ecraft-deploy/build

#curl -X POST  http://50.116.18.24:8080/job/remote-ecraft-deploy/build?TOKEN=$crumb

#curl --user "admin:admin"  -H "$crumb" -X POST  "http://50.116.18.24:8080/job/remote-ecraft-deploy/build?TOKEN=11e5e3bb5a7eb59d67f8e6e3af9dc8f84e"

curl -I -X POST http://admin:11e5e3bb5a7eb59d67f8e6e3af9dc8f84e@50.116.18.24:8080/job/remote-ecraft-deploy/build -H "$crumb"
