$arguments = $ARGV[0];
open (FILE, $arguments);
while (<FILE>)
{
    chomp;
    my $line = $_;
    my ($ts,$saddr,$daddr,$sport,$dport,$fid, $mtd,$resp,$host,$uac,$url,$cookie,$req_len,$req_type,$res_len,$res_type,$res_cencode,$res_tencode,$req_txt,$res_txt) =
        $line =~ m/TS:(.*),SADDR:(.*),DADDR:(.*),SPORT:(.*),DPORT:(.*),FID:(.*),MTD:(.*),RESP:(.*),HOST:(.*),UAC:(.*),URL:(.*),COOKIE:(.*),REQ_LEN:(.*),REQ_TYPE:(.*),RES_LEN:(.*),RES_TYPE:(.*),RES_CENCODE:(.*),RES_TENCODE:(.*),REQ_TXT:(.*),RES_TXT:(.*)/;
	
	if(defined $ts)
    {
    	#kaskus
		if (($host eq "www.kaskus.us") || ($host eq "livebeta.kaskus.us"))
		{
				
				#username
				if($url =~ m/\/login\.php\?do=login/){
					my ($username) = $req_txt =~ m/vb_login_username=(.*)&vb_login_password/;	
					print "username : $username \n";
				}

				#Search Key
				if($url =~ m/\/search\?f=&q/){
					my ($search_key) = $url =~ m/\/search\?f=&q=(.*)&searchchoice/;
					$search_key =~ s/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/seg;
					$search_key =~ tr { \+} { }s;
					print "Search Key : $search_key \n";

				}

				#Replay
				if($url =~ m/\/post_reply/){
				my ($replay) = $req_txt =~ m/&message=(.*)&ajaxhref/;
				$replay =~ s/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/seg;
				$replay =~ tr {\+} { }s;
				print "Replay : $replay \n";
				}


				#Profile
				if($url =~ m/\/members/){
				my ($name) = $url =~ m/\/members\/(.*)\.html/;
				print "Nama : $name \n";
				}

			}

			#forum.kompas

			if ($host eq "forum.kompas.com")
			{
				
				#username
				if($url =~ m/\/login\.php\?do=login/){
					my ($username) = $req_txt =~ m/vb_login_username=(\S+)&vb_login_password/;	
					print "username : $username \n";
				}

				#Search Key
				if($url =~ m/\/search\.php\?do=process/){
					my ($search_key) = $req_txt =~ m/&query=(\S+)/;
					print "Search Key : $search_key \n";

				}

				#Replay
				if($url =~ m/\/newreply\.php\?do=postreply/){
				my ($replay) = $req_txt =~ m/message=(\S+)&sbutton/;
				$topik = $req_txt =~ m/title=(\S+)+Forum&/;
				$topik =~ s/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/seg;
            	$topik =~ tr { \+} { }s;
            	

					$replay =~ s/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/seg;
            		$replay =~ tr { \+} { }s;
            		

				print "Topik : $topik \n";
				print "Replay : $replay \n";
				}


				#Profile
				if($url =~ m/\/members/){
				my ($name) = $url =~ m/\/members\/(.*)\.html/;
				print "Nama : $name \n";
				}

			}

			# detk.com

			if ($host eq "m.forum.detik.com")
		{
	
				if($url =~ m/\/authenticate\.php/){
					my ($username) = $req_txt =~ m/vb_login_username=(\S+)&vb_login_password/;	
					print "username : $username \n";
				}

				if($url =~ m/\/search_results\.php/){
					my ($search_key) = $req_txt =~ m/searchtext=(\S+)&/;
					$search_key =~ tr { \+} { }s;
					print "Search Key : $search_key \n";

				}

				if($url =~ m/\/newreply\.php/){
					my ($replay) = $req_txt =~ m/message=(\S+?&)/;
					$replay =~ s/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/seg;
            		$replay =~ tr { \+} { }s;
					print "Replay : $replay \n";

				}

				if($url =~ m/\/__utm\.gif/){
					my ($topik) = $url =~ m/&utmdt=(\S+?&)/;
					$topik =~ s/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/seg;
            		#$topik =~ tr { \+} { }s;
            		chop($topik);
					print "Topik : $topik \n";

				}

				
		}	

}
}
close (FILE);
exit;
