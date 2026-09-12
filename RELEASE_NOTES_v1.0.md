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

