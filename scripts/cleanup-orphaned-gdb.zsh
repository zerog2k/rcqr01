#!/bin/zsh

set -e

typeset -a pids
while IFS=$'\t' read -r pid ppid command; do
  [[ -n "$pid" ]] || continue
  [[ "$ppid" == "1" ]] || continue
  [[ "$command" == *"arm-none-eabi-gdb"* || "$command" == *"platformio debug"* ]] || continue
  pids+=("$pid")
  printf '%s\t%s\n' "$pid" "$command"
done < <(ps -axo pid=,ppid=,command= | sed 's/^[[:space:]]*//' | awk '{$1=$1; print $1 "\t" $2 "\t" substr($0, index($0,$3))}')

if (( ${#pids} == 0 )); then
  print "No orphaned GDB/PlatformIO debug processes found."
  exit 0
fi

printf '\nStop these processes? [y/N] '
read -r answer || answer=''
if [[ "$answer" != [yY] ]]; then
  print "Cancelled."
  exit 0
fi

for pid in "${pids[@]}"; do
  kill "$pid"
done

print "Stopped ${#pids} process(es)."
