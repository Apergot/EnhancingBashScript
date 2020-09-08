#!/bin/bash

backup_dir="/backups"
backup_date=$(date +%Y%m%d)

case $1 in
	#Copia de nivel 0
	0)touch $backup_dir/n0
	find /home | tar -czf "$backup_dir/$backup_date-0.tgz" -T - --no-recursion
	;;
	#Copia de nivel 1
	1)touch $backup_dir/n1
	find /home -newer $backup_dir/n0 2>/dev/null | tar -czf "$backup_dir/$backup_date-1.tgz" -T - --no-recursion
	;;
	#Copia de nivel 2
	2)touch $backup_dir/n2
	find /home -newer $backup_dir/n1 2>/dev/null | tar -czf "$backup_dir/$backup_date-2.tgz" -T - --no-recursion
	;;
	#Copia de nivel 3
	3)find /home -newer $backup_dir/n2 2>/dev/null | tar -czf "$backup_dir/$backup_date-3.tgz" -T - --no-recursion
	;;
	*)echo "Wrong argument, error"
	exit 1
esac
