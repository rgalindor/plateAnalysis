#!perl -w
use Getopt::Long;
my %opts = ();
GetOptions(\%opts, 'i=s', 'o=s', 'h');
if(($opts{'h'})||(scalar(keys(%opts))==0)){
print <<HELP;
NAME
        conectador.pl

PARAMETTERS 

	-o output file name
	-i input file name
	-h displays this 
	
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
	
	$input=$opts{'i'};
	$output=$opts{'o'};
	open(FILE, $input)or die "chas\n";
	@file=<FILE>;
	close(FILE);
	$output=">".$output;
	open(OUT,$output);
	for($i=0;$i<scalar(@file);$i++){
		if($file[$i]=~/>/){
			@words=split(" ",$file[$i]);
			print OUT "$words[0]\n";
		}
	}
	close(OUT);
}
