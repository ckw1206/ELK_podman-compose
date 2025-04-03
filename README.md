# elk-podman

elk with podman and podman-compose, for RHEL8 based images.

## Manual Deployment

Install podman, python and git.

```sh
sudo dnf install -y podman python3.9 git
```

Install podman-compose for regular user.

```sh
python3.9 -m pip install --user podman-compose
```

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
