FROM ubuntu:focal

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN dpkg --add-architecture i386 \
 && apt update \
 && apt install -y -o APT::Immediate-Configure=false build-essential software-properties-common wget p7zip-full unzip cabextract

RUN (wget -q https://dl.winehq.org/wine-builds/winehq.key -O- | apt-key add -) \
 && add-apt-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ focal main" \
 && apt update \
 && apt install -y -o APT::Immediate-Configure=false --install-recommends winehq-stable

RUN wget --no-check-certificate -L -O /tmp/utilities.zip 'https://www.dropbox.com/s/9rm6cd1gvppd6av/utilities.zip?dl=1' \
 && unzip /tmp/utilities.zip -d /tmp

RUN 7z x /tmp/utilities/monkey-moore-0.5-win32.7z -o/opt \
 && mv /opt/monkey-moore-0.5-2009-11-29-win32 /opt/monkey-moore

RUN unzip /tmp/utilities/yychr20200119.zip -d /opt \
 && mv /opt/yychr20200119 /opt/yychr

RUN unzip /tmp/utilities/tlp11.zip -d /opt/tlp11

RUN unzip /tmp/utilities/Cartographer_PR3.zip -d /opt

RUN unzip /tmp/utilities/Atlasv1.11.zip -d /opt/Atlas

RUN unzip /tmp/utilities/IpsAndSum.zip -d /opt/IpsAndSum 

RUN unzip /tmp/utilities/la104.zip -d /opt/la

RUN unzip /tmp/utilities/lc181.zip -d /opt/lc

RUN unzip /tmp/utilities/lips102.zip -d /opt/lips

RUN unzip /tmp/utilities/SnesGFX262.zip -d /opt/SnesGFX

RUN 7z x '/tmp/utilities/Star Fox 2 Font Tools.7z' -o/opt \
 && (cd /opt/Star\ Fox\ 2\ Font\ Tools && g++ -o sf2_encode encode.cpp && g++ -o sf2_decode decode.cpp)

RUN unzip /tmp/utilities/snesbrr.zip -d /opt/snesbrr

RUN 7z x /tmp/utilities/snes9x1.51.ep10r2.7z -o/opt/snes9x \
 && cp /tmp/utilities/mfc80.dll /opt/snes9x/MFC80.dll
