# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2025-02-16

# Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cross-Origin_Resource_Policy

read -r VALUE

# Header should be present
if [ "$VALUE" = "<NOTFOUND>" ]
then
    echo "Not found"
    exit 1
fi

# OK
case "$VALUE" in
    same-site|same-origin|cross-origin) exit 0 ;;
esac

# Invalid value
echo "Invalid value."
exit 1
