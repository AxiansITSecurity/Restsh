# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2025-02-16

# Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection

read -r VALUE

# Header should not be present
if [ "$VALUE" = "<NOTFOUND>" ]
then
    echo "Not found"
    exit 0
fi

if [ "$VALUE" = "0" ]
then
    echo "Disabled"
    exit 0
fi

# Invalid value
echo "Use a Content Security Policy (CSP) that disables the use of inline JavaScript."
exit 1
