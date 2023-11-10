#!/bin/bash
  
function ctrl_c(){
	echo -e "\n\n [!] Saliendo ...\n"
	exit 1
}
  
# Ctrl+C
trap ctrl_c INT

#Borrar bin
clear
rm *bin 2>/dev/null 
rm {data2,data6} 2>/dev/null

#Variables
type_file=""
fileResult=""
file_name="$1"

#File a descomprimir
file_name_decompress="$(7z l $file_name | tail -n 3 | head -n 1 | awk 'NF{print $NF}')"

#Descomprime file
7z x $file_name &>/dev/null

#Tipo de Archivo
type_file="$(file $file_name_decompress | awk '{print $2}')"

#Mientras sea binario
while [[ $type_file != "ASCII" ]]; do
        #echo -e "\n [+] Archivo a descomprimir: $file_name_decompress"
        7z x $file_name_decompress &>/dev/null
        file_name_decompress="$(7z l $file_name_decompress 2>/dev/null | tail -n 3 | head -n 1 | awk 'NF{print $NF}')"
	type_file="$(file $file_name_decompress | awk '{print $2}')"
	fileResult="$file_name_decompress"
done

echo -e "\n$(cat $fileResult), and it was copied to clipboard\n"
cat $fileResult | awk 'NF{print $NF}' | xclip -sel clip


