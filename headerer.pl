#! perl

for($i=0;$i<scalar(@ARGV);$i++){
	@nombre=split('\.',$ARGV[$i]);
	open(AVER,$ARGV[$i]);
		@fil=<AVER>;
	close(AVER);
	@tmp=split('\t',$fil[0]);
	$limpio='>'.$nombre[0].'headed.txt';
	open(OUT, $limpio);
	for($j=1;$j<scalar(@tmp);$j++){
		$head=$nombre[0].'pozo'.$j;
		print OUT $head;
#		print $head;
		if($j<scalar(@tmp)-1){
			print OUT "\t";
		}else{
			print OUT "\t\n";
		}
	}
	for($j=0;$j<scalar(@fil);$j++){
		print OUT $fil[$j];
	}
	close(OUT);
}


