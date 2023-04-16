#
#git clone https://github.com/catatsuy/private-isu.git
#cd ./private-isu/provisioning
#
## ALL isu
#cp /home/user/.ssh/authorized_keys /root/.ssh
#
#vim hosts
#ansible-playbook -i hosts image/ansible/playbooks.yml --skip-tags nodejs
#ansible-playbook -i hosts bench/ansible/playbooks.yml
#
## isu-bm
#mv private_isu.git private_isu
#
#su - isucon
#/home/isucon/private_isu/benchmarker/bin/benchmarker -u /home/isucon/private_isu/benchmarker/userdata -t http://192.168.11.41


ansible-playbook -i hosts image/ansible/playbooks.yml --skip-tags nodejs
ansible-playbook -i hosts bench/ansible/playbooks.yml
# isu-bm
su - isucon
/home/isucon/private_isu.git/benchmarker/bin/benchmarker -u /home/isucon/private_isu.git/benchmarker/userdata -t http://192.168.11.41

# ssh port forward
ssh -fN -L 0.0.0.0:8080:192.168.11.41:80 192.168.11.41
ssh -fN -L 0.0.0.0:9100:192.168.11.41:9100 192.168.11.41
ssh -fN -L 0.0.0.0:9090:192.168.11.41:9090 192.168.11.41
ssh -fN -L 0.0.0.0:3100:192.168.11.41:3100 192.168.11.41
ssh -fN -L 0.0.0.0:3200:192.168.11.41:3200 192.168.11.41
ps aux | grep ssh
curl localhost:8080
kill <PID>