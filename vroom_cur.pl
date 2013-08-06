#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;
my $filename = $ARGV[0];
my $curnum = $ARGV[1];

if( !$filename ){
    print <<END_OF_HELP;
" ## VRoom current page viewer ##
" You can see current editing slide page on VRoom with typing <SS> in VIM.
" To activate this function, move $0 to your path.
" And append below one line to .vimrc file.

map SS :w<CR>\\|:execute "!vroom_cur.pl '".bufname("%")."' ".line(".")<CR><CR>
END_OF_HELP
    exit;
}

open my $file,'<',$filename;
my $num = 0;
my $skip = 0;
while(my $line = <$file>)
{
  $num++;
  
  $skip++ if $line =~ /^----/ && $line !~ /^---- config/;

  last if $num == $curnum;
}
$skip--;

close $file;

print "filename: $filename curnum: $curnum skip : $skip\n";
exec "vroom vroom --input='$filename' --skip=$skip";
