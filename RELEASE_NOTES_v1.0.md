# TokenVector Media Downloader v1.0 — Release Notes

> Ultra-lightweight media downloader (~32KB) written in TokenVector (.tkv).
> YouTube, Facebook & TikTok on Windows, Linux and macOS. Zero dependencies.

## ✨ Highlights

- **Facebook videos & Reels** — paste a public link, no login, no cookies.
- **TikTok videos** — paste a video link, saved with the video title.
- **YouTube** — formats, HLS streams, one-click transcript + subtitles (SRT).
- **Smart & safe** — bare links auto-completed, bad/expired links detected,
  deleted and retried automatically (up to 10 attempts across qualities).
- **Cross-platform** — Windows native; Linux/macOS via Mono (verified).
- **Zero dependencies** — no Python, yt-dlp or FFmpeg. Single ~32KB file.

## 📦 Assets

| File | Size | SHA256 |
| :--- | :--- | :--- |
| `tv-downloader-gui.exe` | 32,256 bytes | `576D013C6E55609BA6222A2BC31D03F5B631FA7D24FE59D4453B8F9CE9EAF5A3` |
| `tv-downloader-cli.exe` | 26,112 bytes | `F2ADD9E6BD0E5A84362D5040E4CD868340D25098A6BA32BBA3DEDEDA54D4D9A3` |

## 🚀 Quick Start

- **Windows:** double-click the GUI, or
  `tv-downloader-cli.exe <media_url>` for CLI.
- **Linux:** `sudo apt install mono-runtime libmono-system-windows-forms4.0-cil libgdiplus xvfb`
  then `mono tv-downloader-cli.exe <media_url>` (GUI: prefix with `xvfb-run` if headless).
- **macOS:** install Mono MDK + XQuartz, then `mono tv-downloader-*.exe`.

## ⚠️ Limitations

- Public content only — login-walled/private videos and stories are not supported.
- Facebook/TikTok resolving needs internet access to online resolve services.
- TikTok `/foryou` feed links contain no video — use direct `/video/ID` links.

---

# TokenVector Media Downloader v1.0 — Ghi chú phát hành

> Trình tải media siêu nhẹ (~32KB) viết bằng TokenVector (.tkv).
> Tải YouTube, Facebook & TikTok trên Windows, Linux, macOS. Không phụ thuộc.

## ✨ Điểm nổi bật

- **Video & Reels Facebook** — dán link public, không cần đăng nhập/cookie.
- **Video TikTok** — dán link, lưu theo tên video.
- **YouTube** — nhiều định dạng, luồng HLS, lấy phụ đề + transcript 1 click.
- **Thông minh & an toàn** — tự bổ sung link thiếu, phát hiện link hỏng,
  tự xóa file rác và thử lại tới 10 lượt.
- **Đa nền tảng** — Windows native; Linux/macOS qua Mono (đã kiểm chứng).
- **Không phụ thuộc** — không Python, yt-dlp hay FFmpeg. 1 file ~32KB.

## 📦 File tải về

| File | Dung lượng | SHA256 |
| :--- | :--- | :--- |
| `tv-downloader-gui.exe` | 32.256 bytes | xem bảng tiếng Anh ở trên |
| `tv-downloader-cli.exe` | 26.112 bytes | xem bảng tiếng Anh ở trên |

## 🚀 Chạy nhanh

- **Windows:** click đúp GUI, hoặc `tv-downloader-cli.exe <link_video>` cho CLI.
- **Linux:** `sudo apt install mono-runtime libmono-system-windows-forms4.0-cil libgdiplus xvfb`
  rồi `mono tv-downloader-cli.exe <link_video>` (GUI máy không màn hình thêm `xvfb-run`).
- **macOS:** cài Mono MDK + XQuartz rồi `mono tv-downloader-*.exe`.

## ⚠️ Giới hạn

- Chỉ nội dung công khai — video riêng tư/story cần đăng nhập không tải được.
- Tải Facebook/TikTok cần mạng tới dịch vụ resolve online.
- Link TikTok `/foryou` là trang feed chung, phải dùng link `/video/ID` cụ thể.
