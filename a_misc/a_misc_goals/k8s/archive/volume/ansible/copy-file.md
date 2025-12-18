# copy a file

cd /home/brent/src/reports/volume/ansible/playbooks
ansible moto -m ansible.builtin.copy -a "src=./test.yml dest=/tmp/test.yaml"
