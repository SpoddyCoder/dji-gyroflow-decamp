#!/bin/bash
#
# v0.2.0
# SpoddyCoder, 2023
#
# Batch process gyro stabilisation
# https://docs.gyroflow.xyz/app/advanced-usage/command-line-cli
#

# conf
GYROFLOW_EXE="E:\PMF-Video\Utilities\Gyroflow\Gyroflow.exe"
GYROFLOW_PRESET="E:\Apps\dji-gyroflow-decamp\slow-smooth-preset.gyroflow"


# prompt user to press a key & exit tool
# $1 : message
exitPrompt() {
    echo $1
    read -p "Press any key to exit " -n 1 -r
    exit 0
}

# $1 : "dry-run" | "go"
process() {

    filecount=0
    # Iterate over all files in the current directory that match the pattern
    for file in $(find . -maxdepth 1 -type f -name "Flight_*.AIR.mp4"); do
        # Extract the integer N from the filename
        N=$(echo $file | grep -oP '(?<=Flight_)[0-9]+(?=.AIR.mp4)')
        # Build the gyro-file name
        gyro_file="./Flight_${N}.AIR.BFL"
        # run gryoflow
        if [ "$1" == "go" ]; then
            echo "Processing $file"
            "$GYROFLOW_EXE" "$file" --gyro-file "$gyro_file" --preset "$GYROFLOW_PRESET"
        else
            echo "$GYROFLOW_EXE $file --gyro-file $gyro_file --preset $GYROFLOW_PRESET"
        fi
        filecount=$(expr $filecount + 1)
    done

}

# start
echo
echo "DJI FPV Gyrflow Stabilisation Batch Process"
echo
echo "Gyroflow commands that will run:"
process "dry-run"
if (( $filecount == 0 )); then
    exitPrompt "No files found - have you placed this tool in the directory containing the video + blackbox files?"
fi
echo
echo "$filecount flights detected"
read -p "Do you want to process? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo
    process "go"
    echo
    exitPrompt "$filecount files processed"
else
    echo
    exitPrompt "Cancelling"
fi
