# Hướng dẫn ký và cài đặt IPA

## Vấn đề thường gặp khi cài đặt IPA sau khi ký

### 1. Lỗi "Unable to install app"
**Nguyên nhân:** Thiếu framework hoặc cấu hình không đúng

**Giải pháp:**
- Đảm bảo IPA được build với `--no-tree-shake-icons` (đã được loại bỏ trong workflow mới)
- Kiểm tra bundle identifier phải khớp với Apple Developer Portal
- Đảm bảo provisioning profile phù hợp

### 2. Lỗi "App installation failed"
**Nguyên nhân:** Thiếu Swift standard libraries

**Giải pháp:**
- Đã thêm `ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES` vào Config.xcconfig
- Đảm bảo `ENABLE_BITCODE = NO` để tương thích với Flutter

### 3. Lỗi "Invalid bundle"
**Nguyên nhân:** Cấu trúc IPA không đúng

**Giải pháp:**
- Workflow đã được cập nhật để tạo IPA đúng cấu trúc
- Thêm bước verify IPA structure để kiểm tra

## Các bước ký IPA với eSign

1. **Tải IPA từ GitHub Actions**
   - Vào tab "Actions" trong repository
   - Chọn workflow run mới nhất
   - Tải file `ios-app-unsigned-for-esign`

2. **Ký IPA với eSign**
   - Upload IPA vào eSign
   - Chọn certificate phù hợp
   - Đảm bảo bundle ID khớp với certificate

3. **Cài đặt IPA đã ký**
   - Sử dụng iTunes hoặc Apple Configurator
   - Hoặc cài đặt qua Xcode
   - Đảm bảo device đã được trust certificate

## Cấu hình quan trọng

### Bundle Identifier
```
com.ppapikey.mobile
```

### iOS Deployment Target
```
12.0
```

### Swift Version
```
5.0
```

### Bitcode
```
DISABLED (ENABLE_BITCODE = NO)
```

## Troubleshooting

Nếu vẫn gặp lỗi cài đặt:

1. Kiểm tra device logs trong Xcode
2. Đảm bảo certificate chưa hết hạn
3. Kiểm tra provisioning profile có đúng device UDID không
4. Thử cài đặt trên device khác để test

## Lưu ý

- Workflow đã được tối ưu để tạo IPA ổn định
- Đã loại bỏ `--no-tree-shake-icons` để tránh thiếu resources
- Thêm verification step để đảm bảo IPA structure đúng
