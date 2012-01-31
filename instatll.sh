#!/bin/bash

cfg_root=$(pwd)

function conf_bash() 
{
  # install .bashrc
  echo install .bashrc ...

  if [ ! -e ~/.bashrc ]; then
    echo create ~/.bashrc file
    echo > ~/.bashrc
  fi

  has_conf=$(grep ". ${cfg_root}/bashrc" ~/.bashrc | wc -l)
  if (( ${has_conf} )); then
    echo bashrc has already been config 
  else
    sed -i "1 i # import common settings\n. ${cfg_root}/bashrc\n" ~/.bashrc
  fi
  
  echo install .bashrc done
  echo 
}

function conf_vim()
{
  # install .vimrc
  echo install .vimrc ...
  echo -e "set runtimepath=${cfg_root}/vim,\$VIMRUNTIME\nsource ${cfg_root}/vim/.vimrc" > ~/.vimrc
  echo install .vimrc done
  echo 
}

conf_bash
conf_vim
