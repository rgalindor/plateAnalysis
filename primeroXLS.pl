#!perl

use Spreadsheet::Read;

$xls= ReadData($ARGV[0]);
#for($i=0;$i<scalar(@ARGV);$i++){
#	print"abriendo archivo: $ARGV[$i]\n";
#	$xls = ReadData($ARGV[$i]);
	print $xls->[1]{'B25'};
	$var="\x41";
	print"\n$var\n";
#}
