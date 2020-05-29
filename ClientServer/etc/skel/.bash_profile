
# set variable for check
in_sales=false

# check if user is in sales group
for f in $(groups);
do
   if [ $f = "sales" ];
   then
      in_sales=true
      break
   fi
done

# check for shared directory
if [[ $in_sales = true ]]; then

   # make restore_file function available as rf
   alias rf=/opt/replication/restore_file

   # if link to shared directory does not exist
   if [ ! -L data ]; then

      # check for existence 'home' directory
      if [ ! -d /mnt/nfs/nfsstorage/$USER ]
      then
         # create 'home' directory on share
         mkdir /mnt/nfs/nfsstorage/$USER
      fi

      # create symb. link to 'home' directory
      ln -s /mnt/nfs/nfsstorage/$USER data;
   fi

else

   # if user is (no longer) in sales group
   if [ -L data ]; then
      # if there is a symb. link, remove it
      rm data;
   fi

fi
