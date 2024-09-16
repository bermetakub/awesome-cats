#!/bin/bash
touch ./demo.txt
sudo apt update
sudo apt-get install kubectl -y
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli -y
sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin -y
sudo apt-get -y install tinyproxy && sudo systemctl start tinyproxy && sudo systemctl enable tinyproxy
sudo su 
echo 'Allow localhost' >> /etc/tinyproxy/tinyproxy.conf
sudo systemctl restart tinyproxy
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https -y
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all   main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm -y
sudo apt-get install postgresql-client -y
curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
sudo dpkg -i gitlab-runner_amd64.deb
sudo curl -L --output /usr/local/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64"
sudo chmod +x /usr/local/bin/gitlab-runner
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo echo 'gitlab-runner ALL=(ALL:ALL) ALL' >> /etc/sudoers.d/gitlab-runner
sudo echo 'gitlab-runner ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/gitlab-runner
sudo gitlab-runner register \
  --non-interactive \
  --url "https://gitlab.com/" \
  --registration-token "glrt-5K1JhbFY2sbviWHb43Fo" \
  --description "shell-runner" \
  --tag-list "shell" \
  --executor "shell"
sudo gitlab-runner verify
sudo gitlab-runner start
sudo gitlab-runner status
sudo gitlab-runner run


