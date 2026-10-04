#!/bin/bash

BASE="dc=alvaro2026,dc=ldap"
ADMIN="cn=admin,dc=alvaro2026,dc=ldap"

op=0

while [ $op -ne 4 ]; do
    echo "1) Borrar correo"
    echo "2) Cambiar correo"
    echo "3) Buscar"
    echo "4) Salir"
    read -p "Opcion: " op

    if [ $op -eq 1 ]; then
        read -p "Usuario: " u
        read -p "OU: " ou

        echo "dn: uid=$u,ou=$ou,$BASE" > mod.ldif
        echo "changetype: modify" >> mod.ldif
        echo "delete: mail" >> mod.ldif

        ldapmodify -x -D "$ADMIN" -W -f mod.ldif
        rm mod.ldif
    fi

    if [ $op -eq 2 ]; then
        read -p "Usuario: " u
        read -p "OU: " ou
        read -p "Nuevo mail: " m

        echo "dn: uid=$u,ou=$ou,$BASE" > mod.ldif
        echo "changetype: modify" >> mod.ldif
        echo "replace: mail" >> mod.ldif
        echo "mail: $m" >> mod.ldif

        ldapmodify -x -D "$ADMIN" -W -f mod.ldif
        rm mod.ldif
    fi

    if [ $op -eq 3 ]; then
        echo "a) Buscar uno"
        echo "b) Ver todos"
        read -p "Opcion: " sub

        if [ "$sub" = "a" ]; then
            read -p "Usuario a buscar: " u
            ldapsearch -x -b "$BASE" "(uid=$u)" cn mail
        fi

        if [ "$sub" = "b" ]; then
            ldapsearch -x -b "$BASE" "(objectClass=posixAccount)" cn mail
        fi
    fi
done
