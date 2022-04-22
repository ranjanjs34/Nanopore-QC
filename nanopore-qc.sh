#! /usr/bin/bash
echo "Ranjan Jyoti Sarma"
echo "Department of Biotechnology, Mizoram University"
echo "Input directory to FASTQ files:"
read input
for dir in $input/*/
do
	dir=${dir%/}
	mkdir -p $HOME/Desktop/nano_covid_out/${input##*/}_out/${dir##*/}_NanoporeQC
	fastqc $input/${dir##*/}/*.fastq.gz -o $HOME/Desktop/nano_covid_out/${input##*/}_out/
	nanoQC $input/${dir##*/}/*.fastq.gz -o $HOME/Desktop/nano_covid_out/${input##*/}_out/${dir##*/}_NanoporeQC/
	weasyprint $HOME/Desktop/nano_covid_out/${input##*/}_out/*fastqc.html $HOME/Desktop/nano_covid_out/${input##*/}_out/${dir##*/}_NanoporeQC/${dir##*/}.pdf
	rm $HOME/Desktop/nano_covid_out/${input##*/}_out/*.html
	rm $HOME/Desktop/nano_covid_out/${input##*/}_out/*.zip
	NanoStat  -o $HOME/Desktop/nano_covid_out/${input##*/}_out/${dir##*/}_NanoporeQC/ -n ${dir##*/}.NanoStat_report.csv --tsv --fastq $input/${dir##*/}/*.fastq.gz
	
done
exit
