#!/bin/bash

name=""
Final_User_name=""
Final_Public_Repos=""
Final_Following=""
Final_Followers=""
Final_Starred_Repos=""
Final_Created_at=""
Final_Updated_at=""
count=0

read -p "Enter You Github Profile Name : " name


Profile_Data=$(curl -s "https://api.github.com/users/$name")
Starred_Repos_Data=$(curl -s "https://api.github.com/users/$name/starred")

Final_User_name=$(echo $Profile_Data | jq -r '.login')
Final_Public_Repos=$(echo $Profile_Data | jq -r '.public_repos')
Final_Following=$(echo $Profile_Data | jq -r '.following')
Final_Followers=$(echo $Profile_Data | jq -r '.followers')
Final_Starred_Repos=$(echo $Starred_Repos_Data | jq '.[].full_name')
Final_Created_at=$(echo $Profile_Data | jq -r '.created_at')
if [[ $Final_User_name = "null" ]]; then
    echo "No User Found"
else
    echo "User Name : $Final_User_name"
    echo " "
    if [[ $Final_Created_at = "null" ]]; then
        echo "Error ..."
    else
        date_part="${Final_Created_at%%T*}"
        echo "User Created Account in $date_part"
        echo " "
    fi
   
    if [[ $Final_Public_Repos = "null" ]]; then
        echo "No Public Repos"
    else
        echo "Total Public Repos : $Final_Public_Repos"
        echo " "
    fi

    if [[ $Final_Following = "null" ]]; then
        echo "User does not follow anyone"
    else
        echo "Total Following : $Final_Following"
        echo " "
    fi

    if [[ $Final_Followers = "null" ]]; then
        echo "User has no following"
    else
        echo "Total Followers : $Final_Followers"
        echo " "
    fi
    echo "User has Starred Following Repos : .."
    echo " "
    while [[ $Final_Starred_Repos != "null" ]]; do
        Final_Starred_Repos=$(echo "$Starred_Repos_Data" | jq ".[$count].full_name")
        if [[ $Final_Starred_Repos != "null" ]]; then
            echo "$Final_Starred_Repos"
            echo " "
        fi
        ((count++))
    done

    echo "Total Starred Repos : $count"
fi



    