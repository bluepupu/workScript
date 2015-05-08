REM ***************************************************
REM Copy Email databases from DUT
REM 
REM  WenYang, 2015/05/08
REM
REM ***************************************************

adb  pull /data/data/com.android.email/databases/EmailProvider.db
adb  pull /data/data/com.android.email/databases/EmailProviderBody.db
