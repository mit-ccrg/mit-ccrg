GROUP_GROUPNAME=stultzlab
GROUP_USERNAME=stultzlab
LOGIN=mralam
SERVER=//nebula.partners.org
 
LABDIR="stultzlab-storage/"
MOUNTPOINT="/media/nebula-storage"
 
sudo mount -t cifs -o user=$LOGIN,uid=$(id -u $GROUP_USERNAME),gid=$(id -g $GROUP_GROUPNAME),noperm,domain=partners $SERVER/$LABDIR $MOUNTPOINT
 
LABDIR="common-space/"
MOUNTPOINT="/media/nebula-common"
 
sudo mount -t cifs -o user=$LOGIN,uid=$(id -u $GROUP_USERNAME),gid=$(id -g $GROUP_GROUPNAME),noperm,domain=partners $SERVER/$LABDIR $MOUNTPOINT
 
LABDIR="critical-space/"
MOUNTPOINT="/media/nebula-critical"
 
sudo mount -t cifs -o user=$LOGIN,uid=$(id -u $GROUP_USERNAME),gid=$(id -g $GROUP_GROUPNAME),noperm,domain=partners $SERVER/$LABDIR $MOUNTPOINT
 
LABDIR="aguirrelab-storage/"
MOUNTPOINT="/media/nebula-storage-aguirrelab"
 
sudo mount -t cifs -o user=$LOGIN,uid=$(id -u $GROUP_USERNAME),gid=$(id -g $GROUP_GROUPNAME),noperm,domain=partners $SERVER/$LABDIR $MOUNTPOINT