curl -X POST "http://localhost:9200/_security/user/kibana_service" -u elastic \
  -H "Content-Type: application/json" \
  -d '{
    "password": "0fqWo1BQD$6uDVu5u3ftXv_H15jowxNKFdvufwqx@4KZ!wBhu5xow5o_jIcCFRQRpy3ShHCZTGi",
    "roles": ["kibana_system"]
  }'

