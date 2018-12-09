rem ========================================================================
rem 
rem Google ドライブ バックアップ
rem 
rem ========================================================================



rem ========================================================================
rem エントリーポイント
:entry

echo off

rem 保存バッチ実行の日時
set DATETIME="%date:~-10,4%-%date:~-5,2%%date:~-2,2%-%time:~0,2%-%time:~3,2%"

rem Google ドライブ パス
set GOOGLE_DRIVE="Google ドライブ"
set GOOGLE_DRIVE_ORG="C:\Users\%USERNAME%\Google ドライブ"

rem アーカイブファイル
set ARCHIVE_FILE=%GOOGLE_DRIVE%_%DATETIME%.zip

rem エラーログファイル
set ERROR_LOG_FILE=%GOOGLE_DRIVE%_%DATETIME%.log

goto google_drive_backup



rem ========================================================================
rem Google ドライブ ディレクトリのバックアップ
:google_drive_backup

rem 既に Google ドライブのバックアップがあったら削除しておく
if exist %GOOGLE_DRIVE% (
	rmdir /s /q %GOOGLE_DRIVE%
)

rem 現在の Google ドライブ ディレクトリをまるごとコピーする
xcopy /e /v /c /i /q /y %GOOGLE_DRIVE_ORG% %GOOGLE_DRIVE% 2> %ERROR_LOG_FILE%

rem 現在の Google ドライブ ディレクトリをまるごと圧縮する
PowerShell -Command Compress-Archive -Path '%GOOGLE_DRIVE%' -DestinationPath '%ARCHIVE_FILE%' 2> %ERROR_LOG_FILE%
if exist %GOOGLE_DRIVE% (
	rmdir /s /q %GOOGLE_DRIVE%
)

goto end



rem ========================================================================
rem 終了処理
:end

exit /b 0



