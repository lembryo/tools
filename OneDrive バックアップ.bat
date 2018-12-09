rem ========================================================================
rem 
rem OneDrive �o�b�N�A�b�v
rem 
rem ========================================================================



rem ========================================================================
rem �G���g���[�|�C���g
:entry

echo off

rem �ۑ��o�b�`���s�̓���
set DATETIME="%date:~-10,4%-%date:~-5,2%%date:~-2,2%-%time:~0,2%-%time:~3,2%"

rem OneDrive �p�X
set ONE_DRIVE="OneDrive"
set ONE_DRIVE_ORG="C:\Users\%USERNAME%\OneDrive"

rem �A�[�J�C�u�t�@�C��
set ARCHIVE_FILE=%ONE_DRIVE%_%DATETIME%.zip

rem �G���[���O�t�@�C��
set ERROR_LOG_FILE=%ONE_DRIVE%_%DATETIME%.log

goto one_drive_backup



rem ========================================================================
rem OneDrive �f�B���N�g���̃o�b�N�A�b�v
:one_drive_backup

rem ���� OneDrive �̃o�b�N�A�b�v����������폜���Ă���
if exist %ONE_DRIVE% (
	rmdir /s /q %ONE_DRIVE%
)

rem ���݂� OneDrive �f�B���N�g�����܂邲�ƃR�s�[����
xcopy /e /v /c /i /q /y %ONE_DRIVE_ORG% %ONE_DRIVE% 2> %ERROR_LOG_FILE%

rem ���݂� OneDrive �f�B���N�g�����܂邲�ƈ��k����
PowerShell -Command Compress-Archive -Path '%ONE_DRIVE%' -DestinationPath '%ARCHIVE_FILE%' 2> %ERROR_LOG_FILE%
if exist %ONE_DRIVE% (
	rmdir /s /q %ONE_DRIVE%
)

goto end



rem ========================================================================
rem �I������
:end

exit /b 0



