# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2025-02-16

# Reference: https://developer.mozilla.org/en-US/docs/Web/Security/Practical_implementation_guides/Referrer_policy

read -r VALUE

# Header should be present
if [ "$VALUE" = "<NOTFOUND>" ]
then
    echo "Not found"
    exit 1
fi

# OK
case "$VALUE" in
    "strict-origin-when-cross-origin") exit 0 ;;
    "same-origin") exit 0 ;;
    "strict-origin") exit 0 ;;
    "no-referrer") exit 0 ;;
    "no-referrer, strict-origin-when-cross-origin") exit 0;;
esac

# Invalid value
echo "Should be at minimum \"strict-origin-when-cross-origin\""
exit 1
