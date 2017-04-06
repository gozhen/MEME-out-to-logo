#from flask import render_template, Flask, url_for, request, redirect
#from app import app
import os
#from werkzeug import secure_filename
import mechanize
import time
#import platform

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
# 2017 Zhen Gao (c)



def get_enologo(fin, path_out):
    '''
    input a text file name, submit its content to enologo, 
    get the pdf and png logo.  
    '''
    # read the matrix file into a string
    # target my generated reverse-engineering matrix for enologo
    # read the text file as a string
    with open (fin, "r") as myfile:
        data=myfile.read()
    fname = fin.split('/')[-1].split('.')[0]


    # start the mechanize browser
    url = "http://www.benoslab.pitt.edu/cgi-bin/enologos/enologos.cgi"
    br = mechanize.Browser()
    br.set_handle_robots(False) # ignore robots
    br.open(url)
    br.select_form(nr=0)

    # choose DNA default option
    # submit the web and then we can actually run it
    #time.sleep(1) # delays for x seconds
    br["#reset_form"] = ["1"]
    res = br.submit()
    
    time.sleep(0.7) # delays for x seconds
    
    # submit the matrix
    br.select_form(nr=0)
    br["matrix"] = data
    res = br.submit()

    download_url = 'http://www.benoslab.pitt.edu/enologos/tmp/'
    # find the link to the image
    code_str = ''
    for link in br.links():
        if link.text[:5] == '[IMG]':
            if link.url[:42] == download_url:
                #print link.text, link.url
            
                #print link.url, link.url[42:]
                ix = link.url[42:].index('.')
                
                #print link.url[42:][:ix]
                code_str = link.url[42:][:ix]
    # return the image url, without the extension,
    # return download_url+code_str

    # download the logo image files
    br.retrieve(download_url+code_str+ '.pdf', path_out+fname+'.pdf')[0]

    # convert the pdf file to png file and trim the iamge edges
    print os.popen('convert -density 300 '+path_out+fname+'.pdf'+\
        ' -trim ' + path_out+fname+'.png').read()



# Revise here to generate logos from enologo input text files. 
fin = './example_enologo_pwm.txt'
print fin
path_out = './'
get_enologo(fin, path_out)

































































































