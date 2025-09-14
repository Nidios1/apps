#!/bin/bash
# Script tối ưu hóa Flutter iOS app để giảm số lượng frameworks

echo "🔧 Đang tối ưu hóa Flutter iOS app..."

# Backup pubspec.yaml hiện tại
cp pubspec.yaml pubspec_backup.yaml
echo "✅ Đã backup pubspec.yaml"

# Sử dụng phiên bản minimal
cp pubspec_minimal.yaml pubspec.yaml
echo "✅ Đã áp dụng pubspec minimal"

# Backup Podfile hiện tại
cp ios/Podfile ios/Podfile_backup_current
echo "✅ Đã backup Podfile hiện tại"

# Sử dụng Podfile tối ưu hóa
cp ios/Podfile_optimized ios/Podfile
echo "✅ Đã áp dụng Podfile tối ưu hóa"

echo ""
echo "📋 CÁC BƯỚC TIẾP THEO:"
echo "1. Chạy: flutter clean"
echo "2. Chạy: flutter pub get"
echo "3. Chạy: cd ios && pod install && cd .."
echo "4. Chạy: flutter build ios --release --no-codesign"
echo ""
echo "🎯 KẾT QUẢ MONG ĐỢI:"
echo "- Giảm từ 12 frameworks xuống ~4-6 frameworks"
echo "- App size nhỏ hơn đáng kể"
echo "- Chỉ giữ lại các tính năng cần thiết"
echo ""
echo "🔄 ĐỂ KHÔI PHỤC LẠI:"
echo "cp pubspec_backup.yaml pubspec.yaml"
echo "cp ios/Podfile_backup_current ios/Podfile"
echo "flutter clean && flutter pub get"
