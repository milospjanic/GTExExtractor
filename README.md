# GTExExtractor

As GTEx currently can only show the box plot distribution for a single gene accross tissues, I have generated a script to show the distribution of expression of multiple genes in a single tissue in a form of more informative and vissualy more attractive violin plot. 

GTEXExtractor is a combined bash/R script to extract individual level data from the GTEx database, and plot a RPKM distribution for the genes of interest in a form of a violin plot. GTExExtractor will download individual level data for all GTEx tissues stored in a file GTEx_Analysis_v6p_RNA-seq_RNA-SeQCv1.1.8_gene_rpkm.gct, in case the file is not present in the working directory. In case the file is present the script will continue. The script will read gene names from the genes.txt file provided and extract the RPKM values from all GTEx samples for the provided genes of interest. Values for each gene will be stored in separate files. Next, sample IDs for the tissue of interest have to be determined. To do that GTExExtractor will check for the file GTEx_Data_V6_Annotations_SampleAttributesDS.txt,that contains sample IDs for each GTEx tissue and download it if not already present. The script will extract the sample IDs from the file GTEx_Data_V6_Annotations_SampleAttributesDS.txt for the tissue of interest that was provided as the first argument when running the script. Then, these sample IDs will be used to match the IDs from the individual gene files with RPKM values generated in the previous step, producing tissues specific expression data for each gene. The files are then combined into a table. The table is the imported into R with Rscript and plotted as a vissually representative violin plot.


# Example of usage

Content of the genes.txt

<pre>
SMAD3
FOXO1
FOX03
NFIX
TCF21
</pre>

To run the script 

wget 
chmod 755 GTExExtractor.sh
GTExExtractor.sh 'Artery - Coronary'

Check the output pdf file

If you have more genes in the input file the script will automatically widen the graph

For example if we run the script for all the genes in the group of transcription factor the output will look like:


# Example biological application

For example the script can show which isoform is more dominant and thus probably more functional in different tissues.

I took as the example here the NFI group of transcription factors that c2onsisnt of NFIA, NFIB, NFIC, NFIX genes

To check the expression level in coronary arterys I ran the script and got the following output
To check the output in a diferent tissue I ran the script:

This example shows that NFIX variant is more dominant in coronary arteries while
