#!perl

use Spreadsheet::Read;

for($i=0;$i<scalar(@ARGV);$i++){
	print"abriendo archivo: $ARGV[$i]\n";
	$xls = ReadData($ARGV[$i]);
	print $xls->[1]{'A1'}
}
