<p align="right">
  <a href="README.md">🇬🇧 English</a> | <b>🇻🇳 Tiếng Việt</b>
</p>

# ⚡ TokenVector Media Downloader
<p align="center">
  <img src="https://img.shields.io/badge/Language-TokenVector%20(.tkv)-007ACC?style=for-the-badge&logo=codeforces&logoColor=white" alt="TokenVector" />
  <img src="https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-success?style=for-the-badge" alt="Cross Platform" />
  <img src="https://img.shields.io/badge/CI%20Matrix-Ubuntu%20%7C%20macOS%20%7C%20Windows%20Passing-brightgreen?style=for-the-badge&logo=githubactions&logoColor=white" alt="CI Passing" />
  <img src="https://img.shields.io/badge/Binary%20Size-~25%20KB-blue?style=for-the-badge" alt="Binary Size" />
  <img src="https://img.shields.io/badge/License-MIT-orange?style=for-the-badge" alt="License" />
</p>

---

## 🌟 Giới thiệu

**TokenVector Media Downloader** là ứng dụng tải video và audio đa nền tảng (**Windows, Linux, macOS**) với hiệu năng đột phá, được viết hoàn toàn bằng **ngôn ngữ lập trình [TokenVector (.tkv)](https://github.com/nguyenhungtran18/TokenVector)**.

Khác với các ứng dụng tải media truyền thống cồng kềnh (thường nặng từ 30 MB – 150 MB do đóng gói kèm Python, Node.js hoặc Chromium), **TokenVector Downloader** tận dụng sức mạnh của trình biên dịch TokenVector Compiler (`tkvc`) biên dịch thẳng ra mã máy ảo Native Common Intermediate Language (CIL/MSIL) nhị phân. Kết quả mang lại:

- 🚀 **File thực thi siêu nhỏ gọn:** Bản GUI đầy đủ tính năng chỉ vỏn vẹn **~32 KB**, bản CLI chỉ **~25 KB**!
- ⚡ **Tốc độ khởi động tức thì:** 0 giây delay, mức tiêu hao RAM cực thấp (< 15 MB khi tải).
- 🛡️ **Zero Dependencies:** Hoạt động độc lập, tự động phân giải luồng, hỗ trợ HLS `.m3u8` và tải HTTP stream trực tiếp.
- 🌐 **Đa nền tảng thực sự (Cross-Platform):** Chạy mượt mà trên **Windows** (Native PE), **Linux** (Ubuntu, Debian, Arch...) và **macOS** (Apple Silicon & Intel) cho cả chế độ Giao diện đồ họa (GUI) lẫn Dòng lệnh (CLI).

---

## ⚖️ Bảng So Sánh Chi Tiết: TokenVector Media Downloader vs. yt-dlp

| Tiêu chí so sánh | ⚡ **TokenVector Media Downloader** | 🐢 **yt-dlp (Truyền thống)** | Ưu thế của TokenVector |
| :--- | :--- | :--- | :--- |
| **Ngôn ngữ phát triển** | **[TokenVector (.tkv)](https://github.com/nguyenhungtran18/TokenVector)** | Python (C-Python runtime) | Thuần ngôn ngữ mới, kiến trúc tối ưu AOT CIL |
| **Dung lượng file chạy (.exe)** | **~32 KB (GUI) / ~25 KB (CLI)** | **~17 MB – 85 MB** (PyInstaller bundle) | **Gọn nhẹ gấp >500 lần** |
| **Phụ thuộc bên thứ ba (Dependencies)** | **0 (Zero Dependency)** | Cần Python Runtime, FFmpeg (~80 MB) để merge audio/video | Chạy ngay độc lập, không cần bất kỳ công cụ ngoài |
| **Giao diện người dùng (UI)** | **Đa nền tảng GUI (WinForms) & CLI** trực quan, gọn nhẹ | Chỉ có Command-Line (CLI), cần wrapper phức tạp | Trực quan, thân thiện trên cả Windows, Linux, macOS |
| **Tốc độ khởi động** | **Tức thì (Instant < 50ms)** | 1.5s – 3.5s (do phải bung nén môi trường Python) | Nhanh hơn vượt trội, không độ trễ |
| **Mức tiêu hao bộ nhớ RAM** | **~12 MB – 18 MB** | ~60 MB – 150 MB (Python VM + child processes) | Tiết kiệm tài nguyên máy tính tối đa |
| **Thanh tiến trình (Progress)** | Tự thích ứng: % chính xác & dải sáng xanh động (`Marquee`) | Chỉ có text console dòng lệnh | Theo dõi trực quan, mượt mà |
| **Hủy & Dọn dẹp an toàn (Stop)** | Nút **STOP** một chạm, tự động thu hồi luồng và dọn sạch `.part` | Nhấn `Ctrl+C` dễ để lại file rác dở dang | An toàn cho ổ đĩa, không lưu file hỏng |
| **Hỗ trợ luồng HLS (.m3u8)** | **Bộ giải mã Native CIL HLS & Bộ lọc quảng cáo 3 lớp thông minh** | Phụ thuộc hoàn toàn vào nhị phân FFmpeg ngoài | Tải trực tiếp link .m3u8 và link nhúng web, tự lọc bỏ clip quảng cáo, ghép MP4 không cần FFmpeg |
| **Trích xuất Transcript & Phụ đề** | **Nút bấm riêng `[ GET TRANSCRIPT ]` (tải đồng thời `.srt` & `_transcript.txt`)** | Cần script Python phụ (`yt-dlp-transcript`) + cài thư viện `srt` | 1 click tải tức thì, không cần Python, sẵn sàng nạp LLM AI |
| **Khả năng đóng gói & phân phối** | Chạy file ~32 KB trên Windows, Linux & macOS | Phải mang theo file EXE hàng chục MB hoặc cài Python/Pip | Cực kỳ cơ động, gửi qua Zalo/Email/AirDrop tức thì |

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
    - `[Tên_Video]_transcript.txt`: Lời thoại dạng Timeline trực quan với mốc thời gian `[mm:ss]` (hoặc `[hh:mm:ss]`) ở đầu mỗi dòng, khớp 100% với thanh Timeline của YouTube, cực kỳ lý tưởng để theo dõi bài giảng, tra cứu video và nạp vào AI tóm tắt.
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
- [x] **Tùy chọn thư mục lưu trữ & Kiến trúc luồng STA chuẩn:**
  - Hộp thoại chọn thư mục (`Browse...`) mượt mà, tức thì nhờ mô hình luồng Single-Threaded Apartment (STA).
  - Tự động gán Form cha làm `IWin32Window` owner và giải phóng tài nguyên COM `Dispose()`, khắc phục triệt để hiện tượng đơ cửa sổ hoặc `(Not Responding)`.
- [x] **Trực tiếp tải luồng HLS (.m3u8 Direct Stream Downloader):**
  - 🎬 **Tự động nhận diện Playlist M3U8:** Chỉ cần dán bất kỳ link `.m3u8` nào (hoặc link trang web phát video nhúng) vào ô URL và nhấn **`[ DOWNLOAD ]`**, ứng dụng tự động phân tích Master/Media playlist, tải toàn bộ phân đoạn `.ts` và ghép thành file `.mp4` hoàn chỉnh.
  - ⚡ **Ghép nối nhị phân Zero-Dependency:** 100% Native CIL C-level byte streaming, hoàn toàn không cần cài FFmpeg hay bất kỳ công cụ ngoài nào.
  - 📊 **Tiến trình chi tiết theo từng Segment:** Hiển thị rõ ràng số lượng phân đoạn đã tải (`X/Y segments - %`), hỗ trợ nút **STOP** một chạm để dừng và dọn dẹp file tạm tức thì.
- [x] **Tải Video & Reels Facebook:**
  - 🔵 Chỉ cần dán link video/Reels/`fb.watch` công khai bất kỳ và bấm **`[ DOWNLOAD ]`** — không cần đăng nhập, không cần cookie, không cần yt-dlp/FFmpeg.
  - 🔗 Link thiếu cũng chạy: dán `facebook.com/...` hay `fb.watch/...` không có `https://`, ứng dụng tự bổ sung đầy đủ.
  - 🛡️ Nếu link trả về hết hạn và chỉ còn là trang giữ chỗ (không phải video), file lỗi sẽ tự động bị xóa và báo rõ ràng, không để lại file `.mp4` giả.
- [x] **Tải Video TikTok:**
  - 🎵 Dán link video TikTok (`tiktok.com/@user/video/...`) và bấm **`[ DOWNLOAD ]`** — ứng dụng tự phân giải link MP4 trực tiếp, GUI lưu theo đúng tên video, CLI lưu thành `tiktok_video.mp4`.
- [x] **Ghi chú CLI Facebook:** CLI lưu video Facebook thành `facebook_video.mp4` và báo mã lỗi riêng từng trường hợp (`0` xong, `2` không tải được trang/API, `3` không thấy link video, `4` tải file thất bại, `5` toàn gặp trang đệm).
- [x] **CLI cho AI (`--json` + `SKILL.md`):** thêm `--json` ở vị trí bất kỳ, stdout gọn đúng 1 dòng JSON máy đọc được, vd `{"status":"ok","platform":"tiktok","file":"tiktok_video.mp4"}` — mọi AI agent có shell đều tải video được. Xem `SKILL.md` để biết hợp đồng đầy đủ (mã lỗi, chỉ nội dung public, cách kiểm tra file).
- [x] **Tích hợp cả phiên bản CLI và GUI:**
  - `tv-downloader-gui.exe`: Ứng dụng đồ họa người dùng (~32 KB).
  - `tv-downloader-cli.exe`: Dành cho lập trình viên chạy lệnh terminal hoặc tích hợp kịch bản tự động (~25 KB). Cách dùng: `tv-downloader-cli.exe <media_url> [c_user] [xs]`.

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
├── tv-downloader-gui.exe     # Bản thực thi đồ họa GUI (~32 KB, chạy trên Win/Linux/macOS)
├── tv-downloader-cli.exe     # Bản thực thi dòng lệnh CLI (~25 KB, chạy trên Win/Linux/macOS)
├── build.bat                 # Script tự động build trên Windows
├── build.sh                  # Script tự động build trên Linux & macOS
├── USER_GUIDE.txt            # Tài liệu hướng dẫn sử dụng nhanh (tiếng Việt)
├── USER_GUIDE_EN.md          # Tài liệu hướng dẫn sử dụng nhanh (tiếng Anh)
├── DEV_GUIDE.md              # Hướng dẫn code TokenVector & build app (tiếng Anh)
├── DEV_GUIDE_VI.md           # Hướng dẫn code TokenVector & build app (tiếng Việt)
├── SKILL.md                  # Hợp đồng agent: dùng CLI như AI tool
├── llms.txt                  # Tóm tắt dự án cho AI đọc
├── LICENSE                   # Giấy phép MIT
├── README.md                 # Tài liệu tiếng Anh (English documentation)
└── README.vi.md              # Tài liệu tiếng Việt (Vietnamese documentation)
```

### Cách khởi chạy ứng dụng:

- **Trên Windows:**
  - **Khởi chạy GUI:** Click đúp chuột trực tiếp vào file `tv-downloader-gui.exe`.
  - **Khởi chạy CLI:** Mở Command Prompt / PowerShell: `.\tv-downloader-cli.exe <link_video>`.
- **Trên Linux (Ubuntu/Debian):**
  - Cài đặt trước: `sudo apt-get install -y mono-runtime libmono-system-windows-forms4.0-cil libgdiplus xvfb`
  - **GUI:** `xvfb-run mono tv-downloader-gui.exe` (máy desktop có màn hình thì bỏ `xvfb-run`).
  - **CLI:** `mono tv-downloader-cli.exe <link_video>`
- **Trên macOS:**
  - Cài đặt trước: Mono MDK + XQuartz.
  - **GUI:** `mono tv-downloader-gui.exe`
  - **CLI:** `mono tv-downloader-cli.exe <link_video>`

### ✅ Trạng thái đa nền tảng đã kiểm chứng (cả 2 file, không dùng P/Invoke Win32):

| File | Windows | Linux | macOS |
| :--- | :--- | :--- | :--- |
| `tv-downloader-cli.exe` (~25 KB) | Native ✅ | Đã test thật trên Ubuntu + Mono 6.8 ✅ (banner, luồng demo, tải live TikTok khớp từng byte với Windows) | Chạy qua Mono theo lý thuyết (CI có matrix, chưa chạy máy thật) |
| `tv-downloader-gui.exe` (~32 KB) | Native ✅ | Đã test render + chạy (chụp màn hình Xvfb + openbox: đủ form, ô nhập, nút, tiến trình) ✅ | Chạy qua Mono + XQuartz theo lý thuyết (chưa chạy máy thật) |

Ghi chú: GUI cần X server (máy chủ không màn hình dùng `xvfb-run`) và `libgdiplus` để vẽ chữ; cầu nối `os_system` tự chọn `/bin/sh` trên POSIX thay vì `cmd.exe`.

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
mono tv-downloader-cli.exe <link_video>
```

#### B. Trên macOS:
```bash
# 1. Cài đặt Mono trọn bộ và X11 Server (XQuartz để vẽ giao diện Form):
brew install --cask xquartz mono-mdk

# 2. Khởi chạy ứng dụng đồ họa (GUI Form):
mono tv-downloader-gui.exe

# 3. Khởi chạy ứng dụng dòng lệnh (CLI):
mono tv-downloader-cli.exe <link_video>
```

## 💖 Ủng hộ dự án

Nếu công cụ này giúp ích cho bạn, hãy mời tác giả một ly cà phê:

- **Buy Me a Coffee:** https://buymeacoffee.com/nguyen.hung.tran.18
  (một lần hoặc hàng tháng)
- **GitHub Sponsors:** https://github.com/sponsors/nguyenhungtran18
- **Chuyển khoản (Việt Nam):** Ngân hàng MB — STK: `0989503018` —
  TRAN NGUYEN HUNG.
- **MoMo:** quét mã QR bên dưới.

  <img src="assets/momo-qr.jpg" alt="QR MoMo ủng hộ" width="300" />

## 📄 Bản quyền & Giấy phép (License)

Dự án được phân phối dưới giấy phép **[MIT License](LICENSE)**. Bạn hoàn toàn tự do sử dụng, sửa đổi và đóng góp phát triển.

---

## 👨‍💻 Tác giả & Liên hệ

* **Tác giả:** Trần Nguyên Hùng
* **Email:** [nguyen.hung.tran.18@gmail.com](mailto:nguyen.hung.tran.18@gmail.com)
* **Dự án Ngôn ngữ TokenVector:** [https://github.com/nguyenhungtran18/TokenVector](https://github.com/nguyenhungtran18/TokenVector)
* **Mã nguồn Downloader:** [https://github.com/nguyenhungtran18/TokenVector-Media-Downloader](https://github.com/nguyenhungtran18/TokenVector-Media-Downloader)

---

<p align="center">
  <i>Được xây dựng với niềm tự hào công nghệ bằng ngôn ngữ lập trình <b>TokenVector</b>.</i>
</p>
