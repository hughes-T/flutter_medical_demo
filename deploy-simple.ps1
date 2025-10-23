# Simple deploy script
Write-Host "Building web version..." -ForegroundColor Yellow
flutter build web --release --base-href "/flutter_medical_demo/"

Write-Host "Deploying to GitHub Pages..." -ForegroundColor Yellow
cd build/web
if (Test-Path ".git") { Remove-Item -Recurse -Force .git }
git init
git add .
git commit -m "Deploy"
git branch -M gh-pages
git remote add origin https://github.com/hughes-T/flutter_medical_demo.git 2>$null
git push -f origin gh-pages
cd ..\..

Write-Host "Done! Visit: https://hughes-t.github.io/flutter_medical_demo/" -ForegroundColor Green
