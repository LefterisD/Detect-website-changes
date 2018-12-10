counter=0
i=0
input="./Desktop/Websites.txt"
while read var
do
	counter=$((counter+1))
	array[i]="$var" 
	((i++))
done <"$input"
for (( i=0; i<$counter; i++))
do 
	curl -s -o sourcecode$i.txt ${array[$i]}
		md5sum sourcecode$i.txt | cut -c -32 > md5code$i.md5
		if [[ ! -e "md5code2$i.md5" ]]
		then
			cat md5code$i.md5 > md5code2$i.md5
			echo "${array[$i]} INIT"
		else
			diff md5code$i.md5 md5code2$i.md5 > differences.txt
			if [ -s differences.txt ]
			then
			        echo "${array[$i]}"
			        > md5code2$i.md5
			        cat  md5code$i.md5 > md5code2$i.md5
			fi
		fi
done
