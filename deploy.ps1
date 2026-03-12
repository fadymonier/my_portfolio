# Build and deploy portfolio to Firebase Hosting
Write-Host "Building Flutter web..." -ForegroundColor Cyan
flutter build web
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host "Deploying to Firebase Hosting..." -ForegroundColor Cyan
firebase deploy
Write-Host "Done. Live at: https://fadymonierfouad-portfolio.web.app" -ForegroundColor Green
