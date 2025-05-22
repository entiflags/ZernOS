read from disk

- bios puts in dl the id of the boot drive
- hard drives start at id 80 (1st hdd = 80)
- will be using "modern" bios extensions (INT13H,41; INT13H,42)
- will be addressing disk using lba (logical block addressing) packet structure