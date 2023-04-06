# Hoban Lab Skills Exchange: Intro to Command Lines in Linux
#### Friday, April 7th, 2023

This session is a broad overview of the command line interface, with a focus on performing basic commands in Linux. It's derived from [an exercise](https://github.com/renaschweizer/congen-2021-unixbasics) given by Dr. Rena Schweizer at the 2021 ConGen conference, as well as publicly available workshops from www.datacarpentry.org. If you already know all of the commands under "Goals", feel free to skip this part of the training. If this is all new to you--**welcome**!

## Goals
By the end of this session, you should be familiar with the following:  
* Command lines, why they're useful, how to implement them
* Navigating directories on your system (`pwd`, `cd`, `ls`)
* Assessing/changing file permissions (`ls -l`, `chmod`)
* Moving/downloading data (`wget`, `curl`, `scp`)
* Viewing, copying, moving files (`head`, `tail`, `more`, `less`, `cat`, `rm`, `mv`, `mkdir`)
* Running R scripts from the command line (`Rscript`, `nohup`)

We'll download raw sequence data, make backups, and analyze the quality of the data. For the 3 ***Exercises*** below, try to come up with an answer on your own before revealing the solution (clicking the "Details" dropdown arrow). We'll pause at each exercise for folks to ask questions.

## Background and Terminology
We'll be working in the **command line interface (CLI)**  for Linux. This is different from a **graphical user interface (GUI)**, which is used when you open a Windows or Mac computer. Instead of moving your mouse over an icon on your desktop and double-clicking it to run, we'll initiate programs using text delivered on the command line. 

So what is the command line? Essentially, a **command** is a string of text that, through the use of a command-line interpreter (usually the program **Terminal**), tells the computer what to do. The command line connects the user to an operating system, on your own computer or a remote server. To communicate with the computer, we typically use a **shell**, called such because it wraps around the outside of the "core" part of a computer (termed the **kernel**). Specifically, today we'll be using a shell named "Bourne Again Shell"--or, more commonly, **BASH**.

## Motivation
Almost everyone who's used to working in a GUI finds the use of a CLI burdensome. So why should we put ourselves through this? 

1. *Necessity*: many widely used programs (e.g. for population genetics, [ipyrad](https://ipyrad.readthedocs.io/en/master/3-installation.html), [Stacks](https://catchenlab.life.illinois.edu/stacks/)) can only be run in a Linux (or Unix) environment. Learning the steps here allows you to install and run these programs.
2. *Supportability*: Linux is cool because unlike Mac OS or Windows, it's entirely open-source. On your Mac/Windows OS, if you have an issue, you have to contact IT or the support team for Apple/Microsoft. If you have an issue on a Linux OS, you do the same thing you'd do when encountering an error in R or Python: Google it, look at the relevant post on Stack Overflow, and make the fix yourself. Linux is supportable because it's open-source. 
3. *Reproducibility*: Unlike a GUI, working in a CLI allows for complete reproducibility. The commands used to install and run a program on one computer can be used across systems to achieve identical results.

## Getting started: Log onto the Hoban Lab server 
Sign in to the [Hoban Lab server](http://10.129.0.151:8787/auth-sign-in?appUri=%2F), using the username and password Austin gave you. After providing your information, you'll be taken a screen matching what you'd see if you were to open RStudio on your personal desktop. This is RStudio-Server: you're running RStudio on the lab's Linux server. 

Check out the source panel for scripting, the Console/Terminal, environment and history pane, and the files, viewer, packages, and help pane. You can customize this if you like.  

<img width="1673" alt="Screen Shot 2021-08-29 at 11 44 30 AM" src="https://user-images.githubusercontent.com/10552484/131260953-acb91b54-1d3b-4041-b534-9925a8ee9166.png">


## Navigation: Here we go! 
Let's orient ourselves.  Click the Terminal tab in the Console/Terminal/Render/Background Jobs pane, in the lower left for the default configuration. Feel free to expand the window.

The command prompt begins with your username @ ip-adress and a colon (:), then a tilde (~) for your home ***directory*** and a `$` indicating the beginning of a shell prompt. Print your working directory by entering `pwd`, our first command. This command returns where you are in the structure of the server.

```{bash}
user1@ip-<###>-<##>-<##>-<###>:~$ pwd
```

Returns for me: 
```{bash}
/home/akoontz
```
The forward slash (/) at the beginning indicates the ***root*** directory: that's the top-level of the server, and _everything_ lives below that. This is the first ***path*** we'll see. This is an ***absolute path*** which is like a complete address, in this case starting from the root. A ***relative path*** starts from your current directory. An absolute path is similar to having the GPS coordinates for a destination, whereas a relative path is similar to getting directions to a destination based on where you currently are.

What else is in your home directory? Use `ls` to list the contents of your home directory. 

```{bash}
ls
```

Returns for me: 
```{bash}
Desktop    Documents  Downloads Pictures  Videos  Shared             
Music      Public    Templates  Tutorials
```

RStudio color encodes light blue for directories, black for files, and red for executables. 

Let's list the contents of one of those directories using the `ls` command and an ***argument***, `demoFolder`. This is the basic format of shell programming, like many other languages. 

---

**_Tip: typing in command line_**  

If you start typing "dem", and hit ***\<TAB>*** the computer will auto-complete for "demoFolder". If there are multiple matches, it will only auto-complete as far as the matching part. If you hit ***\<TAB> \<TAB>***, it will list the possible matches.  **USE TAB-COMPLETE!** This will reduce mistakes and make you more efficient. You can also scroll-up in your command history by pressing the up- and down-arrow keys. 

Also, some of the longer commands in this exercise you may wish to copy/paste. In order to paste into Terminal, use the keyboard shortcut ***Ctrl + Shift + V***.

---

```{bash}
ls demoFolder 
```

Returns: 
```{bash}
Rscript_QCkitFastQ.R  demo_file.txt  DNA_16pops_migLow_1.arb  DNA_16pops_migLow_1.simparam draft_fscParams_lowMutation.sh
```

Arguments often have **flags** to modify the execution of a command. Single dash ***-*** have single-character options; double-dash ***--*** have multi-character options. Which flags can you use to modify the `ls` command? How do you find out? 

When in doubt with many programs, useful documentation is often provided with the `--help` argument. 

```{bash}
ls --help
```
You can also gain information by prefacing the command of interest with `man` (short for "manual").

```{bash}
man ls
```
You can use the space bar to scroll through the man page, and can press ***q*** to quit. 

Let's sort the demoFolder by the most recently modified files with the `-t` flag. (For more advanced users: what else do you use often for listing files?)

```{bash}
ls demoFolder -t
```

What do the `-h` and `-l` flags provide? Note that flags can be strung together with the single dash. 

```{bash}
ls demoFolder/ -lth
```

Let's **c**hange **d**irectories with `cd`, into the `R` folder. What's in this directory? 

```{bash}
cd ~/R
```

If you execute `cd` without any arguments, it will take you back to your home directory.

```{bash}
cd
```
---
**_Tip: special characters_**  

A few very useful special characters in Linux:  

- ~  represents your home directory.  

- .   represents your current directory.  

- .. represents the directory up one level.  

- \*  is a wildcard and represents one or more characters.  

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
---

## Downloading a practice data set

Your first sequencing run finished and you've received an email from the facility that your data are ready. Now what? Depending on the facility, you may use `ftp`, `wget`, or `curl` to download the data. Today, we'll use `wget` (World Wide Web get). The `-O` argument specifies the filename to save the file to.

```{bash}
wget https://www.dropbox.com/s/75blb8gxc1zsm3f/TestSeq_S152_L002_R1_001.fastq.gz?dl=0 -O S152_L002_R1_001.fastq.gz  

wget https://www.dropbox.com/s/8la6oad5zmk42y9/TestSeq_S152_L002_R2_001.fastq.gz?dl=0 -O S152_L002_R2_001.fastq.gz
```

These commands will download forward (R1) and reverse (R2) RADseq reads of _Quercus boyntonii_. These are the product of Illumina "paired end" sequencing.

Once the downloads are complete, let's take a look at one of these files using `cat`. 

```{bash}
cat S152_L002_R1_001.fastq.gz
```

AH! Too much data and it looks garbled. Hit **Ctl+c (^c)** to quit a running process or abort a task. This is one of the most important commands you'll learn today! We can see that the file is of type "fastq.gz": the ".gz" indicates the file has been compressed. File compression can save huge amounts of space! 

If you want to observe this compressed data in a more manageable way, we can use the command `zcat` (which allows us to look at "zipped" data) and then "pipe"" the output of that to the `less` command using the '|' ***operator***. Give it a try.

```{bash}
zcat S152_L002_R1_001.fastq.gz | less
```
Like the manual pages, we can use the space bar to scroll the output of `less`. We'll talk about the [FASTQ format](https://en.wikipedia.org/wiki/FASTQ_format) more below, but you can see that the 2nd line of each entry contains the raw sequence data. The characters in the 4th line symbolize the quality score of each base call in the 2nd. For now, let's exit using ***q***.

Decompress the files using `gunzip`.

```{bash}
clear
gunzip -c S152_L002_R1_001.fastq.gz > QUBO_S152_R1.fastq
gunzip -c S152_L002_R2_001.fastq.gz > QUBO_S152_R2.fastq
```

The '>' is another ***operator*** , which redirects the text that would otherwise be printed to the Terminal window (called standard output) into a new text file. The '|' operator passes the output of a command to a different command; the '>' and '>>' operators pass the output of a command to a file.

Let's use our familiar `ls` command with some additional options, to see the difference in file size between compressed and uncompressed files. Again, the `l` stands for 'long' format, which means more detailed information is provided for each file. The `h` means 'human-readable' file sizes, and `t` sorts by date modified. Don't forget you can always use `man ls` to see all the detailed options.

```{bash}
ls -lht
```

This is what I see on my Terminal window (don't worry if you don't have all the same directories that I have):

<img width="561" alt="Screen Shot 2021-08-29 at 2 59 50 PM" src="https://user-images.githubusercontent.com/10552484/131265204-5d18cd33-4b6f-4a1f-a196-392ed3866c24.png">

---
**_Tip: `ls -l` output_**

An explanation of all this output is below--but don't worry too much about each field.

- Column 1 provides information if the content is a directory ('d'), file ('-'), or a link ('l'). The next 9 characters provide information on the file permission, with 3 characters for the Owner, the next 3 for the Group owner, and the last 3 for everyone else. Each set of 3 characters provides information on whether members of that group can read it ('r'), write to it ('w'), or execute it ('x'). 
- Column 2 tells us about how many links are to this file.
- Column 3 tells us about who is the owner of the file/directory.
- Column 4 tells us about who is the group owner of the file/directory.
- Column 5 tells us about the size of the file/directory in bytes (the `-h` flag makes it human-readable: bytes, kilobytes, megabytes, etc.)
- Column 6 provides the abbreviated month, day-of-month file was last modified, hour file last modified, minute file last modified. 
- Column 7 is the file or directory path name.
---

## Modifying permissions and backing up raw data 

One of the first things I do when I get new data is I make a backup of it that is write protected. Let's do that now using the `mv` command. Depending on how it is used, `mv` can either rename a file or move it somewhere else.  
```{bash}
mkdir dataBackup
mv S152_L002_R*_001.fastq.gz dataBackup
cd dataBackup
ls -l
```
These commands make a copy of the data in a new directory called "dataBackup", then list the permissions for the files. We can modify the permissions of files using the command `chmod` (change modifications) and flags to add or remove read, write, or execute ability. Our goal right now is to change permissions on this file so that you (the owner) no longer have write permissions. We do this by calling `chmod` and subtracting (-) the write permission (`-w`).

```{bash}
chmod -w S152_L002_R*_001.fastq.gz
```
We can use our `ls` again to check that we've changed the permissions. 

```{bash}
ls -l
```

And, we can prove to ourselves that we have modified the permissions by trying to delete the files using `rm`

```{bash}
rm S152_L002_R*_001.fastq.gz
```

The output should ask if you actually want to remove the write-protected files. You should answer with an 'n'.  

**In Linux: always be very, very careful about calling the `rm` command.** If you delete a file using `rm`, you delete it forever! Using the command `rm -r` will delete folders, and their contents, forever.  

---
**_Tip: file names in Linux_**

As you create files and folders in Linux, remember:  

1. File names that start with a period are hidden. You can view them with **ls -a**  
2. BASH is case-sensitive. file1.txt and File1.txt are different
3. Avoid spaces in file names. Use file1 or File_1 or file-1 or snakeCase. I prefer underscores because R interprets - as subtraction

---

## Viewing files

Let's put our raw fastq files in a directory to stay organized. 

```{bash}
mkdir raw_fastq
mv *.fastq raw_fastq
```

You can look at the first few lines of one of our fastq files with the command `head`. 

```{bash}
head raw_fastq/QUBO_S152_R1.fastq
```

You can do the same with `tail` for the end of the file. Both commands have an option `-n` for the number of lines. 

```{bash}
tail -n 4 raw_fastq/QUBO_S152_R1.fastq
```

Fastqc uses the [fields in the fastq](https://en.wikipedia.org/wiki/FASTQ_format) file to generate a report about the quality patterns seen across samples. The first line (the header) contains [interesting information](https://learn.gencore.bio.nyu.edu/ngs-file-formats/fastq-format/) about instrument name, flowcell ID, etc.

Let's check how many reads we have in each file using `wc` (word count). By default, using `wc` on a file gives three columns with the number of lines, the number of words, and the number of characters. We can ask for only the number of lines using the `-l` flag. 

```{bash}
wc -l raw_fastq/QUBO_S152_R1.fastq
```
**Exercise 2: How many reads are there?**
<details>
	There are 30 million lines in each file. Given that there are 4 lines per 1 sequence read in a .fastq file, there are ~7.6 million reads in each file. 
</details>

## Running fastqc
We're going to run [fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/), a lightweight software that allows you to check the expected number of reads, read length, overall quality, and duplicate rate in a collection of next generation sequencing (NGS) data.

Check out fastqc options with the --help option.

```{bash}
fastqc --help
```

Exit the help screen by pressing **q**, then make a directory to capture the output of fastqc. 

```{bash}
mkdir quality_metrics
```

Use the wildcard `\*.fastq` to list both R1 and R2.  

```{bash}
ls raw_fastq/*.fastq
```

Returns: 
```{bash}
raw_fastq/QUBO_S152_R1.fastq
raw_fastq/QUBO_S152_R2.fastq
```

Now, let's run fastqc.

```{bash}
fastqc raw_fastq/*.fastq -o quality_metrics/
```

While this is running, look through the [good](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/good_sequence_short_fastqc.html) and [bad](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/bad_sequence_fastqc.html) report examples, and [common fast-qc red flags](https://www.dna-ghost.com/single-post/2017/09/01/How-to-interpret-FASTQC-results). Note that all red doesn't necessarily mean your data is bad, and all green doesn't necessarily mean your data is good!

**Exercise 3: What did fastqc create?**
<details>

`ls -l` shows two new files for each .fastq file.

```{bash}
ls -l quality_metrics/
```

```{bash}
total 1796
-rw-r--r-- 1 akoontz11 akoontz11 592881 Aug 23 10:51 QUBO_S152_R1_fastqc.html
-rw-r--r-- 1 akoontz11 akoontz11 311361 Aug 23 10:51 QUBO_S152_R1_sub_fastqc.zip
-rw-r--r-- 1 akoontz11 akoontz11 603773 Aug 23 10:51 QUBO_S152_R2_sub_fastqc.html
-rw-r--r-- 1 akoontz11 akoontz11 323468 Aug 23 10:51 QUBO_S152_R2_sub_fastqc.zip
```
	
- The ".html" is the FastQC report, in HTML format.
- The "zip" is a zipped (compressed) directory of FastQC output files.

</details>

Let's look at the output. Within RStudio, we can open the HTML files by selecting the "Files" tab in the bottom right corner, then navigating to our `quality_metrics` directory. Open the HTML report in your web browser. Some points:
* _Per base sequence quality_: notice how quality values drop as the read (in this case, 151 bp long) increases. This is characteristic of Illumina's "sequencing by synthesis" (SBS) chemistry, and is the reason that paired end data is handy.
* _Adapter Content_: notice the presence of Nextera Transposase adapter sequence in these reads. Prior to analysis, we need to trim our data of these sequences!
* Anything else stand out to you?

## Running R
As biologists, many of us use R for analyses. I want to briefly demonstrate a few ways an R script can be fired off in Linux and set to run in the background.

### Checking out an R script
Let's move out of Terminal really quick. In the "File" tab of RStudio server, open the R script in the `demoFolder` directory ("demoFolder/Rscript_QCkistFastQ.R"), and run the entire script by pressing **Ctl+Alt+e**. What outputs do you get in the "Console" screen?

### Running a process in the background
While running the script above, you may have noticed that it took a little while for the below lines to run:

```{r}
R1_seq <- seqTools::fastqq(R1_infile)
R2_seq <- seqTools::fastqq(R2_infile)
```

Instead of waiting for output while an R script runs, there are two ways we can get this script to run in the background, while we do other stuff:

#### RStudio background jobs
The first approach uses the "Background jobs" tab in RStudio. This allows you to specify a script and have it run in the background while the main window of RStudio can still be used. You're also given the option of copying the output from that script into the current global environment (once the script completes).

#### BASH nohup command
The second approach allows you to fire off a process in the "background" of Terminal. Normally, if you wanted to run an R script from Terminal, you would use a command like:

```{bash}
Rscript demo_QCkitFastQ.R
```

If you want to run this (or any BASH) command in the background, you preface it with the command `nohup`, which stands for "no hangups". Importantly, you end the command string with the `&` symbol, giving you the string below:

```{bash}
nohup Rscript demo_QCkitFastQ.R &
```

When you run this command, you won't see anything printed to the standard output. Instead, you'll see a new file in your current working directory called "nohup.text". If you look at the contents of this file (`less nohup.text`), you'll see that it's what would typically be printed to the "Console" tab of your RStudio window--the output.

The script is running in the background on the Linux server. If you want to check other processes occurring on the server, use the `htop` command:

```{bash}
htop
```

This shows you a display of all the servers processors (32 cores), as well as the applications currently running. You can exit the `htop` window by pressing **q**.  

## Conclusion
Hopefully today's lesson has helped you feel more comfortable working from the command line in Linux. The more you practice, the easier and more fluid it will be!

# Other resources

https://wikis.utexas.edu/display/CoreNGSTools/Linux+fundamentals

https://astrobiomike.github.io/unix/

http://linuxcommand.org/index.php

https://datacarpentry.org/shell-genomics/

https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000424
