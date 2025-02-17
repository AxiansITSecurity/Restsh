# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2025-02-16

# Reference: https://developer.mozilla.org/en-US/docs/Web/Security/Practical_implementation_guides/MIME_types

read -r VALUE

# Header should be present
if [ "$VALUE" = "<NOTFOUND>" ]
then
    echo "Not found"
    exit 1
fi

# OK
if [ "$VALUE" = "nosniff" ]
then
    exit 0
fi

# Invalid value
echo "Should be \"nosniff\""
exit 1
