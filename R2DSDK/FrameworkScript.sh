#!/bin/sh

# use framework
set -e

# If we're already inside this script then die
if [ -n "$SX_MULTIPLATFORM_BUILD_IN_PROGRESS" ]; then
exit 0
fi
export SX_MULTIPLATFORM_BUILD_IN_PROGRESS=1

# params
SX_TARGET_NAME="R2DLIB"
SX_FRAMEWORK_NAME="${SX_TARGET_NAME}"
SX_INPUT_STATIC_LIB="lib${SX_FRAMEWORK_NAME}.a"
#SX_FRAMEWORK_LOCATION="${BUILT_PRODUCTS_DIR}/${SX_FRAMEWORK_NAME}.framework"

##时间信息
DATE=`date +%Y%m%d%H%M`

# framework location
FRAMEWORK_FOLDER_DIR="${SOURCE_ROOT}/${SX_FRAMEWORK_NAME}"
[ ! -d $FRAMEWORK_FOLDER_DIR ] && mkdir $FRAMEWORK_FOLDER_DIR

SX_FRAMEWORK_LOCATION="${FRAMEWORK_FOLDER_DIR}/${SX_FRAMEWORK_NAME}.framework"

# history folder
FRAMEWORK_HISTORY_DIR="${FRAMEWORK_FOLDER_DIR}"/framework_history
[ ! -d $FRAMEWORK_HISTORY_DIR ] && mkdir $FRAMEWORK_HISTORY_DIR

# move last framework to history folder( -z has some problem, should change method do )
if [[ -d "${FRAMEWORK_FOLDER_DIR}/${SX_TARGET_NAME}.framework" ]]; then
# make a cur time folder , than put last framework init
LASTFW_DIR="${FRAMEWORK_HISTORY_DIR}/${DATE}"
[ ! -d $LASTFW_DIR ] && mkdir $LASTFW_DIR
mv "$FRAMEWORK_FOLDER_DIR/"*$SX_TARGET_NAME*.framework $LASTFW_DIR
fi

# framework is a folder , can't use -z , -z is to find a file , like .a/.text
# so below code will error
#FILES=`ls $FRAMEWORK_FOLDER_DIR | grep $SX_TARGET_NAME`
#[ ! -z "$FILES" ] && mv "$FRAMEWORK_FOLDER_DIR/"*$SX_TARGET_NAME*.framework $FRAMEWORK_HISTORY_DIR

# make headers folder
mkdir -p "${SX_FRAMEWORK_LOCATION}/Headers"
HEADERS_PATH="${SX_FRAMEWORK_LOCATION}/Headers"

function build_static_library {
    # Will rebuild the static library as specified
    #     build_static_library sdk
    xcrun xcodebuild -project "${PROJECT_FILE_PATH}" \
    -target "${TARGET_NAME}" \
    -configuration "${CONFIGURATION}" \
    -sdk "${1}" \
    ONLY_ACTIVE_ARCH=NO \
    BUILD_DIR="${BUILD_DIR}" \
    OBJROOT="${OBJROOT}" \
    BUILD_ROOT="${BUILD_ROOT}" \
    SYMROOT="${SYMROOT}" $ACTION \
    -UseModernBuildSystem=NO
}

function make_fat_library {
    # Will smash 2 static libs together
    #     make_fat_library in1 in2 out
    xcrun lipo -create "${1}" "${2}" -output "${3}"
}

# 1 - Extract the platform (iphoneos/iphonesimulator) from the SDK name
if [[ "$SDK_NAME" =~ ([A-Za-z]+) ]]; then
    SX_SDK_PLATFORM=${BASH_REMATCH[1]}
else
    echo "Could not find platform name from SDK_NAME: $SDK_NAME"
    exit 1
fi

# 2 - Extract the version from the SDK
if [[ "$SDK_NAME" =~ ([0-9]+.*$) ]]; then
    SX_SDK_VERSION=${BASH_REMATCH[1]}
else
    echo "Could not find sdk version from SDK_NAME: $SDK_NAME"
    exit 1
fi

# 3 - Determine the other platform
if [ "$SX_SDK_PLATFORM" == "iphoneos" ]; then
    SX_OTHER_PLATFORM=iphonesimulator
else
    SX_OTHER_PLATFORM=iphoneos
fi

# 4 - Find the build directory
if [[ "$BUILT_PRODUCTS_DIR" =~ (.*)$SX_SDK_PLATFORM$ ]]; then
    SX_OTHER_BUILT_PRODUCTS_DIR="${BASH_REMATCH[1]}${SX_OTHER_PLATFORM}"
    echo SX_OTHER_BUILT_PRODUCTS_DIR
else
    echo "Could not find other platform build directory."
    exit 1
fi

# Build the other platform.
build_static_library "${SX_OTHER_PLATFORM}${SX_SDK_VERSION}"

# If we're currently building for iphonesimulator, then need to rebuild
#   to ensure that we get both i386 and x86_64
if [ "$SX_SDK_PLATFORM" == "iphonesimulator" ]; then
    build_static_library "${SDK_NAME}"
fi

# Join the 2 static libs into 1 and push into the .framework
# 变量中间的 \ 是换行符号
make_fat_library "${BUILT_PRODUCTS_DIR}/${SX_INPUT_STATIC_LIB}" \
"${SX_OTHER_BUILT_PRODUCTS_DIR}/${SX_INPUT_STATIC_LIB}" \
"${SX_FRAMEWORK_LOCATION}/${SX_FRAMEWORK_NAME}"
#// to sp
#make_fat_library "${BUILT_PRODUCTS_DIR}/${SX_INPUT_STATIC_LIB}" \
#"${SX_OTHER_BUILT_PRODUCTS_DIR}/${SX_INPUT_STATIC_LIB}" \
#"${SX_FRAMEWORK_LOCATION}/GamaSDK"

cp -a "${BUILT_PRODUCTS_DIR}/include/${SX_FRAMEWORK_NAME}/" "${HEADERS_PATH}"
#cp -a "${BUILT_PRODUCTS_DIR}/include/GamaSDK/" "${HEADERS_PATH}"

# Copy the framework to the resource demo
open -a Finder "${SX_FRAMEWORK_LOCATION}"

