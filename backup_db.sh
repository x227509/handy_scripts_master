#!/bin/bash
DB_NAME=""
SYNTAX_HELP="FALSE"
program_name=$(basename $0)
while [ $# -ge 1 ]dokey="$1"# echo $key $1case $key in    -wb|--workbrain)    schemas[0]="WORKBRAIN"    ;;    -cg|--cognos)    schemas[1]="COGNOS"    ;;    -ar|--archive)    schemas[2]="ARCHIVE"    ;;    -tg|--target) echo "--target" shift    DB_NAME="$1"    ;;    -h|--help)    SYNTAX_HELP="TRUE"    shift # past argument    ;;    *)     # unknown option  echo "$1 is an unkown option"    ;;esacshift # past argument or valuedone
if [ ${#schemas[@]} == 0 ];thenecho "HERE $len and $DB_NAME"   SYNTAX_HELP="TRUE"fi
if [ "$DB_NAME" == "" ];then   SYNTAX_HELP="TRUE"fi
if [ "$SYNTAX_HELP" == "TRUE" ];then   echo "NAME"   echo "   $program_name - Perform a database export"   echo "  "   echo "SYNOPSIS"   echo "   $program_name [OPTIONS]"   echo "  "   echo "DESCRIPTION"   echo "   Perform a database export of the schemas provided on the target db provided. Requires target DB and at least one schema"   echo "  "   echo "   -wb, --workbrain"   echo "      perform a WORKBRAIN schema export"   echo "  "   echo "   -cg, --cognos"   echo "      perform a COGNOS schema export"   echo "  "   echo "   -ar, --archive"   echo "      perform a ARCHIVE schema export"   echo "  "   echo "   -tg <DB> - REQUIRED"   echo "      DB to export schema from"   exit 0fi
#set ORACLE_HOME=W:\APPS\oracle\product\11.2.0\client_1\export ORACLE_HOME=/w/APPS/oracle/product/11.2.0/client_1/
#set PATH=%PATH%;W:\APPS\oracle\product\11.2.0\client_1\BIN;export PATH=/w/APPS/oracle/product/11.2.0/client_1/BIN:$PATH
#set TNS_ADMIN=W:\APPS\oracle\product\11.2.0\client_1\network\adminexport TNS_ADMIN=/w/APPS/oracle/product/11.2.0/client_1/network/admin
curr_date=$(date +%F_$$)for schema in ${schemas[*]}do   printf "exporting schema %s from $DB_NAME\n" $schema   expdp workbrain/workbrain@$DB_NAME schemas=$schema filesize=1G dumpfile=$DB_NAME.$schema.$curr_date.%U.dmp  logfile=$DB_NAME.$schema.$curr_date.log directory=DATA_PUMP_DIR flashback_time=SYSTIMESTAMP compression=ALL parallel=4 metrics=Y reuse_dumpfiles=Y exclude=TABLE:\"IN\(\'EMPLOYEE_SCHEDULE_\',\'WORK_SUMMARY_\'\)\"done
