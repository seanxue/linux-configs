#!/bin/bash

cfg_dir=$(dirname $(readlink -f $0))

function install_bin()
{
  echo "install bin ..."

  if [ -e ~/bin ]; then 
    echo "~/bin is already existing"  
    echo "do nothing!"
  else 
     ln -vs ${cfg_dir}/bin ~/bin
     echo "install bin done"
  fi

  echo 
}

function conf_bash() 
{
  # install .bashrc
  echo install .bashrc ...

  if [ ! -e ~/.bashrc ]; then
    echo create ~/.bashrc file
    echo > ~/.bashrc
  fi

  has_conf=$(grep "\. ${cfg_dir}/bashrc" ~/.bashrc | wc -l)
  if (( ${has_conf} )); then
    echo bashrc has already been config 
  else
    sed -i "1 i # import common settings\n. ${cfg_dir}/bashrc\n" ~/.bashrc
  fi
  
  echo install .bashrc done
  echo 
}

function conf_inputrc()
{
  # install inputrc
  echo install .inputrc ...
  rm -vf ~/.inputrc
  ln -s ${cfg_dir}/inputrc ~/.inputrc
  echo install .inputrc done
  echo 
}

function conf_vim()
{
  # install .vimrc
  echo install .vimrc ...
  echo -e "set runtimepath=${cfg_dir}/vim,\$VIMRUNTIME\nsource ${cfg_dir}/vim/.vimrc" > ~/.vimrc
  echo install .vimrc done
  echo 
}

function conf_git()
{
  # install .gitconfig
  echo install .gitconfig ...
  rm -vf ~/.gitconfig
  ln -s ${cfg_dir}/gitconfig ~/.gitconfig
  echo install .gitconfig done
  echo 
}

install_bin
conf_bash
conf_inputrc
conf_vim
conf_git
