#! perl
@tamano=();
for($i=0;$i<scalar(@ARGV);$i++){
	open(AVER,$ARGV[$i]);
		@fil=<AVER>;
	close(AVER);
	push(@tamano,scalar(@fil));
}
$max=$tamano[0];
$bandera=0;
for($i=1;$i<scalar(@tamano);$i++){
	if($tamano[i]>$ant){
		$max=$tamano[$i];
		print"tamano mas grande: $ARGV[$i]\n";
		$bandera=1;
	}elsif($tamano[i]<$ant){
		$bandera=1;
	}
}
if($bandera=1){
	print"maximo=$max\n";
	for($i=0;$i<scalar(@ARGV);$i++){
		open(AVER,$ARGV[$i]);
			@fil=<AVER>;
		close(AVER);
		if(scalar(@fil)<$max){
			$nombre=">>".$ARGV[$i];
			open(OUT, $nombre);
			for($j=scalar(@fil);$j<$max;$j++){
				print OUT $fil[scalar(@fil)-1];
			}
			close(OUT);
		}
	}	
}
