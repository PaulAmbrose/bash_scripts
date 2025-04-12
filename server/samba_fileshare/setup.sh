#!/bin/bash

# Create .myscripts folder in home directory
mkdir -p ~/.myscripts

# Create mountusb.sh
cat << 'EOF' > ~/.myscripts/mountusb.sh
#!/bin/bash
sudo mount /dev/sdb /mnt/filetransferusb
echo "USB drive mounted at /mnt/filetransferusb"
EOF

# Create clearfileshare.sh
cat << 'EOF' > ~/.myscripts/clearfileshare.sh
#!/bin/bash
sudo rm -rf /srv/samba/share/*
echo "all files in samba fileshare deleted"
EOF

# Create clearusb.sh
cat << 'EOF' > ~/.myscripts/clearusb.sh
#!/bin/bash
sudo rm -rf /mnt/filetransferusb/*
echo "all files in transfer usb deleted"
EOF

# Create fileshare.sh
cat << 'EOF' > ~/.myscripts/fileshare.sh
#!/bin/bash
cd /srv/samba/share
ls
EOF

# Create transferusb.sh
cat << 'EOF' > ~/.myscripts/transferusb.sh
#!/bin/bash
cd /mnt/filetransferusb/
EOF

# Create usbcopyall.sh
cat << 'EOF' > ~/.myscripts/usbcopyall.sh
#!/bin/bash
SRC="/mnt/filetransferusb"
DEST="/srv/samba/share"
cp -r "$SRC"/* "$DEST"
echo "files copied from $SRC to $DEST"
ls -alt
EOF

# Make all scripts executable
chmod +x ~/.myscripts/*.sh

echo "Setup complete. Scripts are in ~/.myscripts/"
