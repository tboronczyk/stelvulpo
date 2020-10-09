FROM ubuntu:focal

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN dpkg --add-architecture i386 \
 && apt update \
 && apt install -y -o APT::Immediate-Configure=false build-essential software-properties-common wget p7zip-full unzip cabextract \
 && (wget -q https://dl.winehq.org/wine-builds/winehq.key -O- | apt-key add -) \
 && add-apt-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ focal main" \
 && apt update \
 && apt install -y -o APT::Immediate-Configure=false --install-recommends winehq-stable \
 && wineboot \
 && wget --no-check-certificate -O /tmp/monkey-moore.7z 'https://www.dropbox.com/s/lr6ts0okk6fp5i3/monkey-moore-0.5-win32.7z?dl=1' \
 && 7z x /tmp/monkey-moore.7z -o/opt \
 && wget --no-check-certificate -O /tmp/yychr.zip 'https://www.dropbox.com/s/gyr2q2wrqrdd7tf/yychr20200119.zip?dl=1' \
 && unzip /tmp/yychr.zip -d /opt \
 && wget --no-check-certificate -O /tmp/Atlas.zip 'https://www.dropbox.com/s/pd1ciita3xcikht/Atlasv1.11.zip?dl=1' \
 && unzip /tmp/Atlas.zip -d /opt/Atlasv1.11 \
 && wget --no-check-certificate -O /tmp/IpsAndSum.zip 'https://www.dropbox.com/s/ug0npyh0lm7wma5/IpsAndSum.zip?dl=1' \
 && unzip /tmp/IpsAndSum.zip -d /opt/IpsAndSum \
 && wget -O /tmp/la.zip 'https://www.dropbox.com/s/smjdi4540zkbfw6/la104.zip?dl=1' \
 && unzip /tmp/la.zip -d /opt/la104 \
 && wget --no-check-certificate -O /tmp/lc.zip 'https://www.dropbox.com/s/pt76meoc6qaxfi1/lc181.zip?dl=1' \
 && unzip /tmp/lc.zip -d /opt/lc181 \
 && wget --no-check-certificate -O /tmp/lips.zip 'https://www.dropbox.com/s/xkr0dhmffo5cv04/lips102.zip?dl=1' \
 && unzip /tmp/lips.zip -d /opt/lips102 \
 && wget --no-check-certificate -O /tmp/snesgfx.zip 'https://www.dropbox.com/s/ii47iywi9o5y8qv/SnesGFX262.zip?dl=1' \
 && unzip /tmp/snesgfx.zip -d /opt/SnesGFX262 \
 && wget --no-check-certificate -O /tmp/bsnes-plus.7z 'https://www.dropbox.com/s/0g72sgm3amsrehh/bsnes-plus-05-x64.7z?dl=1' \
 && 7z x /tmp/bsnes-plus.7z -o/opt/bsnes-plus-05-x64 \
 && wget --no-check-certificate -O /tmp/StarFoxFontTools.7z 'https://www.dropbox.com/s/197b1ygk4hk951y/Star%20Fox%202%20Font%20Tools.7z?dl=1' \
 && 7z x /tmp/StarFoxFontTools.7z -o/opt \
 && (cd /opt/Star\ Fox\ 2\ Font\ Tools && g++ -o sf2_encode encode.cpp && g++ -o sf2_decode decode.cpp) \
 && wget --no-check-certificate -O /tmp/snesbrr.zip 'https://www.dropbox.com/s/5vysq7v04zugub7/snesbrr.zip?dl=1' \
 && unzip /tmp/snesbrr.zip -d /opt/snesbrr \
 && rm -rf /var/lib/apt/lists/* /tmp/*.zip /tmp/*.7z
