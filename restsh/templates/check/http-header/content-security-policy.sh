# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2025-02-16

# Reference: https://developer.mozilla.org/en-US/docs/Web/Security/Practical_implementation_guides/CSP

read -r VALUE

# Header should be present
if [ "$VALUE" = "<NOTFOUND>" ]
then
    echo "Not found"
    exit 1
fi

# Unsafe config
if [[ "$VALUE" =~ "unsafe" ]]
then
    echo "Usage of unsafe keyword found."
    exit 1
fi

# OK
exit 0
