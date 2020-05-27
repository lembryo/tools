rem ========================================================================
rem 
rem Dropbox バックアップ
rem 
rem ========================================================================



rem ========================================================================
rem エントリーポイント
:entry

echo off

rem 保存バッチ実行の日時
set DATETIME="%date:~-10,4%-%date:~-5,2%%date:~-2,2%-%time:~0,2%-%time:~3,2%"

rem Dropbox パス
set DROPBOX="Dropbox"
set DROPBOX_ORG="%USERPROFILE%\Dropbox"

rem アーカイブファイル
set ARCHIVE_FILE=%DROPBOX%_%DATETIME%.zip

rem エラーログファイル
set ERROR_LOG_FILE=%DROPBOX%_%DATETIME%.log

goto dropboxe_backup



rem ========================================================================
rem Dropbox ディレクトリのバックアップ
:dropboxe_backup

rem 既に Dropbox のバックアップがあったら削除しておく
if exist %DROPBOX% (
	rmdir /s /q %DROPBOX%
)

rem 現在の Dropbox ディレクトリをまるごとコピーする
xcopy /e /v /c /i /q /y %DROPBOX_ORG% %DROPBOX% 2> %ERROR_LOG_FILE%

rem 現在の Dropbox ディレクトリをまるごと圧縮する
PowerShell -Command Compress-Archive -Path '%DROPBOX%' -DestinationPath '%ARCHIVE_FILE%' 2> %ERROR_LOG_FILE%
if exist %DROPBOX% (
	rmdir /s /q %DROPBOX%
)

goto end



rem ========================================================================
rem 終了処理
:end

exit /b 0



