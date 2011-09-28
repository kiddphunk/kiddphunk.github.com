#!/usr/bin/perl
undef $/; 

open(F, "entries/master");
$master = <F>;
close(F);

$current = "";
$data = "";

map {
  if (/<(\d+)>/) {
	$current = $1;
  } elsif (/<\/(\d+)>/) {
    open(F, ">entries/$current/data");
    print F $data;
    close(F);
  	$current = "";
  	$data = "";
  } else {
    if ($_) {
	  	$data .= "$_\n";
	}
  }
} split (/\n/, $master);
