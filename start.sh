#!/bin/bash
scaned=('')
it=0
function find_exe() {
  local start_dir=$1
  if [ -n "$start_dir" ]; then
    start_dir=$(realpath ${start_dir})
    # shellcheck disable=SC2045
    for i in $(ls $start_dir); do
      local pth=$start_dir/$i
      [[ -e $pth ]] || break
      if [ -d $pth ]; then
        echo "Searching in ... ${i}"
        it=$((it + 1))
        scaned[$it]=$i
        find_exe $pth
      elif [[ $i == "untitled" && -x $pth ]]; then
        printf '%s\n' "${scaned[@]}"
        exec $pth 2 4 6
      fi
    done
  fi

}
function list_cargo() {
  IFS=$'\n'
  for i in $(cat Cargo.toml); do
    echo $i
  done
}
function accept_params() {
    echo "the number of params? that were passed to me is $#"
    local last_var=${!#}
    if [ "${last_var##*/}" = "start.sh" ]; then
        echo ${!#}
    fi
    for i in "$*" ; do
        echo -e $i"\n"
    done
}
function list_using_read() {

  read -p "please select source of reading:[yes/no]" from_std
  if [ $from_std = 'no' ]; then
    exec 0< Cargo.toml
  fi
    local i=0

    while read line ; do
      i=$((i+1))
        echo  "Line $i is : $line"
    done
 exec 1>&4
 }
 function list_fd() {

    lsof -a -p $$ -d 0,1,2
 }
list_fd
#accept_params 1t 2g 3q 4n
#list_cargo
#find_exe .
