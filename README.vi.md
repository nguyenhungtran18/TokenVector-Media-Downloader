<p align="right">
  <a href="README.md">🇬🇧 English</a> | <b>🇻🇳 Tiếng Việt</b>
</p>

# ⚡ TokenVector Media Downloader
<p align="center">
  <img src="https://img.shields.io/badge/Language-TokenVector%20(.tkv)-007ACC?style=for-the-badge&logo=codeforces&logoColor=white" alt="TokenVector" />
  <img src="https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-success?style=for-the-badge" alt="Cross Platform" />
  <img src="https://img.shields.io/badge/CI%20Matrix-Ubuntu%20%7C%20macOS%20%7C%20Windows%20Passing-brightgreen?style=for-the-badge&logo=githubactions&logoColor=white" alt="CI Passing" />
  <img src="https://img.shields.io/badge/Binary%20Size-~22%20KB-blue?style=for-the-badge" alt="Binary Size" />
  <img src="https://img.shields.io/badge/License-MIT-orange?style=for-the-badge" alt="License" />
</p>

---

## 🌟 Giới thiệu

**TokenVector Media Downloader** là ứng dụng tải video và audio đa nền tảng (**Windows, Linux, macOS**) với hiệu năng đột phá, được viết hoàn toàn bằng **ngôn ngữ lập trình [TokenVector (.tkv)](https://github.com/nguyenhungtran18/TokenVector)**.

Khác với các ứng dụng tải media truyền thống cồng kềnh (thường nặng từ 30 MB – 150 MB do đóng gói kèm Python, Node.js hoặc Chromium), **TokenVector Downloader** tận dụng sức mạnh của trình biên dịch TokenVector Compiler (`tkvc`) biên dịch thẳng ra mã máy ảo Native Common Intermediate Language (CIL/MSIL) nhị phân. Kết quả mang lại:

- 🚀 **File thực thi siêu nhỏ gọn:** Toàn bộ ứng dụng đầy đủ tính năng chỉ vỏn vẹn **~22 KB**!
- ⚡ **Tốc độ khởi động tức thì:** 0 giây delay, mức tiêu hao RAM cực thấp (< 15 MB khi tải).
- 🛡️ **Zero Dependencies:** Hoạt động độc lập, tự động phân giải luồng và tải HTTP stream trực tiếp.
- 🌐 **Đa nền tảng thực sự (Cross-Platform):** Chạy mượt mà trên **Windows** (Native PE), **Linux** (Ubuntu, Debian, Arch...) và **macOS** (Apple Silicon & Intel) cho cả chế độ Giao diện đồ họa (GUI) lẫn Dòng lệnh (CLI).

---

## ⚖️ Bảng So Sánh Chi Tiết: TokenVector Media Downloader vs. yt-dlp

| Tiêu chí so sánh | ⚡ **TokenVector Media Downloader** | 🐢 **yt-dlp (Truyền thống)** | Ưu thế của TokenVector |
| :--- | :--- | :--- | :--- |
| **Ngôn ngữ phát triển** | **[TokenVector (.tkv)](https://github.com/nguyenhungtran18/TokenVector)** | Python (C-Python runtime) | Thuần ngôn ngữ mới, kiến trúc tối ưu AOT CIL |
| **Dung lượng file chạy (.exe)** | **~22 KB (22,016 bytes)** | **~17 MB – 85 MB** (PyInstaller bundle) | **Gọn nhẹ gấp >1,000 lần** |
| **Phụ thuộc bên thứ ba (Dependencies)** | **0 (Zero Dependency)** | Cần Python Runtime, FFmpeg (~80 MB) để merge audio/video | Chạy ngay độc lập, không cần bất kỳ công cụ ngoài |
| **Giao diện người dùng (UI)** | **Đa nền tảng GUI (WinForms) & CLI** trực quan, gọn nhẹ | Chỉ có Command-Line (CLI), cần wrapper phức tạp | Trực quan, thân thiện trên cả Windows, Linux, macOS |
| **Tốc độ khởi động** | **Tức thì (Instant < 50ms)** | 1.5s – 3.5s (do phải bung nén môi trường Python) | Nhanh hơn vượt trội, không độ trễ |
| **Mức tiêu hao bộ nhớ RAM** | **~12 MB – 18 MB** | ~60 MB – 150 MB (Python VM + child processes) | Tiết kiệm tài nguyên máy tính tối đa |
| **Thanh tiến trình (Progress)** | Tự thích ứng: % chính xác & dải sáng xanh động (`Marquee`) | Chỉ có text console dòng lệnh | Theo dõi trực quan, mượt mà |
| **Hủy & Dọn dẹp an toàn (Stop)** | Nút **STOP** một chạm, tự động thu hồi luồng và dọn sạch `.part` | Nhấn `Ctrl+C` dễ để lại file rác dở dang | An toàn cho ổ đĩa, không lưu file hỏng |
| **Trích xuất Transcript & Phụ đề** | **Nút bấm riêng `[ GET TRANSCRIPT ]` (tải đồng thời `.srt` & `_transcript.txt`)** | Cần script Python phụ (`yt-dlp-transcript`) + cài thư viện `srt` | 1 click tải tức thì, không cần Python, sẵn sàng nạp LLM AI |
| **Khả năng đóng gói & phân phối** | Chạy file 22 KB trên Windows, Linux & macOS | Phải mang theo file EXE hàng chục MB hoặc cài Python/Pip | Cực kỳ cơ động, gửi qua Zalo/Email/AirDrop tức thì |

> 💡 **Tóm lại:** Nếu `yt-dlp` là một cỗ máy nặng nề đóng gói cả hệ sinh thái Python cồng kềnh phục vụ nghiên cứu phức tạp, thì **TokenVector Media Downloader** là một giải pháp tinh gọn, sắc bén và tối ưu hóa đến từng byte nhị phân: tải nhanh, dung lượng siêu nhẹ, giao diện đẹp và không phụ thuộc bất kỳ runtime nào.

---

## 💎 Điểm cốt lõi: Sức mạnh của Ngôn ngữ TokenVector

[**TokenVector**](https://github.com/nguyenhungtran18/TokenVector) là ngôn ngữ lập trình tiên tiến do **Trần Nguyên Hùng** nghiên cứu và phát triển, mang triết lý cú pháp thanh lịch, khả năng can thiệp trực tiếp vào tầng IL / Assembly và tối ưu hóa nhị phân ở mức tối đa:

* **Tương tác trực tiếp với .NET CLR & Win32 API:** Khởi tạo các thành phần giao diện đồ họa `System.Windows.Forms`, điều khiển thread và luồng mạng HTTP/HTTPS với hiệu năng đỉnh cao.
* **Bộ đệm thông minh High-Throughput:** Xử lý luồng tải mạng với buffer tối ưu 128 KB (`131072` bytes) giúp giảm thiểu context-switching và khai thác tối đa băng thông đường truyền.
* **Cơ chế hủy an toàn (Instant Cancel & Clean):** Cho phép người dùng dừng tác vụ tải bất cứ lúc nào qua nút **STOP**, tự động thu hồi tài nguyên và dọn dẹp các tệp tạm dở dang (`.part`).

---

## ✨ Tính năng nổi bật

- [x] **Nút Bấm Riêng "GET TRANSCRIPT" (Trích xuất Phụ đề & Lời thoại 1 Cú Click):**
  - 🔘 **Thao tác độc lập:** Không cần vào menu chọn định dạng, chỉ cần dán URL và bấm nút **`[ GET TRANSCRIPT ]`** là tải ngay tức thì.
  - 📝 **Tự động xuất đồng thời 2 tệp tin:**
    - `[Tên_Video].srt`: Phụ đề tiêu chuẩn có timestamp chính xác từng mili-giây, tương thích mọi trình phát VLC, YouTube, CapCut, Premiere,...
    - `[Tên_Video]_transcript.txt`: Toàn bộ lời thoại video nối liền dạng văn bản thuần (Full text), cực kỳ lý tưởng để đọc nhanh hoặc đưa vào các mô hình AI (ChatGPT, Claude, Gemini) tóm tắt bài giảng, podcast.
  - ⚡ **Thuần Native TokenVector CIL:** Bắt tay trực tiếp với YouTube InnerTube API (Client Android) để bypass triệt để mã kiểm duyệt PO token (Proof-of-Origin) mà **100% không dùng Python**, không phụ thuộc `yt-dlp.exe` hay FFmpeg. Tốc độ trích xuất tức thì (~1 giây)!
- [x] **Giao diện người dùng chuẩn hóa 100% tiếng Anh (Standardized Clean UI):**
  - Loại bỏ hoàn toàn các lỗi font bảng mã ANSI/Unicode trên Windows Forms cũ.
  - Bố cục 3 nút bấm lớn cân đối: **`[ DOWNLOAD ]`** | **`[ GET TRANSCRIPT ]`** | **`[ STOP ]`**.
  - Ô nhập Video URL để trống mặc định, tiện lợi cho việc copy-paste link mới ngay khi mở ứng dụng.
- [x] **Hỗ trợ đa định dạng Video & Audio:**
  - 🎬 **Video:** `MP4 (480p Standard - Mặc định)`, `MP4 (720p HD)`, `MP4 (1080p Full HD)`, `MKV (1080p High Quality)`, `WebM (Original Quality)`.
  - 🎵 **Audio:** `MP3 (Most Popular, 320kbps)`, `M4A (AAC High Quality)`, `WAV (Lossless Uncompressed)`, `FLAC (Lossless Studio Master)`.
  - 📜 **Phụ đề / Lời thoại:** `Subtitle: Transcript & SRT (.srt & .txt - YouTube Transcript)`.
- [x] **Thanh tiến trình thông minh (Dynamic Adaptive ProgressBar):**
  - Tự động hiển thị chính xác % khi máy chủ trả về `Content-Length`.
  - Chuyển đổi sang hiệu ứng dải sáng động (`ProgressBarStyle.Marquee`) khi tải dạng `Transfer-Encoding: chunked`, liên tục cập nhật dung lượng MB thực nhận.
- [x] **Tùy chọn thư mục lưu trữ:** Cho phép chọn nhanh thư mục lưu tệp tải qua hộp thoại Browse folder trực quan.
- [x] **Tích hợp cả phiên bản CLI và GUI:**
  - `tv-downloader-gui.exe`: Ứng dụng đồ họa người dùng (~22 KB).
  - `tv-downloader-cli.exe`: Dành cho lập trình viên chạy lệnh terminal hoặc tích hợp kịch bản tự động (~16 KB).

---

## 📦 Bộ cài đặt & Cấu trúc

Toàn bộ dự án và ứng dụng đóng gói sẵn:

```text
TokenVector-Media-Downloader/
├── .github/workflows/        # CI/CD Matrix tự động kiểm thử (Ubuntu, macOS, Windows)
├── src/                      # Mã nguồn TokenVector Native (.tkv)
│   ├── gui_runner.tkv        # Điểm vào chính ứng dụng GUI (Entry: run)
│   ├── cli_runner.tkv        # Điểm vào chính ứng dụng CLI (Entry: main)
│   └── core_engine.tkv       # Động cơ điều phối phiên tải, mạng & POSIX Bridge
├── il_features/              # Các module tính năng IL Compiler & GUI WinForms
│   ├── win32_gui_window.tkv  # Giao diện WinForms Native & bộ giải mã luồng
│   └── ...                   # Toàn bộ module thư viện TokenVector IL
├── tv-downloader-gui.exe     # Bản thực thi đồ họa GUI (~22 KB, chạy trên Win/Linux/macOS)
├── tv-downloader-cli.exe     # Bản thực thi dòng lệnh CLI (~16 KB, chạy trên Win/Linux/macOS)
├── build.bat                 # Script tự động build trên Windows
├── build.sh                  # Script tự động build trên Linux & macOS
├── HUONG_DAN.txt             # Tài liệu hướng dẫn sử dụng nhanh
├── LICENSE                   # Giấy phép MIT
├── README.md                 # Tài liệu tiếng Anh (English documentation)
└── README.vi.md              # Tài liệu tiếng Việt (Vietnamese documentation)
```

### Cách khởi chạy ứng dụng:

- **Trên Windows:**
  - **Khởi chạy GUI:** Click đúp chuột trực tiếp vào file `tv-downloader-gui.exe`.
  - **Khởi chạy CLI:** Mở Command Prompt / PowerShell: `.\tv-downloader-cli.exe <link_youtube>`.
- **Trên Linux:**
  - **GUI:** `mono tv-downloader-gui.exe`
  - **CLI:** `mono tv-downloader-cli.exe <link_youtube>`
- **Trên macOS:**
  - **GUI:** `mono tv-downloader-gui.exe`
  - **CLI:** `mono tv-downloader-cli.exe <link_youtube>`

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
### 3. Chạy trên Linux & macOS:
Ứng dụng được biên dịch theo chuẩn **.NET CIL nhị phân**, hỗ trợ chạy cả giao diện đồ họa **GUI (Windows Forms)** và dòng lệnh **CLI** trên Linux và macOS thông qua Mono runtime:

#### A. Trên Linux (Ubuntu / Debian / Linux Mint):
```bash
# 1. Cài đặt Mono runtime và thư viện đồ họa GDI+ / WinForms:
sudo apt-get update
sudo apt-get install -y mono-runtime mono-devel libgdiplus mono-winforms

# 2. Khởi chạy ứng dụng đồ họa (GUI Form):
mono tv-downloader-gui.exe

# 3. Khởi chạy ứng dụng dòng lệnh (CLI):
mono tv-downloader-cli.exe <link_youtube>
```

#### B. Trên macOS:
```bash
# 1. Cài đặt Mono trọn bộ và X11 Server (XQuartz để vẽ giao diện Form):
brew install --cask xquartz mono-mdk

# 2. Khởi chạy ứng dụng đồ họa (GUI Form):
mono tv-downloader-gui.exe

# 3. Khởi chạy ứng dụng dòng lệnh (CLI):
mono tv-downloader-cli.exe <link_youtube>
```

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
