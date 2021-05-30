#!/bin/bash 


grab_glad() {
  local URL=$(curl 'https://gen.glad.sh/generate' \
    -H 'authority: gen.glad.sh' \
    -H 'content-type: application/x-www-form-urlencoded' \
    --data-raw $1 \
    --compressed \
    -Lso /dev/null -w %{url_effective})
    
    echo -e "\e[32mAttempting to download glad to $2 from $URL/glad.zip \e[0m"
    curl -L "$URL/glad.zip" -o "$2"
}

get_gh_latest() {
  
  echo "$release"
}

grab_gh_latest() {
  local URL=$(curl --silent "https://api.github.com/repos/$1/releases/latest" | grep '"zipball_url":' | sed -E 's/.*"([^"]+)".*/\1/')
  # 1 = repo path, 2 = local file
  echo -e "\e[32mAttempting to download $1 to $2 from $URL \e[0m"
  curl -L "$URL" -o "$2"
}

grab_sf_latest() {
  echo -e "\e[32mAttempting to download $1 to $2 from https://sourceforge.net/projects/$1/files/latest/download \e[0m"
  curl -L "https://sourceforge.net/projects/$1/files/latest/download" -o "$2"
}

unzip_to() {
  unzip "$1" -d "$2"
}

grab_glad 'generator=c&api=egl%3Dnone&api=gl%3Dnone&profile=gl%3Dcore&api=gles1%3Dnone&profile=gles1%3Dcommon&api=gles2%3D2.0&api=glsc2%3Dnone&api=glx%3Dnone&api=vulkan%3Dnone&api=wgl%3Dnone' /tmp/glad_gles2.zip
unzip_to "/tmp/glad_gles2.zip" "./external/gles2"

grab_glad 'generator=c&api=egl%3Dnone&api=gl%3Dnone&profile=gl%3Dcore&api=gles1%3Dnone&profile=gles1%3Dcommon&api=gles2%3D3.2&api=glsc2%3Dnone&api=glx%3Dnone&api=vulkan%3Dnone&api=wgl%3Dnone' /tmp/glad_gles3.zip
unzip_to "/tmp/glad_gles3.zip" "./external/gles3"

grab_gh_latest "g-truc/glm" "/tmp/glm.zip"
unzip_to "/tmp/glm.zip" "/tmp/glm"
mv /tmp/glm/*/ "./external/glm"

#grab_gh_latest "libsdl-org/SDL/" "/tmp/SDL2.zip"
#unzip_to "/tmp/SDL2.zip" "./external/SDL2"

grab_sf_latest "libpng" "/tmp/libpng.zip"
unzip_to "/tmp/libpng.zip" "/tmp/libpng"
mv /tmp/libpng/*/ "./external/libpng"
cp "./external/libpng/scripts/pnglibconf.h.prebuilt" "./external/libpng/pnglibconf.h"

grab_gh_latest "google/googletest" "/tmp/gtest.zip"
unzip_to "/tmp/gtest.zip" "/tmp/gtest"
mv /tmp/gtest/*/ "./external/gtest"
