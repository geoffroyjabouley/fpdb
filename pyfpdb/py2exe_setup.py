#!/usr/bin/env python

"""setup.py

Py2exe script for fpdb.
"""
#    Copyright 2009,  Ray E. Barker
#    
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#    
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#    GNU General Public License for more details.
#    
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

########################################################################

#TODO:   
#        include the lib needed to handle png files in mucked
#        get rid of all the uneeded libraries (e.g., pyQT)
#        think about an installer

# done: change GuiAutoImport so that it knows to start HUD_main.exe, when appropriate

#HOW TO USE this script:
#
#- cd to the folder where this script is stored, usually .../pyfpdb.
#  [If there are build and dist subfolders present , delete them to get
#   rid of earlier builds. Update: script now does this for you]
#- Run the script with "py2exe_setup.py py2exe"
#- You will frequently get messages about missing .dll files. E. g., 
#  MSVCP90.dll. These are somewhere in your windows install, so you 
#  can just copy them to your working folder. (or just assume other
#  person will have them? any copyright issues with including them?)
#- If it works, you'll have 3 new folders, build and dist and gfx. Build is 
#  working space and should be deleted. Dist and gfx contain the files to be
#  distributed. 
#- Last, you must copy the etc/, lib/ and share/ folders from your
#  gtk/bin/ (just /gtk/?) folder to the dist folder. (the whole folders, 
#  not just the contents) 
#- You can (should) then prune the etc/, lib/ and share/ folders to 
#  remove components we don't need. 

import os
import sys
from distutils.core import setup
import py2exe
import glob
import matplotlib
from datetime import date


def remove_tree(top):
    # Delete everything reachable from the directory named in 'top',
    # assuming there are no symbolic links.
    # CAUTION:  This is dangerous!  For example, if top == '/', it
    # could delete all your disk files.
    # sc: Nicked this from somewhere, added the if statement to try 
    #     make it a bit safer
    if top in ('build','dist','gfx') and os.path.basename(os.getcwd()) == 'pyfpdb':
        #print "removing directory '"+top+"' ..."
        for root, dirs, files in os.walk(top, topdown=False):
            for name in files:
                os.remove(os.path.join(root, name))
            for name in dirs:
                os.rmdir(os.path.join(root, name))
        os.rmdir(top)

def test_and_remove(top):
    if os.path.exists(top):
        if os.path.isdir(top):
            remove_tree(top)
        else:
            print "Unexpected file '"+top+"' found. Exiting."
            exit()

# remove build and dist dirs if they exist
test_and_remove('dist')
test_and_remove('build')
test_and_remove('gfx')


today = date.today().strftime('%Y%m%d')
print "\nOutput will be created in /dist/ and /fpdb_XXX_"+today+"/"
print "Enter value for XXX (any length): ",     # the comma means no newline
xxx = sys.stdin.readline().rstrip()
dist_dir = r'..\fpdb-' + xxx + '-' + today
print


setup(
    name        = 'fpdb',
    description = 'Free Poker DataBase',
    version     = '0.12',

    console = [   {'script': 'fpdb.py', },
                  {'script': 'HUD_main.py', },
                  {'script': 'Configuration.py', }
              ],

    options = {'py2exe': {
                      'packages'    : 'encodings',
                      'includes'    : 'cairo, pango, pangocairo, atk, gobject, PokerStarsToFpdb',
                      'excludes'    : '_tkagg, _agg2, cocoaagg, fltkagg',
                      'dll_excludes': 'libglade-2.0-0.dll',
                  }
              },

    # files are moved from 2nd value in tuple to dir named in 1st
    data_files = [('', ['HUD_config.xml.example', 'Cards01.png', 'logging.conf'])
                 ,(dist_dir, ['run_fpdb.bat'])
                 ,( dist_dir + r'\gfx', glob.glob(r'..\gfx\*.*') )
                 #,(r'matplotlibdata', glob.glob(r'c:\python25\Lib\site-packages\matplotlib\mpl-data\*'))
                 ] + matplotlib.get_py2exe_datafiles()
)


print '\nIf py2exe was successful move the /dist/ directory '
print 'into /'+dist_dir+'/ and rename it as /pyfpdb/'
print "Don't forget to add the /etc /lib and /share dirs from your gtk dir\n"

