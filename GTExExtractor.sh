#!/bin/bash

#download GTEx Analysis V6p release, de-identified, open access version of the sample annotations, available in dbGaP.	
wget https://www.dropbox.com/s/23c3zs9igediuy1/GTEx_Data_V6_Annotations_SampleAttributesDS.txt

#grep your tissue of interest, need exact tissue name from the GTEx file
grep $1 GTEx_Data_V6_Annotations_SampleAttributesDS.txt | cut -f1 > sample_IDs
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

while 
IFS= read -r line 
do ./extractor.sh $line RHOXF1.header
done < "$input" | awk 'NR%2==0' 
