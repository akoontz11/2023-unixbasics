# Hoban Lab Skills Exchange: Intro to Command Lines in Linux
### Friday, April 7th, 2023

This session provides a broad overview of the command line interface, with a focus on performing basic commands in Linux. It's dervied from [an exercise](https://github.com/renaschweizer/congen-2021-unixbasics) given by Dr. Rena Schweizer at the 2021 ConGen conference, and is also based on publicly available workshops from www.datacarpentry.org. If you already know how to do all of the actions listed below under "Goals", then feel free to skip this part of the training. If this is all new to you--welcome!

## Goals
By the end of this session, you should be familiar with the following: 
- Command lines, how to implement them, and why they're useful
- Navigating different directories on your system (`pwd`, `cd`, `ls`)
- Assessing and changing file permissions (`ls -l`, `chmod`)
- Moving/downloading data (`wget`, `curl`, `scp`)
- assessing available disk space and usage (`df`, `du`, `top`, `htop`)
- viewing, copying, moving files (`head`, `tail`, `more`, `less`, `cat`, `rm`, `mv`, `mkdir`)

We'll download raw sequence data, make backups, and analyze the quality of the data. 

## Background and Terminology
In this exercise, we'll be working in the **command line interface (CLI)**  for Linux. This is different from a **graphical user interface (GUI)**, which is used when you open a Windows or Mac computer. For instance, instead of moving your mouse over an icon on your desktop and double-clicking it to run, in Linux, we initiate programs using text delivered on the command line. 

So what is the command line? Essentially, a "command" is a string of text that, through the use of a command-line interpreter, tells the computer what to do. The command line connects the user to a computer operating system, which can be on your own physical computer, or which can be on a remote server many miles away. The **Unix shell** is one such command-line interpreter and is usually run within a Terminal window.  

### Motivation
Almost everyone who's used to normally working in a GUI finds the use of command line extremely burdensome. So, why should we go through this Linux exercise? 

- 1. *Necessity*: many widely used programs (e.g. for population genetics, [ipyrad](https://ipyrad.readthedocs.io/en/master/3-installation.html), [Stacks](https://catchenlab.life.illinois.edu/stacks/)) can only be run in a Linux (or Unix) environment. Learning the steps here allows you to install and run these programs.
- 2. *Supportability*: Linux is cool because, unlike Mac OS or Windows, it's entirely open-source. If you have an issue on your Mac/Windows computer, you have to contact IT or the support team for Apple/Microsoft. If you have an issue on a Linux OS, you do the same thing that you do when you encounter an error in R or Python: copy it, Google it, look at the relevant post on Stack Overflow, and make the fix yourself. Linux is supportable because it's open-source. 
- 3. *Reproducibility*: Unlike a GUI, working in a CLI allows for complete reproducibility. The commands used to install and run a program can be used across users to achieve identical results.

## Log on to the Hoban Lab server 
Sign in to http://10.129.0.151:8787/auth-sign-in?appUri=%2F, using the username and password Austin has given to you. After providing your information, you'll be taken a screen that matches what you would see if you were to open RStudio on your personal desktop. This is RStudio-Server: you're running RStudio on the lab's Linux Server. 

Check out the source panel for scripting, the conosole/terminal, environment and history pane, and the files, viewer, packages, and help pane. You can customize this if you like.  

<img width="1673" alt="Screen Shot 2021-08-29 at 11 44 30 AM" src="https://user-images.githubusercontent.com/10552484/131260953-acb91b54-1d3b-4041-b534-9925a8ee9166.png">


## Natigation: Here we go! 
Let's orient ourselves to this environment.  Click the terminal tab in the console/terminal/jobs pane, in the lower left for default configuration. 

The command prompt begins with your username @ ip-adress and a colon (:), then a tilde (~) for your home ***directory*** and a $ indicating the beginning of a shell prompt. A **directory** is like a folder in your files finder. If you think about your Home folder on your own computer, you likely have several folders, many that contain subfolders or files. 

Print your working directory with `pwd`, our first ***command***. This command returns where you are in the structure of the server.

```{bash}
user1@ip-<###>-<##>-<##>-<###>:~$ pwd
```

Returns for me: 
```{bash}
/home/akoontz
```
The forwardslash (/) at the beginning indicates the ***root*** directory. That's the top-level of the server and everything lives below that. This is the first ***path*** we'll see. This is an ***absolute path*** which is like a complete address, in this case starting from the root. A ***relative path*** starts from your current directory. An absolute path is similar to having the GPS coordinates for a destination, whereas a relative path is similar to getting directions to a destination based on where you currently are. I often start troubleshooting bioinformatic issues by checking paths. 

What else is in your home directory? Use `ls` to list the contents of your home directory. 

```{bash}
ls
```

Returns for me: 
```{bash}
Desktop    Documents  Downloads Pictures  Videos  Shared             
Music      Public    Templates  Tutorials
```

RStudio has nice color encoding to help us identify different types of contents. Default setting has light blue for directories, black for files, and red for executables. 

Let's list one of those directories using the `ls` command and an ***argument***, `demoFolder`. This is the basic format of shell programming, like many other languages. 

### A few tips as we get going here: 
If you start typing "ins", and hit ***\<TAB>*** the computer will auto-complete for instructor_materials. If there are multiple matches, it will only auto-complete as far as the matching part. If you hit ***\<TAB> \<TAB>***, it will list the possible matches.  USE TAB-COMPLETE!! This will reduce mistakes and make you more efficient. 

You can scroll-up in your command history with the up- and down-arrow keys. 

```{bash}
ls demoFolder 
```

Returns: 
```{bash}
demo_file.txt   DNA_16pops_migLow_1.arb   DNA_16pops_migLow_1.simparam    draft_fscParams_lowMutation.sh   
```

Arguments often have **flags** to modify the execution of a command. Single dash ***-*** have single-character options. Double-dash ***--*** have multi-character. Which flags can you use to modify the `ls` command? How do you find out? 

When in doubt with many programs, useful documentation is often provided with the `--help` argument. 

```{bash}
ls --help
```
You can also gain information by prefacing the command of interest with `man` (short for "manual").

```{bash}
man ls
```
You can use the space bar to scroll through the man page, and can press ***q*** to quit. 

Let's sort the demoFolder by the most recently modified with the `-t` flag. What else do you use often or could be useful? 

```{bash}
ls demoFolder -t
```

What do the -h and -l flags provide? Note they can be strung together here with the single dash. 

```{bash}
ls demoFolder/ -lth
```

Let's change directories with `cd` , into the `R` folder. What's in this directoy? 

```{bash}
cd ~/R
```

A few very useful ***special characters***
- ~ represents your home directory.
- . represents your current directory. 
- .. represents the directory up one level. 
- \* is a wildcard and represents one or more characters. 

```{bash}
ls .
```

```{bash}
ls ..
```

You can chain these together:

```{bash}
ls ../..
```

```{bash}
ls ~
```

You can also chain them together with a wildcard: 
```{bash}
ls ../R*
```

If you execute `cd` without any arguments, it will take you back home.

```{bash}
cd
```

Let's prepare to download and view some data by changing to our user directory folder. 
```{bash}
cd 
```

## Let's start by downloading a practice data set. 

Your first sequencing run is done and you've received an email from the sequencing facility that your data are ready. Now what?? Depending on the facility, you may use `ftp`, `wget`, or `curl` to download the data. Today, we'll use `wget` (World Wide Web get). The `-O` argument specifes the filename to save the file to.

```{bash}
wget https://www.dropbox.com/s/y44fa4zjboiq8ko/ATGCCGCT-CTCCTTAC_S152_L002_R1_001.fastq.gz?dl=0 -O ATGCCGCT-CTCCTTAC_S152_L002_R1_001.fastq.gz
wget https://www.dropbox.com/s/tthl4xdt7in5k7z/ATGCCGCT-CTCCTTAC_S152_L002_R2_001.fastq.gz?dl=0 -O ATGCCGCT-CTCCTTAC_S152_L002_R2_001.fastq.gz
```

These commands will download a set of forward (R1) and reverse (R2) RADseq reads from _Quercus boyntonii_. You should always try to look at the data, even if you process the bulk of it with a program. Take a look at one of these files. 

```{bash}
cat ATGCCGCT-CTCCTTAC_S152_L002_R1_001.fastq.gz
```

AH! Too much data and it looks garbled, too. Hit **Ctl+c (^c)** to quit a running process or abort a task. I use this more often than I care to admit. You can see that the file is of type "fastq.gz" where the ".gz" indicates the file has been compressed. File compression can save huge amounts of space! For today, though, let's uncompress the files. We can also use the `clear` command to clear the current screen.  

```{bash}
clear
gunzip -c ATGCCGCT-CTCCTTAC_S152_L002_R1_001.fastq.gz > QUBO_S152_R1.fastq
gunzip -c ATGCCGCT-CTCCTTAC_S152_L002_R2_001.fastq.gz > QUBO_S152_R2.fastq
```

The '>' is an ***operator*** , which redirects the text that would otherwise be printed to the Terminal window (called standard output) into a new text file. Other operators are the '>>' and '|' characters.

Let's use our familiar `ls` command with some additional options, to see the difference in file size between compressed and uncompressed files. Again, the 'l' stands for 'long' format, which means more detailed information is provided for each file. The 'h' means 'human-readable' file sizes, and 't' sorts by date modified. Don't forget you can always use `man ls` to see all the detailed options. 

```{bash}
ls -lht
```
This is what I see on my Terminal window (don't worry if you don't have all the same directories that I have): 

<img width="561" alt="Screen Shot 2021-08-29 at 2 59 50 PM" src="https://user-images.githubusercontent.com/10552484/131265204-5d18cd33-4b6f-4a1f-a196-392ed3866c24.png">

This long version of the directory gives us quite a bit of information! 
- Column 1 provides information if the content is a directory ('d'), file ('-'), or a link ('l'). The next 9 characters provide information on the file permission, with 3 characters for the Owner, the next 3 for the Group owner, and the last 3 for everyone else. Each set of 3 characters provides information on whether members of that group can read it ('r'), write to it ('w'), or execute it ('x'). 
- Column 2 tells us about how many links are to this file.
- Column 3 tells us about who is the owner of the file/directory.
- Column 4 tells us about who is the group owner of the file/directory.
- Column 5 tells us about the size of the file/directory in bytes unit (with the `-h` flag makes it in Byte, Kilobyte, Megabyte, Gigabyte, Terabyte and Petabyte)
- Column 6 provides the abbreviated month, day-of-month file was last modified, hour file last modified, minute file last modified. 
- Column 7 is the file or directory path name. 
   
**Exercise 1: What is the relative size difference between our compressed and uncompressed sequence files?**
<details>	
	By using the `ls-lht` command above, we can see that our compressed files are approximately 1/4 the size of our uncompressed files. Think of how much space that saves over the duration of a sequencing experiment! 
	</details>

## Modifying permissions and backing up your raw data 

One of the first things I do when I get new data is I make a backup of it that is write protected. Let's do that now using the `mv` command. Depending on how it is used, `mv` can either rename a file or move a file to somewhere else.  
```{bash}
mkdir data_backup
mv ATGCCGCT-CTCCTTAC_S152_L002_R*_001.fastq.gz data_backup
cd data_backup
ls -l
```
These commands make a copy of the data in a new directory called "data_backup", then list the permissions for the files. What are the current permissions for the owner of the file? 

We can then modify the permissions of files using the command `chmod` and flags to add or remove read, write, or execute ability. Our goal for now is to change permissions on this file so that you (the owner) no longer have write permissions. We can do this using the `chmod` (change mode) command and subtracting (-) the write permission -w.

```{bash}
chmod -w ATGCCGCT-CTCCTTAC_S152_L002_R*_001.fastq.gz
```
We can use our `ls` again to check that we've changed the permissions. 

```{bash}
ls -l
```

And, we can prove to ourselves that we have modified the permissions by trying to delete the files using `rm`

```{bash}
rm ATGCCGCT-CTCCTTAC_S152_L002_R*_001.fastq.gz
```

The output should ask if you actually want to remove the write-protected files. You should answer with an 'n'. If you say yes, you will remove the file forever! Using the command `rmdir` will delete directories. 

Moving forward, as you create files and directories, remember: 
* File names that start with a period are hidden. You can view them with **ls -a**
* Bash is case-sensitive. file1.txt and File1.txt are different. Be consistent. 
* Do not (!!) embed spaces in file names. Use file1 or File_1 or file-1 or SnakeCase. I prefer underscores because R interprets - as subtraction.  

### Processing
Before we submit jobs, we might want to know the status of our system, and what processes are running, so that we can decide how many jobs we can submit simultaneously. We can see what is currently running on a computer using either `htop`, which you can read more about [here](https://htop.dev/).

## Viewing files

Let's put our raw fastq files in a directory to stay organized. 

```{bash}
mkdir raw_fastq
mv *.fastq raw_fastq
```

Let's look at the first few lines of one of our fastq files with the command `head`. 

```{bash}
head raw_fastq/QUBO_S152_R1.fastq
```

You can do the same with `tail` for the end of the file. Both commands have an option `-n` for the number of lines. 

```{bash}
tail -n 4 raw_fastq/QUBO_S152_R1.fastq
```

It's useful to know about the fastqc file encoding: https://en.wikipedia.org/wiki/FASTQ_format. Fastqc uses these data to generate a really useful report. 

Let's check how many reads we have in each file using `wc` (word count). By default, using `wc` on a file gives three columns with the number of lines, the number of words, and the number of characters. We can ask for only the number of lines using the `-l` flag. 

```{bash}
wc -l raw_fastq/QUBO_S152_R1.fastq
```
**Exercise 3: How many reads are there?**
<details>
	There are 4 million lines in each file. Given that there are 4 lines per 1 sequence read in a .fastq file, there are 1 million reads in each file. 
</details>
					
Given how large these files are, it is not useful to use `cat` to try to look at them. We can view parts of the file using `more` or `less`. Like the manual pages, we can use the space bar to scroll, and the 'q' to quit. Can you tell what the difference is between the two commands? 
		
```{bash}
more raw_fastq/QUBO_S152_R1.fastq
less raw_fastq/QUBO_S152_R1.fastq		
```

# Fastqc
I almost always run Fastqc first when I get a new data set. I check for the expected number of reads, read length, overall quality, and duplicate rate. 

Check out fastqc options with the --help option.

```{bash}
fastqc --help
```

Make a directory to capture the output of fastqc. 

```{bash}
mkdir quality_metrics
```

Use the wildcard \*.fastq to call both R1 and R2.  

```{bash}
ls raw_fastq/*.fastq
```

Returns: 
```{bash}
raw_fastq/QUBO_S152_R1.fastq
raw_fastq/QUBO_S152_R2.fastq
```

## Run FastQC

```{bash}
fastqc raw_fastq/*.fastq -o quality_metrics/
```

While this is running, look through the provided 'good' and 'bad' report examples. 

http://www.bioinformatics.babraham.ac.uk/projects/fastqc/good_sequence_short_fastqc.html
http://www.bioinformatics.babraham.ac.uk/projects/fastqc/bad_sequence_fastqc.html

More on common fastqc red-flags: https://www.dna-ghost.com/single-post/2017/09/01/How-to-interpret-FASTQC-results 

**Exercise 4: What did fastqc create?**

ls -l shows two new files for each fastq file

```{bash}
ls -l quality_metrics/
```

```{bash}
total 1796
-rw-r--r-- 1 user10 user10 592881 Aug 23 10:51 QUBO_S152_R1_fastqc.html
-rw-r--r-- 1 user10 user10 311361 Aug 23 10:51 QUBO_S152_R1_sub_fastqc.zip
-rw-r--r-- 1 user10 user10 603773 Aug 23 10:51 QUBO_S152_R2_sub_fastqc.html
-rw-r--r-- 1 user10 user10 323468 Aug 23 10:51 QUBO_S152_R2_sub_fastqc.zip
```
	
- The ".html" is the FastQC report, in HTML format.
- The "zip" is a zipped (compressed) directory of FastQC output files.

Let's look at the output. We can't view html reports on the remote server, so you could copy the file back to your own laptop. Within RStudio, however, we are able to open the html files we have generated by selecting the "Files" tab in the bottom right corner of RStudio, then navigating to our 'quality_metrics' directory. Open the html report in your web browser. How do you think the sequencing run went? 

Hopefully today's lesson has helped you feel more comfortable working from the command line in UNIX. The more you practice, the easier and more fluid it will be!

# Other resources

https://wikis.utexas.edu/display/CoreNGSTools/Linux+fundamentals

https://astrobiomike.github.io/unix/

http://linuxcommand.org/index.php

https://datacarpentry.org/shell-genomics/

https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000424
