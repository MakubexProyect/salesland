set snd="C:\sonda"
mkdir %snd%
cd %snd%
git clone https://github.com/MakubexProyect/salesland.git
cd "%snd%\salesland"
git config --global credential.helper wincred
git pull
