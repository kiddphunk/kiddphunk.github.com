#!/usr/bin/perl
undef $/;

$rotator   =  0;
$rotcode   = '';
$lastdir   = '';
$lastdir2  = '';
$lastdate  = '';
$lastdate2 = '';
$lastentry = '';
$fullfile  = '';
@alldata   = split(/\n/, `ls -1 entries | sort -r`);
@alldirs;

printFile("static/top.html");
printFile("static/rowtop.html");


for ($i=0, $first=1; $i<@alldata; $i++) {
	if ($alldata[$i] =~ /master/) {} else {	
		$last = ($i==(@alldata-1)) ? 1 : 0;
		$lastentry .= generateEntry($alldata[$i], $first, $last);
		$first = 0;
	}
}

$newrot    = getRotatorStart() . $rotcode . getRotatorEnd();
$fullfile  =~ s/_INITROTATOR/$newrot/;

$ld2       = $lastdir . "2";
$caption   = "chapter head";

$lastentry =~ s/_NEXTDAY/$lastdate2/g;
$lastentry =~ s/_PREVDAY/$caption/g;
$lastentry =~ s/$ld2/endbox/;
$lastentry =~ s/$ld2/crazywhackfunky/;
$lastentry =~ s/crazywhackfunky/$ld2/;

$fullfile .= $lastentry;

printFile("static/bottom.html");
printBottom();

print $fullfile;

sub generateEntry() {
  $dir   = shift;
  $first = shift;
#  $last  = shift;
  $last  = 0;
  $nav   = '';
  $nav1  = getData("static/nav_meta.html");
  $nav2  = getData("static/nav_nometa.html");
  $ent1  = getData("static/entry_meta_bottom.html");
  $ent2  = getData("static/entry_nometa_bottom.html");
  $entry = getData("static/entry.html");
  $data  = getData("entries/$dir/data");
  $meta  = getData("entries/$dir/meta");
  @data  = split(/\n/, $data);
  $date  = shift(@data);
  $title = shift(@data);
  $data  = join("\n", @data);

  $rotcode .= getRotator("$dir");
  $comment1  = "<!--";
  $comment2  = "-->";  

  if (length($meta)) {
	$nav = $nav1;
  } else {
	$nav = $nav2;
  }

  if ($first) {
    $nav =~ s/_PRELEFT/$comment1/g;
    $nav =~ s/_POSTLEFT/$comment2/g;
    $nav =~ s/_PRERIGHT1//g;
    $nav =~ s/_POSTRIGHT1//g;
    $nav =~ s/_PRERIGHT2/$comment1/g;
    $nav =~ s/_POSTRIGHT2/$comment2/g;
  } elsif ($last) {
    $nav =~ s/_PRELEFT//g;
    $nav =~ s/_POSTLEFT//g;
    $nav =~ s/_PRERIGHT1/$comment1/g;
    $nav =~ s/_POSTRIGHT1/$comment2/g;
    $nav =~ s/_PRERIGHT2//g;
    $nav =~ s/_POSTRIGHT2//g;
  } else {
    $nav =~ s/_PRELEFT//g;
    $nav =~ s/_POSTLEFT//g;
    $nav =~ s/_PRERIGHT1//g;
    $nav =~ s/_POSTRIGHT1//g;
    $nav =~ s/_PRERIGHT2/$comment1/g;
    $nav =~ s/_POSTRIGHT2/$comment2/g;
  }

  if (length($meta)) {
	$entry =~ s/_NAV/$nav/g;
  } else {
	$entry =~ s/_NAV/$nav/g;
  }

  $lastentry =~ s/_NEXTDAY/$lastdate2/g;
  $lastentry =~ s/_PREVDAY/$date/g;

  $navdir = $lastdir2;
  if ($navdir) {
  	$navdir .= "2";
  } else {
  	$navdir = "rowtop";
  }

# $entry =~ s/_NEXTDAY/next day/g;
# $entry =~ s/_PREVDAY/previous day/g;  
  $entry =~ s/_NEXTDIR/$navdir/g;
  $entry =~ s/_DIR/$dir/g;
  $entry =~ s/_DATE/$date/g;
  $entry =~ s/_DATA/$data/g;
  $entry =~ s/_TITLE/$title/g;
  $ent1  =~ s/_DIR/$dir/g;
  $ent1  =~ s/_DATE/$date/g;
  $ent1  =~ s/_TITLE/$title/g;
  $ent2  =~ s/_DIR/$dir/g;
  $ent2  =~ s/_DATE/$date/g;
  $ent2  =~ s/_TITLE/$title/g;

  if (length($meta)) {
  	$ent1 =~ s/_META/$meta/g;
  	$entry .= $ent1;
  } else {
  	$entry .= $ent2;
  }
  
  $lastdate2 = $lastdate;
  $lastdate  = $date;
  $lastdir2  = $lastdir;
  $lastdir   = $dir;
    
  push(@alldirs, "img$dir");
  return $entry;
}


sub getData() {
	$file = shift;
	return '' unless (-e $file);
	my $filedata = '';
	open(F, $file);
	$filedata = <F>;
	close(F);
	return $filedata;	
}


sub printFile() {
	$file = shift;
	open(F, $file);
	while (<F>) {
	  $fullfile .= "$_";
	}
	close(F);
}


sub printBottom() {
	$fullfile .= "<script type=\"text/javascript\">\n";
	$fullfile .= "<!--\n";
	$fullfile .= "//SET_DHTML(";
	$first = 1;
	map {
		if ($first) {
			$first = 0;
		} else {
			$fullfile .= ",";
		}
	    $fullfile .= "\"$_\"";
	} @alldirs;	
	$fullfile .= ");";
	$fullfile .= "\n //-->\n";
	$fullfile .= "\n </script></body>";
	$fullfile .= "</html>";
}

sub getRotatorStart() { return "function initRotator() {\n"; }
sub getRotatorEnd()   { return "dw_Rotator.start();\n}\n"; }

sub getRotator() {
    $value = "";
	$dirname = shift;

    @imagenames = split(/\n/, `ls -1 entries/$dirname/$dirname*.jpg`);
    if (@imagenames > 1) {
      $value .= "    var rotator".++$rotator." = new dw_Rotator('img$dirname', 24000);\n";
	  $value .= "    rotator$rotator.addImages(";
	  $first = 1;
  	  map {
	    if ($first) {
	      $first = 0;
	    } else {
	      $value .= ",";
	    }
        $value .= "'$_'";
	  } @imagenames;
      $value .= ");\n\n";
    }
	return $value;
}

