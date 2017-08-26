#!/bin/bash

FILE="./GTEx_Analysis_v6p_RNA-seq_RNA-SeQCv1.1.8_gene_rpkm.gct"
FILE2="./GTEx_Data_V6_Annotations_SampleAttributesDS.txt"
GENES="./genes.txt"

#check if GTEx file exists, if not, download 

if [ ! -f $FILE ]
then
wget https://www.dropbox.com/s/c47ywdnnbge0y4j/GTEx_Analysis_v6p_RNA-seq_RNA-SeQCv1.1.8_gene_rpkm.gct.gz
gunzip GTEx_Analysis_v6p_RNA-seq_RNA-SeQCv1.1.8_gene_rpkm.gct.gz
fi

#check if the Sample Attribution file exists if not
#download GTEx Analysis V6p release, de-identified, open access version of the sample annotations, available in dbGaP.	

if [ ! -f $FILE2 ]
then
wget https://www.dropbox.com/s/23c3zs9igediuy1/GTEx_Data_V6_Annotations_SampleAttributesDS.txt
fi


#grep your tissue of interest, need exact tissue name from the GTEx file
par=$1 #pass the first argument to a variable so that it can be used in grep with double quotes, in order to use spaced argument 
grep "$par" GTEx_Data_V6_Annotations_SampleAttributesDS.txt | cut -f1 > sample_IDs

input="./sample_IDs"

#write an extraction script
echo "
awk -v COLT=\$1 '
        NR==1 {
                for (i=1; i<=NF; i++) {
                        if (\$i==COLT) {
                                title=i;
                                print \$i;
                        }
                }
        }
        NR>1 {
                if (i=title) {
                        print \$i;
                }
        }
' \$2
" > extractor.sh
chmod 755 extractor.sh

#create header
cat GTEx_Analysis_v6p_RNA-seq_RNA-SeQCv1.1.8_gene_rpkm.gct | head -n3 | tail -n1 > header

#exctract data for each gene in genes.txt from the GTEx_Analysis_v6p_RNA-seq_RNA-SeQCv1.1.8_gene_rpkm.gct (all GTEX individuals) 
while
IFS= read -r line
do 
grep $line GTEx_Analysis_v6p_RNA-seq_RNA-SeQCv1.1.8_gene_rpkm.gct > $line.gene.rpkm.txt
cat header $line.gene.rpkm.txt > $line.gene.rpkm.header.txt
done < "$GENES"

#list the file names created in previous step to a file
ls -1 *gene.rpkm.header.txt > gene.file.names.txt
input2="./gene.file.names.txt"

#
while 
IFS= read -r line 
do 
	echo $line >$line.output

        while 
        IFS= read -r samples
        
        do
        ./extractor.sh $samples $line | awk 'NR%2==0'
        done < "$input" >> $line.output
        
done < "$input2"

paste *output > results.txt
