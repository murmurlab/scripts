iscsictl add target iqn.2016-08.fr.42.homedirs:$USER,10.51.1.1
iscsictl login iqn.2016-08.fr.42.homedirs:$USER
diskutil rename disk2 home_$USER