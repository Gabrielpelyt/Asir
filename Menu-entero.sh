#!/bin/bash

clear

if [ $# -ne 0 ]
then
echo "No tienes que meter parametros"
exit 0
fi


usuario=$(whoami)
if [ $usuario != "root" ]
then
	echo "Este script se tiene que ejecutar como root (sudo su)" 
exit 1
fi



opcion=0
while [ $opcion -ne 4 ] 
do

clear

echo "        ========MENU========        "
echo "1) Comprueba que permisos tiene   "
echo "2) Comprueba si existe un directorio"
echo "3) Modificar permisos"
echo "4) Salir"

read -p "Escoge una opción: " opcion

case "$opcion" in
    1)
        read -p "Indica el archivo/directorio con su ruta: " archivo
        if [ -e "$archivo" ]
	then
		echo -n "Estos son los permisos del archivo/directorio $archivo: " 
		ls -l "$archivo" | cut -d " " -f1
        else
            echo "El archivo o directorio no existe."
        fi
        read -p "Pulse enter para continuar:" 
    ;;
    2)
    	        read -p "Indica el directorio que quieres comprobar si existe: " directorio
        if [ -e "$directorio" ]
	then
		echo "Este directorio existe $directorio"
	else
		echo "Este directorio no existe"
	fi
        read -p "Pulse enter para continuar:" 
    ;;
    3)
    	read -p "Indica el archivo/directorios que quieres modificar permisos: " permisos
    	if [ -e "$permisos" ]
    	then
    		echo -n "Ahora mismo estos son los permisos: "
    		ls -l $permisos | cut -d " " -f1
    		read -p "Añade en formato hexadecimal los permisos que tu quieras: " hexadecimal 
    		sudo chmod $hexadecimal $permisos  2>/dev/null
		if [ $? -eq 0 ]
		then
		ls -l $permisos
		else
		echo "Error no se han cambiado los permisos"
		fi
    	else
    		echo "No existe esa ruta"
    	fi
    	read -p "Pulse enter para continuar: "
    ;;
    4)
    echo "Has escogido salir "
   read -p "Pulsa enter para salir:"
   ;;
   *)
   echo "Esta opción no existe, volviendo al menu...."
   read -p "Pulsa enter para volver al menu: "
   ;;
esac
done