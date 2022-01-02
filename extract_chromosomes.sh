#!/bin/bash

mkdir /home/kate/Documents/mnm/split_chr

bcftools reheader /home/kate/Documents/mnm/CPCT02220079.annotated.processed.vcf.gz -h /home/kate/Documents/mnm/hdr.txt  -o /home/kate/Documents/mnm/CPCT02220079.annotated.processed_reheader.vcf.gz

chr_names="/home/kate/Documents/mnm/chromosome_names.txt"
vcf="/home/kate/Documents/mnm/CPCT02220079.annotated.processed_reheader.vcf.gz"

while IFS= read -r chr
do
    out="/home/kate/Documents/mnm/split_chr/CPCT02220079.annotated.processed_reheader_chr${chr}"
    bcftools view ${vcf} --regions ${chr} > ${out}.vcf
    bgzip -c ${out}.vcf > ${out}.vcf.gz
    rm ${out}.vcf
    bcftools sort ${out}.vcf.gz > ${out}_sorted.vcf
    bgzip -c ${out}_sorted.vcf > ${out}_sorted.vcf.gz
    rm ${out}_sorted.vcf
done < ${chr_names}
