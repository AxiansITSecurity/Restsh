# F5 usage examples

## Get all virtual servers

```sh
GET /mgmt/tm/ltm/virtual?\$select=fullPath
```

## Details of a virtual servers

```sh
GET /mgmt/tm/ltm/virtual/vs_test?expandSubcollections=true
```

## Attach a log profile to a list of virtual servers

```sh
cat > log-profile.json << EOL
{
 "securityLogProfiles": [
    "/Common/siem_all_requests"
  ]
}
EOL

while read -r VS
    do PATCH "/mgmt/tm/ltm/virtual/$VS" < log-profile.json
done < VIRTUAL_SERVERS.array
```

## Apply all policies that are modified

```sh
f5.asm.policy.list -r | JQ -r ".items[] | select(.isModified == true) | .fullPath" | XARGS f5.asm.policy.apply
```

## Apply ready signatures for all policies

```sh
f5.asm.signaturestaging enforceReady
```

## Export all policies as json

```sh
while read -r POLICY
do
    f5.asm.policy.export "$POLICY" "/tmp/${POLICY//\//_}.json"
done < <(f5.asm.policy.list -r | JQ -r ".items[].fullPath")
```
