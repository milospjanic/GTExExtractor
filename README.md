# GTExExtractor

As GTEx currently can only show the box plot distribution for a single gene across tissues, I have generated a script to show the distribution of expression of multiple genes in a single tissue in a form of more informative and visually more attractive violin plot. 

GTEXExtractor is a combined bash/R script to extract individual level data from the GTEx database, and plot a RPKM distribution for the genes of interest in a form of a violin plot. GTExExtractor will download individual level data for all GTEx tissues stored in a file GTEx_Analysis_v6p_RNA-seq_RNA-SeQCv1.1.8_gene_rpkm.gct, in case the file is not present in the working directory. In case the file is present the script will continue. The script will read gene names from the genes.txt file provided and extract the RPKM values from all GTEx samples for the provided genes of interest. Values for each gene will be stored in separate files. Next, sample IDs for the tissue of interest have to be determined. To do that GTExExtractor will check for the file GTEx_Data_V6_Annotations_SampleAttributesDS.txt,that contains sample IDs for each GTEx tissue and download it if not already present. The script will extract the sample IDs from the file GTEx_Data_V6_Annotations_SampleAttributesDS.txt for the tissue of interest that was provided as the first argument when running the script. Then, these sample IDs will be used to match the IDs from the individual gene files with RPKM values generated in the previous step, producing tissues specific expression data for each gene. The files are then combined into a table. The table is the imported into R with Rscript and plotted as a visually representative violin plot.



# Example of usage

Content of the genes.txt

<pre>
SMAD3
FOXO1
NFIX
TCF21
TCF12
</pre>

To run the script 

<pre>
wget https://raw.githubusercontent.com/milospjanic/GTExExtractor/master/GTExExtractor.sh
chmod 755 GTExExtractor.sh
./GTExExtractor.sh 'Artery - Coronary'
</pre>

Check the output pdf file:

![alt text](https://github.com/milospjanic/GTExExtractor/blob/master/output_gtexex.21.png)

If you have more genes in the input file the script will automatically widen the graph

![alt text](https://github.com/milospjanic/GTExExtractor/blob/master/output_gtexex.18.png)

For example, if we run the script for one highly expressed gene like GAPDH and all low expressed TFs the output will look narrower:

![alt text](https://github.com/milospjanic/GTExExtractor/blob/master/output_gtexex.19.png)

# Biological application

For example the script can show which isoform is more dominant and thus probably more functional in different tissues.

I took as an example here the NFI group of transcription factors that consist of NFIA, NFIB, NFIC, NFIX genes.

To check the expression level in arteries I ran the script for 'Artery - Coronary' and 'Artery - Tibial' GTEX tissues and got the following output where NFIX is the most dominant form.

![alt text](https://github.com/milospjanic/GTExExtractor/blob/master/output_gtexex.15.png)

![alt text](https://github.com/milospjanic/GTExExtractor/blob/master/output_gtexex.16.png)

To check the output in a diferent tissue I ran the script for 'Skeletal Muscle' where NFIC is the most dominant form:

![alt text](https://github.com/milospjanic/GTExExtractor/blob/master/output_gtexex.17.png)

And in 'Breast - Mammary Tissue' the NFIB variant becomes expressed at higher levels. 

![alt text](https://github.com/milospjanic/GTExExtractor/blob/master/output_gtexex.24.png)

This example shows how to quickly check for the differences within the class of genes.

Similarly, you can emphasize those cases where the gene in certain tissue(s) has a known function from the literature and also has higher expression, like in the case of TCF21 gene that is involved in various physiological and pathophysiological procceses in lung.

![alt text](https://github.com/milospjanic/GTExExtractor/blob/master/output_gtexex.22.png)
