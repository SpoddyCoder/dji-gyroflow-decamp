# DJI-Gyroflow-Decamp

Some simple tools to automate the decamp process after a good day's droning.
Rename the files first, then run the gyroflow batch process.
Gyroflow is an excellent open-source project to stabilise video footage with gyro data:
https://gyroflow.xyz/


## `rename-batch.sh`

* Copy `rename-batch.sh` to the directory containing the files and run it.
* It will do a dry-run first and allow you to confirm before renaming the files.
* Assumes that video files, subtitle files and betaflight blackbox files all match up one-to-one.
* Renames to the following format;

```
Flight_1.AIR.mp4
Flight_1.AIR.BFL
Flight_1.GOG.mp4
Flight_1.GOG.srt
```


## `gyroflow-batch.sh`

* Copy `gyroflow-batch.sh` to the directory containing the files and run it.
* It will show the files will be processed and ask for confirmation before running. 
* Assumes the Air Unit video files and Betaflight blackbox logs are renamed to the format above.
* The files are processed using the `preset.gyroflow` preset.
