rem ========================================================================
rem 
rem Dropbox �o�b�N�A�b�v
rem 
rem ========================================================================



rem ========================================================================
rem �G���g���[�|�C���g
:entry

echo off

rem �ۑ��o�b�`���s�̓���
set DATETIME="%date:~-10,4%-%date:~-5,2%%date:~-2,2%-%time:~0,2%-%time:~3,2%"

rem Dropbox �p�X
set DROPBOX="Dropbox"
set DROPBOX_ORG="%USERPROFILE%\Dropbox"

rem �A�[�J�C�u�t�@�C��
set ARCHIVE_FILE=%DROPBOX%_%DATETIME%.zip

rem �G���[���O�t�@�C��
set ERROR_LOG_FILE=%DROPBOX%_%DATETIME%.log

goto dropboxe_backup



rem ========================================================================
rem Dropbox �f�B���N�g���̃o�b�N�A�b�v
:dropboxe_backup

rem ���� Dropbox �̃o�b�N�A�b�v����������폜���Ă���
if exist %DROPBOX% (
	rmdir /s /q %DROPBOX%
)

rem ���݂� Dropbox �f�B���N�g�����܂邲�ƃR�s�[����
xcopy /e /v /c /i /q /y %DROPBOX_ORG% %DROPBOX% 2> %ERROR_LOG_FILE%

rem ���݂� Dropbox �f�B���N�g�����܂邲�ƈ��k����
PowerShell -Command Compress-Archive -Path '%DROPBOX%' -DestinationPath '%ARCHIVE_FILE%' 2> %ERROR_LOG_FILE%
if exist %DROPBOX% (
	rmdir /s /q %DROPBOX%
)

goto end



rem ========================================================================
rem �I������
:end

exit /b 0



