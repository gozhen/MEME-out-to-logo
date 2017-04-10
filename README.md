# Programmatically generate sequence logos from MEME output files

[**_./example\_meme\_out.txt_**](https://github.com/gozhen/MEME-out-to-logo/blob/master/example_meme_out.txt) - MEME output file example

**_./f\_MEMEout\_to\_enologoIn.m_** - a MATLAB function to convert formatted MEME output motif file to Enologo input files.

_**Example** (run in Matlab):_

>&gt; fin = &#39;./example\_meme\_out.txt&#39;

>&gt; path\_out = &#39;./&#39;

>&gt; f\_MEMEout\_to\_enologoIn(fin, path\_out);

**_./example\_enologo\_pwm.txt_** - Enologo example input file

**_./s\_gen\_enologo\_logo.py_** - python code to programmatically convert Enologo input files to Enologo-formatted logos. Please install Anaconda python package and mechanize module (- a python virtual browser) first. Including one method and main.

**_./example\_enologo\_logo.pdf_** - Enologo example output file
