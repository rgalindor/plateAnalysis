#!perl -w
use Getopt::Long;
my %opts = ();
GetOptions(\%opts,'c=s', 'i=s', 'p=i', 'r=s', 'o=s', 'g=s', 'h');
if(($opts{'h'})||(scalar(keys(%opts))==0)){
print <<HELP;
NAME
        conectador.pl

PARAMETTERS 

	-c Colection file name.

	-i Grow analysis system output, a text file with x0D as line 
	   separator.(INPUT)

	-p Plate to analize.

	-r Plate row to start analysis.

	-h Display this.

	-o Output name.(OUTPUT)

	-g Graphic name(OUTPUT)

AUTHOR
        Roberto Galindo Ramirez
        LCG 4a Generacion
	Instituto de Fisiologia Celular
	Ciudad Universitaria UNAM

DESCRIPTION
        Takes the results from grow analysis system and obtains yeastgenome's 
        description 


EXAMPLE
  perl conectador.pl -c colecciona.txt -i Libro1.txt -p 1 -r A -o bambi.out -g nicer
 
	
        
FORMAT 
        Output plots.pdf with the graphical view of grow.


HELP
}
else{
	$file_coleccion=$opts{'c'};
	$file_creci=$opts{'i'};
	$plate=$opts{'p'};
	$row=$opts{'r'};
	if($opts{'g'}){
		$graphic=$opts{'g'};
	}
	else{
		$graphic=substr($file_creci,0,length($file_creci)-4);
	}
	if($opts{'o'}){
		$output=$opts{'o'};
	}
	else{
		$output=substr($file_creci,0,length($file_creci)-3)."out";
	}
	open(CAT,$file_coleccion)or die"NO ABRI EL ARCHIVO $file_coleccion\n";
	open(MODI,">modifi.txt");
	@cat=<CAT>;
	close(CAT);
	foreach $duh(@cat){
	@espli=split("\\x0D",$duh);
		foreach $linea_verdadera(@espli){
			print MODI "$linea_verdadera\n";	
		}
	}
	close(MODI);
	open(TABLA, $file_creci) or die "\nNo se pudo abrir $file_creci\n";
	@arreglo=<TABLA>;
	close(TABLA);
	open(GROWTH, ">crecinometro.txt");
	foreach $duh(@arreglo){
		@espli=split("\\x0D",$duh);
		foreach $linea_verdadera(@espli){
			print GROWTH "$linea_verdadera\n";
		}
	}
	close(GROWTH);
	open(NIU,"crecinometro.txt")or die "\nNo se creo bien el archivo crecinometro.txt\n";
	@arre=<NIU>;
	close(NIU);
	$k=0;
	@linea=split("\t",$arre[0]);
	@inicio=split("\t",$arre[1]);
	@final=split("\t",$arre[scalar(@arre)-1]);
	print"\tPLATE\tROW\tCOL\tDO final\tORF\n";
	for($i=1;$i<scalar(@final);$i++){
		if($final[$i]>=$inicio[$i]+0.5){
			$los_buenos[$k]=$linea[$i];
			$slot{"$los_buenos[$k]"}="$final[$i]";
			$k+=1;
		}
	}
	open(COLE,"modifi.txt")or die"No se pudo abrir el archivo de la coleccion\n";
	@coleccion=<COLE>;
	close(COLE);
	$j=0;
	for($i=1;$i<scalar(@coleccion);$i++){
		@mutante=split("\t",$coleccion[$i]);
		if($mutante[4]==$plate){
			foreach $sl(sort keys %slot){
				$comun=$sl;
				for($h=0;$h<10;$h++){
					$paridad=$h%2;
					$patron="Well 1".$h;
					if($paridad==0){
						$cambio="\t-\t".$h."\t";
					}
					else{
						$cambio="\t-\t".$h."\t+";
					}
					if(($row eq "A")||($row eq "B")||($row eq "C")||($row eq "D")){
						$cambio=~tr/0123456789/AABBCCDDZZ/;
					}
					elsif(($row eq "E")||($row eq "F")||($row eq "G")||($row eq "H")){
						$cambio=~tr/0123456789/EEFFGGHHZZ/;
					}
					$cambio=~tr/+/1/;
					$cambio=~s/-/$plate/;
					if($comun=~/$patron/){
						$comun=~s/$patron/$cambio/;
						@verificador=split("\t",$comun);						
					}
				}
				if(($coleccion[$i]=~/$comun/)&&($mutante[6]==$verificador[3])){
					print"$comun\t$slot{$sl}\t\t$mutante[1]\n";
					$orfs[$j]=$mutante[1];
					$j+=1;
				}
			}
		}
	}
	for($i=1;$i<scalar(@arre);$i++){
		for($f=0;$f<scalar(@linea);$f++){
			if($linea[$f]=~/185/){
				@ayuda=split("\t",$arre[$i]);
				$wt[$i-1]=$ayuda[$f];
			}
		}	
	}
	$l=0;
	for($j=1;$j<scalar(@linea);$j++){
		foreach$p(sort keys %slot){
			if($p eq $linea[$j]){
				for($i=0;$i<scalar(@arre);$i++){
					@help=split("\t",$arre[$i]);
					$datos[$l][$i]=$help[$j];
				}
				$l+=1;
			}
		}
	}
	open(WT,">wild.txt");
	foreach$f(@wt){
		print WT $f;
		print WT "\n";
	}
	close(WT);
	open(DATOS,">datos.txt");
	for($q=0;$q<scalar(@orfs);$q++){			
		if($q==0){
			print DATOS $orfs[$q];
		}
		else{
			print DATOS "\t$orfs[$q]";
		}
	}
	print DATOS "\n";
	for($p=1;$p<$i;$p++){
		for($q=0;$q<scalar(@orfs);$q++){
			print DATOS $datos[$q][$p];
			if($q<$l){
				print DATOS "\t";
			}
		}
		print DATOS "\n";
	}
	close(DATOS);
	for($i=0;$i<scalar(@orfs);$i++){
		$query="http://www.yeastgenome.org/cgi-bin/locus.fpl?locus=".$orfs[$i];
		$sis='wget '.$query.' -O d'.$i.'.html';
		system($sis);
	}
	$R='R --save --args datos.txt wild.txt '.$graphic.' < "graficante.R"';
	system($R);
	$output=">".$output;
	open(OUT, $output);
	print OUT "Description file of input: $file_creci with colection: $file_coleccion at plate number $plate,and row $row\n\n";
	for($i=0;$i<scalar(@orfs);$i++){
		$nom='d'.$i.'.html';
		open(HTML, $nom) or die "No se abrio el $nom\n";
		@html=<HTML>;
		close(HTML);
		for($j=0;$j<scalar(@html);$j++){
			if($html[$j]=~/<th>Description<\/th>  <td>/){
				@parser=split("<tr><th>Standard Name<\/th>  <td> <span class=\'i\'>",$html[$j]);
				@parser0=split("<",$parser[1]);
				@parser1=split("<th>Description<\/th>  <td>",$html[$j]);
				@parser2=split("<",$parser1[1]);
				print OUT "$orfs[$i] ($parser0[0]) > $parser2[0]\n";			
			}
		}
	}
	close(OUT);
	system('rm modifi.txt');
	system('rm datos.txt');
	system('rm wild.txt');
	system('rm crecinometro.txt');
	system('rm *.html');
}

