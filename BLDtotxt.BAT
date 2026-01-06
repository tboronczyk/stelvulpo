set path=%path%;c:\bin
set sasmheap=14400
cd sg
del *.sob
del lastasm.*
make sg.rom > ..\test.txt
cd ..
copy sg\sg.rom sg.sfc
del sg\sg.rom
del sg\*.sob
pause
exit