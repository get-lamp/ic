# .data file format

#  	line	content
# 	1 		(str) identifier
#	2 		(int) in use quantity
#	3 		(int) total quantity
#	4 		(str) description

read_identifier(){
	# get identifier from leaf directory name
	identifier="$(echo $n | cut -f3-6 -d/)"
}

read_description(){
	description=$(sed '3q;d' $n/$DATA_FILENAME 2>/dev/null)
}

read_quantity(){
	quantity=$(sed '2q;d' $1/$DATA_FILENAME 2>/dev/null || find $1 -type d -print -mindepth 1 | grep -c /)
}

write_quantity(){
	sed -i "" "2s/${quantity}/${new_quantity}/" "$1/$DATA_FILENAME"
}

write_data_file(){
	basename $1 > $1/$DATA_FILENAME # write identifier
	echo $3 >> $1/$DATA_FILENAME 	# write quantity
	echo "$2" >> $1/$DATA_FILENAME 	# write description
}
