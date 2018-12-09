rem ========================================================================
rem 
rem OneDrive バックアップ
rem 
rem ========================================================================



rem ========================================================================
rem エントリーポイント
:entry

echo off

rem 保存バッチ実行の日時
set DATETIME="%date:~-10,4%-%date:~-5,2%%date:~-2,2%-%time:~0,2%-%time:~3,2%"

rem OneDrive パス
set ONE_DRIVE="OneDrive"
set ONE_DRIVE_ORG="C:\Users\%USERNAME%\OneDrive"

rem アーカイブファイル
set ARCHIVE_FILE=%ONE_DRIVE%_%DATETIME%.zip

rem エラーログファイル
set ERROR_LOG_FILE=%ONE_DRIVE%_%DATETIME%.log

goto one_drive_backup



rem ========================================================================
rem OneDrive ディレクトリのバックアップ
:one_drive_backup

rem 既に OneDrive のバックアップがあったら削除しておく
if exist %ONE_DRIVE% (
	rmdir /s /q %ONE_DRIVE%
)

rem 現在の OneDrive ディレクトリをまるごとコピーする
xcopy /e /v /c /i /q /y %ONE_DRIVE_ORG% %ONE_DRIVE% 2> %ERROR_LOG_FILE%

rem 現在の OneDrive ディレクトリをまるごと圧縮する
PowerShell -Command Compress-Archive -Path '%ONE_DRIVE%' -DestinationPath '%ARCHIVE_FILE%' 2> %ERROR_LOG_FILE%
if exist %ONE_DRIVE% (
	rmdir /s /q %ONE_DRIVE%
)

goto end



rem ========================================================================
rem 終了処理
:end

exit /b 0



