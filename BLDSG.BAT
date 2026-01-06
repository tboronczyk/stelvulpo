set path=%path%;c:\bin
set sasmheap=14400
cd sg
del *.sob
del lastasm.*
make sg.rom
cd ..
copy sg\sg.rom sg.sfc
del sg\sg.rom
del sg\*.bak
del sg\*.sob
pause
exit