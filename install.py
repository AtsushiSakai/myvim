#! /usr/bin/python
# -*- coding: utf-8 -*-
u"""
myvim setup script

author: Atsushi Sakai
"""
import subprocess
import time


def main():
    print("myvim install start!!")

    clone_myvim()
    set_symbolic_links()
    clone_neobundle()


def set_symbolic_links():
    print("[set_symbolic_links]")
    cmd = "ln -s ~/myvim/.vimrc ~/.vimrc ~/myvim/.vim ~/.vim"
    subprocess.call(cmd, shell=True)
    time.sleep(3.0)


def clone_neobundle():
    print("[clone_neobundle]")
    cmd = "git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim"
    subprocess.call(cmd, shell=True)
    time.sleep(3.0)


def clone_myvim():
    print("[clone_myvim]")
    cmd = "git clone git@github.com:AtsushiSakai/myvim.git ~/myvim/"
    subprocess.call(cmd, shell=True)
    time.sleep(3.0)


if __name__ == '__main__':
    main()
