# elk-podman

elk with podman and podman-compose, for RHEL8 based images.

## Manual Deployment

Install podman, python and git.

```sh
sudo dnf install -y podman python3.9 git
```

Install podman-compose for regular user.

```sh
python3 -m pip install --user podman-compose
```

Clone the repo and CD into it.

```sh
git clone https://github.com/aldenso/elk-podman && cd elk-podman
```

Create a Data directory for elastic and disable SELinux (yes... I know, but fuc** it, this is a lab).

Enable the followin ports for testing.

```sh
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --add-port=5601/tcp --permanent
sudo firewall-cmd --add-port=9200/tcp --permanent
sudo firewall-cmd --reload
```

Remember to enable the same ports in case you are testing in your cloud and not your local machine.

```sh
podman-compose up -d
```

Export the PUBLIC IP (your external cloud IP, assigned to your VM), in case you are using your local machine use 'localhost'.

```sh
export PUBLICIP=X.X.X.X
```

Create 2 indices.

```sh
curl -XPOST -D- "http://$PUBLICIP:5601/api/saved_objects/index-pattern" \
    -H 'Content-Type: application/json' \
    -H 'kbn-version: 7.9.2' \
    -u elastic:changeme \
    -d '{"attributes":{"title":"http-groupa-*","timeFieldName":"@timestamp"}}'
```

```sh
curl -XPOST -D- "http://$PUBLICIP:5601/api/saved_objects/index-pattern" \
    -H 'Content-Type: application/json' \
    -H 'kbn-version: 7.9.2' \
    -u elastic:changeme \
    -d '{"attributes":{"title":"http-groupb-*","timeFieldName":"@timestamp"}}'
```

Test your indices

```sh
curl -XPOST -H 'Content-Type: application/json' \
"http://$PUBLICIP:8080" -d '{"message":"hello"}'
```

Log to Kibana and check index management and discover logs.

http://$PUBLICIP:5601
