# ======================================================
# TOKENVECTOR MEDIA DOWNLOADER - USER GUIDE
# Author: Tran Nguyen Hung
# GitHub: https://github.com/nguyenhungtran18/TokenVector-Downloader
# Email: nguyen.hung.tran.18@gmail.com
# ======================================================

This folder contains the executables you need:

1. tv-downloader-gui.exe (ultra-lightweight, ~32 KB)
   - Windows: double-click to open the Windows Forms GUI.
   - Linux: mono tv-downloader-gui.exe (requires: mono-runtime, libgdiplus, mono-winforms)
   - macOS: mono tv-downloader-gui.exe (requires: mono-mdk, xquartz)
   - Pure native Windows Forms (GUI subsystem), no black CMD window on Windows.
   - Resolves streams and downloads media directly over TokenVector native HTTP.
   - 100% standalone, NO dependency files or yt-dlp.exe needed.
   - Folder picker, 7 formats (MP4, MKV, WebM, MP3, M4A, WAV, FLAC).
   - STOP button cancels instantly and cleans up partial files.

2. tv-downloader-cli.exe (~25 KB)
   - Windows (CMD/PowerShell):
     tv-downloader-cli.exe <video_link> [c_user] [xs]
   - Linux / macOS:
     mono tv-downloader-cli.exe <video_link> [c_user] [xs]
   - Supports YouTube, Facebook (videos/Reels/fb.watch) and TikTok links.
   - Links missing https:// are completed automatically.
   - Downloaded files: facebook_video.mp4 (Facebook), tiktok_video.mp4 (TikTok).
   - [c_user] [xs] are optional cookies for Facebook videos that need login.

3. Download Facebook videos/Reels (public videos only):
   - Paste the video, Reel or fb.watch link into the URL box and click [ DOWNLOAD ].
   - No login, no cookies, no yt-dlp/ffmpeg needed.
   - If a link has expired and returns a placeholder page, the app fetches
     a fresh link and retries automatically; bad files are deleted.

4. Download TikTok videos:
   - Paste a specific video link (.../video/ID form — /foryou links cannot
     be downloaded because that is a shared feed page) and click [ DOWNLOAD ].
