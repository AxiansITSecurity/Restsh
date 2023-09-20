# F5 usage examples

## Apply all policies

```sh
f5.asm.policy.list -r | JQ -r ".items[].fullPath" | XARGS -n1 -P1 f5.asm.policy.apply
```

## Apply ready signatures for all policies

```sh
f5.asm.policy.list -r | JQ -r ".items[].fullPath" | XARGS f5.asm.signaturestaging enforceReady
```
## Export all policies as json

```sh
while read -r POLICY
do
    f5.asm.policy.export "$POLICY" "/tmp/${POLICY//\//_}.json"
done < <(f5.asm.policy.list -r | JQ -r ".items[].fullPath")
```
