# Hướng dẫn UDID và ký IPA

## 🔍 **UDID là gì?**

**UDID** = Unique Device Identifier
- **Mã định danh duy nhất** của iPhone/iPad
- **Dài 40 ký tự** (ví dụ: 00008030-001234567890ABCD)
- **Không thể thay đổi** trên mỗi device

## 🎯 **Tại sao cần UDID khi ký IPA?**

### **1. Apple yêu cầu**
- Mỗi device phải được **đăng ký** trong Apple Developer
- App chỉ cài được trên **device đã đăng ký**
- **Bảo mật** và kiểm soát của Apple

### **2. Provisioning Profile**
- **Profile phải chứa UDID** của device
- **Không có UDID** = không cài được app
- **Profile hết hạn** = không cài được app

### **3. eSign cần UDID**
- **eSign phải có UDID** trong device list
- **Ký IPA** với Profile chứa UDID
- **Download IPA** đã ký cho device cụ thể

## 📱 **Cách lấy UDID:**

### **Phương pháp 1: iTunes**
1. **Kết nối iPhone** vào máy tính
2. **Mở iTunes**
3. **Chọn iPhone** trong sidebar
4. **Click vào Serial Number** để hiện UDID
5. **Copy UDID** (40 ký tự)

### **Phương pháp 2: Xcode**
1. **Mở Xcode**
2. **Window** → Devices and Simulators
3. **Chọn iPhone** trong danh sách
4. **Copy Identifier** (UDID)

### **Phương pháp 3: iPhone Settings**
1. **Vào Settings** → General → About
2. **Scroll xuống** tìm Serial Number
3. **Tap vào Serial Number** để hiện UDID
4. **Copy UDID**

### **Phương pháp 4: 3uTools**
1. **Tải 3uTools**
2. **Kết nối iPhone**
3. **Xem thông tin device** → UDID

## 🔧 **Cách thêm UDID vào Apple Developer:**

### **Bước 1: Đăng nhập Apple Developer**
1. **Vào:** https://developer.apple.com
2. **Đăng nhập** bằng Apple ID
3. **Vào:** Certificates, Identifiers & Profiles

### **Bước 2: Thêm Device**
1. **Vào:** Devices → All
2. **Click "+"** để thêm mới
3. **Nhập:**
   - **Device Name:** iPhone của bạn
   - **Device UDID:** [UDID đã copy]
4. **Click "Continue"** → "Register"

### **Bước 3: Tạo Provisioning Profile mới**
1. **Vào:** Profiles → All
2. **Click "+"** → iOS App Development
3. **Chọn App ID:** com.ppapikey.mobile
4. **Chọn Certificate:** Certificate của bạn
5. **Chọn Devices:** iPhone UDID vừa thêm
6. **Profile Name:** PPAPIKey Mobile Development
7. **Download** Profile

## 🛠️ **Cách fix eSign:**

### **Bước 1: Thêm UDID vào eSign**
1. **Mở eSign**
2. **Vào:** Devices hoặc Device Management
3. **Thêm Device mới:**
   - **Device Name:** iPhone của bạn
   - **Device UDID:** [UDID đã copy]

### **Bước 2: Ký IPA với Profile mới**
1. **Upload IPA** lên eSign
2. **Chọn Provisioning Profile** mới (có UDID)
3. **Chọn Certificate**
4. **Ký IPA**

### **Bước 3: Download và cài đặt**
1. **Download IPA** đã ký từ eSign
2. **Cài đặt** trên iPhone
3. **App sẽ cài đặt thành công**

## ⚠️ **Lưu ý quan trọng:**

### **1. UDID phải chính xác**
- **Copy đúng 40 ký tự**
- **Không có khoảng trắng**
- **Không có ký tự đặc biệt**

### **2. Profile phải được regenerate**
- **Sau khi thêm UDID** vào Apple Developer
- **Tạo Profile mới** chứa UDID
- **Download và cài đặt** Profile

### **3. eSign phải có UDID**
- **Device UDID** phải có trong eSign
- **Ký IPA** với Profile chứa UDID
- **IPA chỉ cài được** trên device có UDID đó

### **4. Giới hạn device**
- **Free Apple ID:** 3 devices
- **Paid Apple ID:** 100 devices
- **Không thể xóa** device đã thêm

## 🎯 **Kết quả:**

Sau khi làm đúng:
1. **UDID có trong Apple Developer**
2. **Profile chứa UDID**
3. **eSign có UDID**
4. **IPA được ký với Profile đúng**
5. **App cài đặt thành công** trên iPhone

## 🔍 **Troubleshooting:**

### **Lỗi "Device not found":**
- Kiểm tra UDID có đúng không
- Kiểm tra UDID có trong Apple Developer không

### **Lỗi "Provisioning Profile":**
- Kiểm tra Profile có chứa UDID không
- Tạo Profile mới chứa UDID

### **Lỗi "App cannot be installed":**
- Kiểm tra eSign có UDID không
- Ký IPA với Profile chứa UDID
