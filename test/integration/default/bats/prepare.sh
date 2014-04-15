if [[ `grep "Ubuntu" /etc/issue | grep "Debian" /etc/issue` ]]; then sudo find /etc/default/rcS -type f -exec sed -i 's/TMPTIME=0/TMPTIME=-1/g' {} \;; fi
