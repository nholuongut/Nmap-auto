#!/bin/bash

echo "Welcome to the Nmap Automation Script"
echo "Please provide the target IP address or range:"
read target

echo "Select the type of Nmap scan:"
echo "1. Quick Scan (Top 100 ports)"
echo "2. Full Port Scan"
echo "3. Firewall detection"
echo "4. TCP + Service scan (all ports)"
echo "5. UDP + Service scan (all ports)"
echo "6. OS detection scan (all ports)"
echo "7. Disabled ping and DNS resolution (SYN scan) - TCP Scan"
echo "8. Disabled ping and DNS resolution (UDP scan) - UDP scan" 
echo "9. Custom scan"
read scan_type

if [[ $scan_type = 9 ]]; then
echo "Thanks for trying Nmap Auto!"
exit
else 
echo "Enter a name for the output file (without extension .txt):"
read output_file

echo "Include -n option? (y/n):"
read include_n_option

echo "Include -Pn option? (y/n):"
read include_Pn_option

nmap_options=""

if [[ "$include_n_option" == "y" ]]; then
    nmap_options+=" -n"
fi

if [[ "$include_Pn_option" == "y" ]]; then
    nmap_options+=" -Pn"
fi

case $scan_type in
    1)
        nmap -T4 -F $nmap_options $target -oN "$output_file.txt" 
        ;;
    2)
        nmap -T4 -p- $nmap_options $target -oN "$output_file.txt" 
        ;;
    3)
        nmap -T4 -sA $nmap_options $target -oN "$output_file.txt"
        ;;
    4)    
        nmap -T4 -p- $nmap_options $target -oN "$output_file.txt"
        ;;
    5) 
        nmap -T4 -p- $nmap_options $target -oN "$output_file.txt"
        ;;
    6) 
        nmap -T4 -A $nmap_options $target -oN "$output_file.txt"
        ;;
    7) 
        nmap -T4 -sT $nmap_options $target -oN "$output_file.txt"
        ;;
    8) 
        nmap -T4 -sU $nmap_options $target -oN "$output_file.txt"
        ;;
    9)
        echo "Thank you for trying Nmap auto !"
        ;;
    *)
        echo "Invalid option selected"
        ;;
esac

if [[ $scan_type != 9 ]]; then
    echo "Nmap scan completed. Results saved to $output_file.txt"
fi
fi
