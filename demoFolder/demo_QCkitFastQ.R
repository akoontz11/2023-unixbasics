# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# %%% LINUX TRAINING DEMO: QKITFASTQ %%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# This script demonstrates the qckitfastq R package, which is capable of analyzing zipped 
# FASTQ files. The script is utilized in the Hoban Lab Linux Training exercise.
# It is based off of the R script below:
# https://www.bioconductor.org/packages/release/bioc/vignettes/qckitfastq/inst/doc/vignette-qckitfastq.R

# Load relevant libraries
library(qckitfastq)
library(knitr)
library(kableExtra)

# Specify the filepath to the zipped fastq files we downloaded using wget
R1_infile <- 
  "~/Documents/LinuxServer/LabLinuxTraining/DemoFolder/demoFolder/data_backup/ATGCCGCT-CTCCTTAC_S152_L002_R1_001.fastq.gz"
R2_infile <- 
  "~/Documents/LinuxServer/LabLinuxTraining/DemoFolder/demoFolder/data_backup/ATGCCGCT-CTCCTTAC_S152_L002_R2_001.fastq.gz"
# Generate a fastqq object, which summarizes of zipped fastq files
R1_seq <- seqTools::fastqq(R1_infile)
print(R1_seq)
R2_seq <- seqTools::fastqq(R2_infile)
print(R2_seq)

# Report and plot the average read length, of this FASTQ file----
# Forward read
read_len <- read_length(R1_seq)
kable(head(read_len)) %>% kable_styling()
plot_read_length(read_len)
# Reverse read
read_len <- read_length(R2_seq)
kable(head(read_len)) %>% kable_styling()
plot_read_length(read_len)

# Report and plot the relative base content of this FASTQ file----
# Forward read
scA <- read_base_content(R1_seq, content = "A")
kable(head(scA)) %>% kable_styling()
rc <- read_content(R1_seq)
kable(head(rc)) %>% kable_styling()
plot_read_content(rc)
# Reverse read
scA <- read_base_content(R2_seq, content = "A")
kable(head(scA)) %>% kable_styling()
rc <- read_content(R2_seq)
kable(head(rc)) %>% kable_styling()
plot_read_content(rc)
