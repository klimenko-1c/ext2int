@echo off

set bin="F:\Program Files (x86)\1cv8\8.3.9.1818\bin\1cv8.exe" DESIGNER /IBName "Srvr=""srv1c_dev:3541"";Ref=""alfa_dev_klimenko"";" /NКлименко /Psecret /ConfigurationRepositoryF "W:\STORAGE_1C\ALFA" /ConfigurationRepositoryN "Клименко" /ConfigurationRepositoryP ""

set src=Z:\Users\klimenko\Documents\Миграция
set log=Z:\Users\klimenko\Documents\log.log
set log_log=Z:\Users\klimenko\Documents\loglog.log

set dst=%src%_XML
set dst_epf=%dst%\DataProcessors
set dst_erf=%dst%\Reports

del "%log_log%"

mkdir "%dst%"

mkdir "%dst_epf%"
for %%i in ("%src%\*.epf") do (

mkdir "%dst_epf%\%%~ni"

%bin% /DumpExternalDataProcessorOrReportToFiles "%dst_epf%\%%~ni" %%~fi /Out"%log%"

:wait1
if not exist log.log goto wait1

type log.log
type log.log >> loglog.log 
del log.log
)

mkdir "%dst_erf%"
for %%j in ("%src%\*.erf") do (

mkdir "%dst_erf%\%%~nj"

%bin% /DumpExternalDataProcessorOrReportToFiles "%dst_erf%\%%~nj" %%~fj /Out"%log%"

:wait2
if not exist log.log goto wait2

type "%log%"
type "%log%" >> "%log_log%" 
del "%log%"
)

for /D %%t in (%dst%\*) do (

for /D %%d in ("%%~t\*") do (

for %%x in ("%%d\*.xml") do (

move /Y "%%~fx" "%%~dpd%%~nd.xml"
move /Y "%%~dpx%%~nx" "%%~dpd"
rmdir /s /q "%%d"
move /Y "%%~dpd%%~nx" "%%~dpd%%~nd"

)
)
)
