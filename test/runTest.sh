#!/bin/bash

mkdir ./fastq

srrList=(SRR16828016 SRR16828015 SRR16828014 SRR16828013)

for srr in "${srrList[@]}"; do			
	echo Downloading $srr...
	fasterq-dump -p $srr -O ./fastq
	mv fastq/${srr}_1.fastq fastq/${srr}_R1.fastq
	mv fastq/${srr}_2.fastq fastq/${srr}_R2.fastq
done

echo Compressing downloaded input files...
gzip -v ./fastq/*.fastq


../startWorkflow.nf --platform i --in ./fastq --out ./ 


echo "All done, hopefully well done."
echo Please compare the contents of the analysisResults folder that was generated on your system \
		with the expectedResults folder that was generated by CFSAN.