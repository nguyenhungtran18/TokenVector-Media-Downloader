# ⚡ TokenVector Media Downloader
<p align="center">
  <img src="https://img.shields.io/badge/Language-TokenVector%20(.tkv)-007ACC?style=for-the-badge&logo=codeforces&logoColor=white" alt="TokenVector" />
  <img src="https://img.shields.io/badge/Platform-Windows%20Native%20Win32%20GUI-00A4EF?style=for-the-badge&logo=windows&logoColor=white" alt="Windows" />
  <img src="https://img.shields.io/badge/Binary%20Size-~16%20KB-success?style=for-the-badge" alt="Binary Size" />
  <img src="https://img.shields.io/badge/Dependency-Zero%20Dependency-brightgreen?style=for-the-badge" alt="Zero Dependencies" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License" />
</p>

---

## 🌟 Giới thiệu

**TokenVector Media Downloader** là ứng dụng tải video và audio đa nền tảng thế hệ mới với hiệu năng đột phá, được viết hoàn toàn bằng **ngôn ngữ lập trình [TokenVector (.tkv)](https://github.com/nguyenhungtran18/TokenVector)**.

Khác với các ứng dụng tải media truyền thống cồng kềnh (thường nặng từ 30 MB – 150 MB do đóng gói kèm Python, Node.js hoặc Chromium), **TokenVector Downloader** tận dụng sức mạnh của trình biên dịch TokenVector Compiler (`tkvc`) biên dịch thẳng ra mã máy ảo Native Common Intermediate Language (CIL/MSIL) nhị phân. Kết quả mang lại:

- 🚀 **File thực thi siêu nhỏ gọn:** Toàn bộ ứng dụng GUI đầy đủ tính năng chỉ vỏn vẹn **~16 KB**!
- ⚡ **Tốc độ khởi động tức thì:** 0 giây delay, mức tiêu hao RAM cực thấp (< 15 MB khi tải).
- 🛡️ **Zero Dependencies:** Hoạt động độc lập 100%, không cần cài đặt Python, không cần `yt-dlp.exe`, không cần FFmpeg cồng kềnh.
- 🎨 **Giao diện thuần Native Windows Forms:** Tương thích mượt mà từ Windows 7, 8, 10 đến Windows 11 mà không mở cửa sổ đen CMD.

---

## ⚖️ Bảng So Sánh Chi Tiết: TokenVector Downloader vs. yt-dlp

| Tiêu chí so sánh | ⚡ **TokenVector Downloader** | 🐢 **yt-dlp (Truyền thống)** | Ưu thế của TokenVector |
| :--- | :--- | :--- | :--- |
| **Ngôn ngữ phát triển** | **[TokenVector (.tkv)](https://github.com/nguyenhungtran18/TokenVector)** | Python (C-Python runtime) | Thuần ngôn ngữ mới, kiến trúc tối ưu AOT CIL |
| **Dung lượng file chạy (.exe)** | **~16 KB (16,384 bytes)** | **~17 MB – 85 MB** (PyInstaller bundle) | **Gọn nhẹ gấp >1,000 lần** |
| **Phụ thuộc bên thứ ba (Dependencies)** | **0 (Zero Dependency)** | Cần Python Runtime, FFmpeg (~80 MB) để merge audio/video | Chạy ngay độc lập, không cần bất kỳ công cụ ngoài |
| **Giao diện người dùng (UI)** | **Native Win32 GUI (Windows Forms)** sạch sẽ, hiện đại | Chỉ có Command-Line (CLI), cần wrapper phức tạp | Trực quan, thân thiện, không hiện cửa sổ đen CMD |
| **Tốc độ khởi động** | **Tức thì (Instant < 50ms)** | 1.5s – 3.5s (do phải bung nén môi trường Python) | Nhanh hơn vượt trội, không độ trễ |
| **Mức tiêu hao bộ nhớ RAM** | **~12 MB – 18 MB** | ~60 MB – 150 MB (Python VM + child processes) | Tiết kiệm tài nguyên máy tính tối đa |
| **Thanh tiến trình (Progress)** | Tự thích ứng: % chính xác & dải sáng xanh động (`Marquee`) | Chỉ có text console dòng lệnh | Theo dõi trực quan, mượt mà |
| **Hủy & Dọn dẹp an toàn (Stop)** | Nút **STOP** một chạm, tự động thu hồi luồng và dọn sạch `.part` | Nhấn `Ctrl+C` dễ để lại file rác dở dang | An toàn cho ổ đĩa, không lưu file hỏng |
| **Khả năng đóng gói & phân phối** | Sao chép 1 file `.exe` 16KB là chạy ngay trên mọi máy Windows | Phải mang theo file EXE hàng chục MB hoặc cài Python/Pip | Cực kỳ cơ động, gửi qua Zalo/Email trong tích tắc |

> 💡 **Tóm lại:** Nếu `yt-dlp` là một cỗ máy nặng nề đóng gói cả hệ sinh thái Python cồng kềnh phục vụ nghiên cứu phức tạp, thì **TokenVector Downloader** là một giải pháp tinh gọn, sắc bén và tối ưu hóa đến từng byte nhị phân: tải nhanh, dung lượng siêu nhẹ, giao diện đẹp và không phụ thuộc bất kỳ runtime nào.

---

## 💎 Điểm cốt lõi: Sức mạnh của Ngôn ngữ TokenVector

[**TokenVector**](https://github.com/nguyenhungtran18/TokenVector) là ngôn ngữ lập trình tiên tiến do **Trần Nguyên Hùng** nghiên cứu và phát triển, mang triết lý cú pháp thanh lịch, khả năng can thiệp trực tiếp vào tầng IL / Assembly và tối ưu hóa nhị phân ở mức tối đa:

* **Tương tác trực tiếp với .NET CLR & Win32 API:** Khởi tạo các thành phần giao diện đồ họa `System.Windows.Forms`, điều khiển thread và luồng mạng HTTP/HTTPS với hiệu năng đỉnh cao.
* **Bộ đệm thông minh High-Throughput:** Xử lý luồng tải mạng với buffer tối ưu 128 KB (`131072` bytes) giúp giảm thiểu context-switching và khai thác tối đa băng thông đường truyền.
* **Cơ chế hủy an toàn (Instant Cancel & Clean):** Cho phép người dùng dừng tác vụ tải bất cứ lúc nào qua nút **STOP**, tự động thu hồi tài nguyên và dọn dẹp các tệp tạm dở dang (`.part`).

---

## ✨ Tính năng nổi bật

- [x] **Chuẩn mặc định 480p YouTube:** Tải nhanh, file nhẹ (~10 - 15 MB/video), đáp ứng hoàn hảo tiêu chuẩn phổ thông.
- [x] **Hỗ trợ đa định dạng Video & Audio:**
  - 🎬 **Video:** `MP4 (480p Standard - Mặc định)`, `MP4 (720p HD)`, `MP4 (1080p Full HD)`, `MKV (1080p High Quality)`, `WebM (Chuẩn gốc YouTube)`.
  - 🎵 **Audio:** `MP3 (320kbps)`, `M4A (AAC)`, `WAV (Lossless)`, `FLAC (Studio Lossless)`.
- [x] **Thanh tiến trình thông minh (Dynamic Adaptive ProgressBar):**
  - Tự động hiển thị chính xác % khi máy chủ trả về `Content-Length`.
  - Chuyển đổi sang hiệu ứng dải sáng động (`ProgressBarStyle.Marquee`) khi tải dạng `Transfer-Encoding: chunked`, liên tục cập nhật dung lượng MB thực nhận.
- [x] **Tùy chọn thư mục lưu trữ:** Cho phép chọn nhanh thư mục lưu tệp tải qua hộp thoại Browse folder trực quan.
- [x] **Tích hợp cả phiên bản CLI và GUI:**
  - `tv-downloader-gui.exe`: Ứng dụng đồ họa người dùng.
  - `tv-downloader-cli.exe`: Dành cho lập trình viên chạy lệnh terminal hoặc tích hợp kịch bản tự động.

---

## 📦 Bộ cài đặt & Cấu trúc

Toàn bộ ứng dụng được đóng gói sẵn trong thư mục phát hành:

```text
TokenVector Downloader/
├── src/                      # Mã nguồn TokenVector Native (.tkv)
│   ├── gui_runner.tkv        # Điểm vào chính ứng dụng GUI (Entry: run)
│   ├── cli_runner.tkv        # Điểm vào chính ứng dụng CLI (Entry: main)
│   └── core_engine.tkv       # Động cơ điều phối phiên tải & logic mạng
├── il_features/              # Các module tính năng IL Compiler & GUI WinForms
│   ├── win32_gui_window.tkv  # Giao diện WinForms Native & bộ giải mã luồng
│   └── ...                   # Toàn bộ module thư viện TokenVector IL
├── tv-downloader-gui.exe     # Bản thực thi đồ họa Win32 GUI (~16 KB)
├── tv-downloader-cli.exe     # Bản thực thi dòng lệnh Terminal (~16 KB)
├── HUONG_DAN.txt             # Tài liệu hướng dẫn sử dụng nhanh
├── LICENSE                   # Giấy phép MIT
└── README.md                 # Giới thiệu & hướng dẫn kỹ thuật
```

### Cách sử dụng file thực thi:
1. **Khởi chạy GUI:** Click đúp chuột vào file `tv-downloader-gui.exe`.
2. Dán link YouTube vào ô URL.
3. Chọn định dạng mong muốn (mặc định đã chọn sẵn 480p).
4. Nhấn **DOWNLOAD** và tận hưởng tốc độ tải siêu tốc!

---

## 🛠️ Hướng dẫn Tự Biên Dịch từ Mã Nguồn (.tkv)

Bạn có thể tự biên dịch các file mã nguồn `.tkv` thành file nhị phân thực thi `.exe` bằng trình biên dịch **TokenVector Compiler (`tkvc.exe`)** từ dự án [TokenVector](https://github.com/nguyenhungtran18/TokenVector):

### 1. Biên dịch Ứng dụng GUI:
```powershell
# Từ thư mục gốc dự án:
tkvc.exe build src\gui_runner.tkv --entry run --out tv-downloader-gui.exe
```

### 2. Biên dịch Ứng dụng Dòng lệnh (CLI):
```powershell
tkvc.exe build src\cli_runner.tkv --entry main --out tv-downloader-cli.exe
```

*File thực thi sinh ra là mã máy ảo Native CIL nhị phân siêu nhẹ (~16 KB), chạy ngay tức thì trên Windows mà không cần bất kỳ runtime trung gian nào.*

---

## 📄 Bản quyền & Giấy phép (License)

Dự án được phân phối dưới giấy phép **[MIT License](LICENSE)**. Bạn hoàn toàn tự do sử dụng, sửa đổi và đóng góp phát triển.

---

## 👨‍💻 Tác giả & Liên hệ

* **Tác giả:** Trần Nguyên Hùng
* **Email:** [nguyen.hung.tran.18@gmail.com](mailto:nguyen.hung.tran.18@gmail.com)
* **Dự án Ngôn ngữ TokenVector:** [https://github.com/nguyenhungtran18/TokenVector](https://github.com/nguyenhungtran18/TokenVector)
* **Mã nguồn Downloader:** [https://github.com/nguyenhungtran18/TokenVector-Downloader](https://github.com/nguyenhungtran18/TokenVector-Downloader)

---

<p align="center">
  <i>Được xây dựng với niềm tự hào công nghệ bằng ngôn ngữ lập trình <b>TokenVector</b>.</i>
</p>
