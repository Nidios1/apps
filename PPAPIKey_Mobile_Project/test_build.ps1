# Test Build Script for PPAPIKey Mobile Project
# This script tests the iOS build locally to ensure it works before pushing to GitHub Actions

Write-Host "🚀 Starting PPAPIKey Mobile Build Test..." -ForegroundColor Green

# Navigate to project directory
Set-Location "C:\xampp\htdocs\PPAPIKey_Mobile_Project"

Write-Host "📁 Current directory: $(Get-Location)" -ForegroundColor Yellow

# Check Flutter installation
Write-Host "🔍 Checking Flutter installation..." -ForegroundColor Cyan
flutter --version

# Clean previous builds
Write-Host "🧹 Cleaning previous builds..." -ForegroundColor Cyan
flutter clean

# Get dependencies
Write-Host "📦 Getting Flutter dependencies..." -ForegroundColor Cyan
flutter pub get

# Check for iOS dependencies
Write-Host "🍎 Installing iOS dependencies..." -ForegroundColor Cyan
Set-Location "ios"
pod install --repo-update
Set-Location ".."

# Analyze code
Write-Host "🔍 Analyzing code..." -ForegroundColor Cyan
flutter analyze

# Build for iOS Simulator
Write-Host "🏗️ Building for iOS Simulator..." -ForegroundColor Cyan
flutter build ios --debug --simulator --no-codesign

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Build successful! The project should now build in GitHub Actions." -ForegroundColor Green
    Write-Host "📱 iOS Simulator build completed successfully" -ForegroundColor Green
} else {
    Write-Host "❌ Build failed! Please check the error messages above." -ForegroundColor Red
    Write-Host "💡 Common fixes:" -ForegroundColor Yellow
    Write-Host "   - Run 'flutter doctor' to check Flutter setup" -ForegroundColor Yellow
    Write-Host "   - Ensure Xcode is installed and configured" -ForegroundColor Yellow
    Write-Host "   - Check iOS deployment target in ios/Runner.xcodeproj" -ForegroundColor Yellow
}

Write-Host "🏁 Build test completed!" -ForegroundColor Green
