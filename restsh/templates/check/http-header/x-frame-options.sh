# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2025-02-16

# Reference: https://developer.mozilla.org/en-US/docs/Web/Security/Practical_implementation_guides/Clickjacking

read -r VALUE

# Header should not be present
if [ "$VALUE" = "<NOTFOUND>" ]
then
    echo "Not found"
    exit 0
fi

# Invalid value
echo "Implement frame-ancestors CSP instead."
exit 1
