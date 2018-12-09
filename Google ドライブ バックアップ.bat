rem ========================================================================
rem 
rem Google �h���C�u �o�b�N�A�b�v
rem 
rem ========================================================================



rem ========================================================================
rem �G���g���[�|�C���g
:entry

echo off

rem �ۑ��o�b�`���s�̓���
set DATETIME="%date:~-10,4%-%date:~-5,2%%date:~-2,2%-%time:~0,2%-%time:~3,2%"

rem Google �h���C�u �p�X
set GOOGLE_DRIVE="Google �h���C�u"
set GOOGLE_DRIVE_ORG="C:\Users\%USERNAME%\Google �h���C�u"

rem �A�[�J�C�u�t�@�C��
set ARCHIVE_FILE=%GOOGLE_DRIVE%_%DATETIME%.zip

rem �G���[���O�t�@�C��
set ERROR_LOG_FILE=%GOOGLE_DRIVE%_%DATETIME%.log

goto google_drive_backup



rem ========================================================================
rem Google �h���C�u �f�B���N�g���̃o�b�N�A�b�v
:google_drive_backup

rem ���� Google �h���C�u�̃o�b�N�A�b�v����������폜���Ă���
if exist %GOOGLE_DRIVE% (
	rmdir /s /q %GOOGLE_DRIVE%
)

rem ���݂� Google �h���C�u �f�B���N�g�����܂邲�ƃR�s�[����
xcopy /e /v /c /i /q /y %GOOGLE_DRIVE_ORG% %GOOGLE_DRIVE% 2> %ERROR_LOG_FILE%

rem ���݂� Google �h���C�u �f�B���N�g�����܂邲�ƈ��k����
PowerShell -Command Compress-Archive -Path '%GOOGLE_DRIVE%' -DestinationPath '%ARCHIVE_FILE%' 2> %ERROR_LOG_FILE%
if exist %GOOGLE_DRIVE% (
	rmdir /s /q %GOOGLE_DRIVE%
)

goto end



rem ========================================================================
rem �I������
:end

exit /b 0



