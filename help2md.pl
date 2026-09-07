#!/usr/bin/perl
use strict;
use warnings;

my $text = '';
my $in_options = 0;
my $in_example = 0;

while (<STDIN>) {
    chomp;

    if (/^Usage:\s+(.*)$/) {
        $text .= "\n\n**Usage:**\n\n\`\`\`\n" . $1 . "\n\`\`\`\n\n";
        next;
    }
    if (/^Options:$/) {
        $text .= "\n\n**". $_ . "**\n\n| Option | Description |\n| ------ | ----------- |\n";
        $in_options = 1;
        next;
    }
    if ($in_options == 1) {
        if (/^    (.+?)\s\s+(.*)\s*$/) {
            $text .= "| ```". $1 . "``` | ". $2 . " |\n";
            next;
        }
        else {
            $in_options = 0;
            $text .= "\n";
        }
    }
    if (/^Example:$/) {
        $text .= "\n\n**". $_ . "**\n\n```\n";
        $in_example = 1;
        next;
    }
    if (/^Example \w+ file:$/) {
        $text .= "\n\n**". $_ . "**\n\n```\n";
        $in_example = 1;
        next;
    }
    if ($in_example == 1) {
        if (/^    (.+)$/) {
            $text .= $1. " \n";
            next;
        }
        else {
            $in_example = 0;
            $text .= "```\n\n";
        }
    }
    if (/^\s*$/) {
        $text .= "\n";
        next;
    }
    if (/^.*:$/) {
        $text .= "**" . $_ . "**\n\n";
        next;
    }
    if (/^\s+-\s+(.*)$/) {
        $text.= "- " . $1 ."\n";
        next;
    }
    if (/^\|.*\|$/) {
        $text .= $_ . "\n";
        next;
    }

    s/^\s+/&nbsp;&nbsp;&nbsp;&nbsp;/;
    s/https:\/\/\S+/[$&]($&)/g;
    s/</&lt;/g;
    s/>/&gt;/g;
    s/\[0;33m//g;
    s/\[0m//g;
    $text .= $_ . "<br/>\n";
}

# Cleanup
$text =~ s/``` ```//g;
$text =~ s/\s+\|\n\|\s+\|\s+(.*?)\s+\|\n/ $1 |\n/gm;
$text =~ s/\n\n\n+/\n\n/g;
$text =~ s/<br\/>\n\n/\n\n/gm;

print $text;
