#!/usr/bin/expect -f

set timeout -1

# Navigate to the directory.
cd ~/EasyRSA-3.0.8/

# Create the destination directory for keys, if it doesn't already exist.
exec mkdir -p ~/client-configs/keys/

for {set i 1} {$i <= 254} {incr i} {
    set name "2023admin$i"
    
    # Generate the certificate request.
    spawn ./easyrsa gen-req $name nopass
    expect "Common Name*"
    send "$name\r"
    expect eof  # Wait for the current process to finish before moving on.

    # Define the source path for the current key. Adjust the path if your setup is different.
    set source_path "/root/EasyRSA-3.0.8/pki/private/$name.key"
    
    # Define the destination path. Make sure this directory exists or is created before this point.
    set dest_path "/root/client-configs/keys/"
    
    # Copy the specific key file just generated. You should reference the exact file, not use a wildcard.
    exec cp $source_path $dest_path
}
