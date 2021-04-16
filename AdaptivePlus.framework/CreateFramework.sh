#!/bin/sh

#  Script.sh
#  AdaptivePlus
#
#  Created by Yerassyl Yerlanov on 9/7/20.
#  Copyright © 2020 s10s. All rights reserved.

# universal build script:

# Setup some constants for use later on.
CURRENT_PATH="$1"
FRAMEWORK_NAME="AdaptivePlus"
SRCROOT_TMP=$(xcodebuild -workspace "${CURRENT_PATH}/${FRAMEWORK_NAME}".xcworkspace -scheme AdaptivePlus -showBuildSettings | grep " BUILD_DIR" | sed "s/BUILD_DIR = //g" | sed "s/ //g")

# Build the framework for device and for simulator (using
# all needed architectures).
xcodebuild \
    > /dev/null \
    -workspace "${CURRENT_PATH}/${FRAMEWORK_NAME}".xcworkspace \
    -scheme "${FRAMEWORK_NAME}" \
    ENABLE_BITCODE=YES \
    OTHER_CFLAGS="-fembed-bitcode" \
    BITCODE_GENERATION_MODE=bitcode \
    -configuration Release \
    -arch arm64 \
    -arch -arch \
    only_active_arch=no \
    defines_module=yes \
    -sdk "iphoneos" \

xcodebuild \
    > /dev/null \
    -workspace "${CURRENT_PATH}/${FRAMEWORK_NAME}".xcworkspace \
    -scheme "${FRAMEWORK_NAME}" \
    ENABLE_BITCODE=YES \
    OTHER_CFLAGS="-fembed-bitcode" \
    BITCODE_GENERATION_MODE=bitcode \
    -configuration Release \
    -arch x86_64 \
    -arch only_active_arch=no \
    defines_module=yes \
    -sdk "iphonesimulator" \

THIN_FRAMEWORK_DIRECTORY="${CURRENT_PATH}/BuiltFramework/Thin/${FRAMEWORK_NAME}.framework"
FAT_FRAMEWORK_DIRECTORY="${CURRENT_PATH}/BuiltFramework/Fat/${FRAMEWORK_NAME}.framework"

# Remove .framework file if exists in BuiltFramework from previous run.
if [ -d $THIN_FRAMEWORK_DIRECTORY ]; then
    rm -rf $THIN_FRAMEWORK_DIRECTORY
else
    mkdir -p $THIN_FRAMEWORK_DIRECTORY
fi
if [ -d $FAT_FRAMEWORK_DIRECTORY ]; then
    rm -rf $FAT_FRAMEWORK_DIRECTORY
else
    mkdir -p $FAT_FRAMEWORK_DIRECTORY
fi


# Copy the device version of framework to BuiltFramework.
cp -r "${SRCROOT_TMP}/Release-iphoneos/${FRAMEWORK_NAME}.framework" $THIN_FRAMEWORK_DIRECTORY
cp -r "${SRCROOT_TMP}/Release-iphoneos/${FRAMEWORK_NAME}.framework" $FAT_FRAMEWORK_DIRECTORY

# Replace the framework executable within the framework with
# a new version created by merging the device and simulator# frameworks' executables with lipo.
lipo -create -output "${FAT_FRAMEWORK_DIRECTORY}/${FRAMEWORK_NAME}" "${SRCROOT_TMP}/Release-iphoneos/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${SRCROOT_TMP}/Release-iphonesimulator/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"

FAT_SWIFTMODULE_DIRECTORY="${FAT_FRAMEWORK_DIRECTORY}/Modules/${FRAMEWORK_NAME}.swiftmodule"

mkdir -p $FAT_SWIFTMODULE_DIRECTORY

# Copy the Swift module mappings for the simulator into the
# framework.  The device mappings already exist from previous steps.
cp -r "${SRCROOT_TMP}/Release-iphonesimulator/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule/" $FAT_SWIFTMODULE_DIRECTORY

find . -name "*.swiftinterface" -exec sed -i -e 's/AdaptivePlus\.//g' {} \;
