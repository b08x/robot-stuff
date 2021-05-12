#!/usr/bin/env bash

# Build ffmpeg with pretty much support for everything as per:
# https://trac.ffmpeg.org/wiki/CompilationGuide/Centos
# includes codecs with weird licensing like MP3 and AAC.
#
# Tested on Fedora 34
#

set -eux

# # Install build requirements.
# sudo dnf install -y \
#       autoconf \
#       automake \
#       cmake \
#       freetype-devel \
#       gcc \
#       gcc-c++ \
#       git \
#       libogg-devel \
#       libtool \
#       libvorbis-devel \
#       libvpx-devel \
#       make \
#       mercurial \
#       nasm \
#       opus-devel \
#       pkgconfig \
#       yasm \
#       zlib-devel
#
SOURCE="$HOME/Source"
# # libx264
# cd $SOURCE
# git clone --depth 1 https://code.videolan.org/videolan/x264.git
# cd x264
# ./configure --prefix="/usr/local" --enable-static
# make
# sudo make install
# make distclean
#
# # libx265
# cd $SOURCE
# git clone https://bitbucket.org/multicoreware/x265_git.git
# cd x265/build/linux
# #TODO: subsitute ccmake with cmake in make-Makefiles.bash
# exit
# ./make-Makefiles.bash
# make
# sudo make install

# libfdk_aac
cd $SOURCE
git clone --depth 1 git://git.code.sf.net/p/opencore-amr/fdk-aac
cd fdk-aac
autoreconf -fiv
./configure --prefix="/usr/local" --disable-shared
make
sudo make install
make distclean

# libmp3lame
cd $SOURCE
curl -L -O https://cfhcable.dl.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz
tar xzvf lame-3.100.tar.gz
cd lame-3.100
./configure --prefix="/usr/local" --disable-shared --enable-nasm
make
sudo make install
make distclean

# ffmpeg
cd $SOURCE
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
PKG_CONFIG_PATH="/usr/local/lib/pkgconfig" ./configure --prefix="/usr/" --extra-cflags="-I/usr/local/include" --extra-ldflags="-L/usr/local/lib" --pkg-config-flags="--static" --enable-gpl --enable-nonfree --enable-libfdk-aac --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-avisynth
make
sudo make install
make distclean
hash -r
