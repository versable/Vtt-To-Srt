#!/usr/bin/perl

use warnings;
use strict;

my $input = $ARGV[0];

# Check the input
die "Usage sample: $0 example.vtt > example.srt\n" unless $input;
die "File \`$input\` does not exist\n" unless -e $input;

# Open the input file
open( my $fh, "<", $input )
    or die "Can't open < $input: $!\n";

for ( my $item = 0, my $line; $line = <$fh>; )
{
    # Ignore first line if it has WEBVTT declaration
    next if $item == 0 && $line =~ /^WEBVTT$/;

    # Expand time string if it is too short
    $line =~ s/(^|\s)(\d+)\:(\d+)\./${1}00:$2:$3\./g;

    # Print and iterate item number if regex time string replacement succeeds
    print ++$item . "\n"
        if $line =~ s/(\d+)\:(\d+)\:(\d+)\.(\d+)/$1:$2:$3,$4/g;
    print $line;
}
