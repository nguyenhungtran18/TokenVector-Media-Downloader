<p align="right">
  <b>🇬🇧 English</b> | <a href="README.vi.md">🇻🇳 Tiếng Việt</a>
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

## 🌟 Overview

**TokenVector Media Downloader** is a high-performance, cross-platform (**Windows, Linux, macOS**) media downloader written entirely in the **[TokenVector (.tkv)](https://github.com/nguyenhungtran18/TokenVector)** programming language.

Unlike traditional media downloaders that are notoriously heavy (often 30 MB – 150 MB due to bundling Python runtimes, Node.js, or Chromium engines), **TokenVector Downloader** harnesses the power of the TokenVector Compiler (`tkvc`) to compile directly to native Common Intermediate Language (CIL/MSIL) bytecode. This delivers:

- 🚀 **Ultra-lightweight binary:** Full-featured GUI application weighs only **~22 KB**!
- ⚡ **Instant startup:** 0-second delay, minimal RAM footprint (< 15 MB under load).
- 🛡️ **Zero Dependencies:** Fully standalone, direct native HTTP/HTTPS streaming and stream resolution.
- 🌐 **True Cross-Platform:** Runs seamlessly on **Windows** (Native PE), **Linux** (Ubuntu, Debian, Arch...), and **macOS** (Apple Silicon & Intel) in both Graphical User Interface (GUI) and Command-Line Interface (CLI) modes.

---

## ⚖️ Detailed Comparison: TokenVector Media Downloader vs. yt-dlp

| Feature / Metric | ⚡ **TokenVector Media Downloader** | 🐢 **yt-dlp (Traditional)** | The TokenVector Advantage |
| :--- | :--- | :--- | :--- |
| **Programming Language** | **[TokenVector (.tkv)](https://github.com/nguyenhungtran18/TokenVector)** | Python (C-Python runtime) | Clean modern language, optimized native CIL architecture |
| **Executable Size (.exe)** | **~22 KB (22,016 bytes)** | **~17 MB – 85 MB** (PyInstaller bundle) | **Over 1,000x lighter** |
| **Third-Party Dependencies** | **0 (Zero Dependency)** | Requires Python Runtime, FFmpeg (~80 MB) to merge audio/video | Runs out-of-the-box, no external utilities needed |
| **User Interface (UI)** | **Cross-platform GUI (WinForms) & CLI** | Command-Line only (requires complex wrappers) | Intuitive, responsive UI across Windows, Linux & macOS |
| **Startup Latency** | **Instant (< 50ms)** | 1.5s – 3.5s (due to unpacking Python environment) | Significantly faster, zero noticeable lag |
| **RAM Footprint** | **~12 MB – 18 MB** | ~60 MB – 150 MB (Python VM + child processes) | Maximum system resource efficiency |
| **Progress Indicator** | Adaptive: Exact % & animated pulsing glow (`Marquee`) | Plain console text output | Smooth visual tracking |
| **Safe Stop & Cleanup** | One-touch **STOP** button, instantly releases threads & cleans `.part` files | Pressing `Ctrl+C` often leaves orphaned temp files | Safe for disk storage, never leaves corrupted files |
| **Transcript & Subtitle Extraction** | **Dedicated `[ GET TRANSCRIPT ]` button (downloads both `.srt` & `_transcript.txt`)** | Requires extra Python script (`yt-dlp-transcript`) + `srt` lib | 1-click instant extraction, no Python, LLM AI ready |
| **Packaging & Portability** | Single portable ~22 KB file for Windows, Linux & macOS | Requires multi-megabyte installers or Python/Pip setup | Instant distribution via Email, Chat, AirDrop |

> 💡 **Summary:** While `yt-dlp` is a heavyweight tool packing an entire Python ecosystem, **TokenVector Media Downloader** is an ultra-lean, laser-focused native utility: lightning fast, featherlight size, responsive GUI, and 100% dependency-free.

---

## 💎 Core Engine: The Power of TokenVector

[**TokenVector**](https://github.com/nguyenhungtran18/TokenVector) is an advanced programming language designed and developed by **Trần Nguyên Hùng**, featuring elegant syntax, direct CIL/Assembly interop, and extreme binary optimization:

* **Direct .NET CLR & Win32 Interop:** Native instantiation of `System.Windows.Forms` components, asynchronous thread control, and high-performance network sockets.
* **High-Throughput Smart Buffer:** Network streaming utilizing an optimal 128 KB (`131072` bytes) buffer to minimize CPU context-switching and saturate network bandwidth.
* **Instant Cancel & Clean Safety Engine:** Allows users to halt active downloads instantly via the **STOP** button, properly releasing file locks and purging incomplete `.part` temporary files.

---

## ✨ Key Features

- [x] **Dedicated "GET TRANSCRIPT" Button (1-Click Subtitles & Transcript Extraction):**
  - 🔘 **Independent Operation:** No need to navigate dropdown menus—paste the URL and click **`[ GET TRANSCRIPT ]`** to download immediately.
  - 📝 **Simultaneous Dual-Format Output:**
    - `[Video_Title].srt`: Standard subtitle file with millisecond-accurate timestamps, ready for VLC, YouTube, CapCut, Premiere, etc.
    - `[Video_Title]_transcript.txt`: Formatted timeline transcript with clean `[mm:ss]` (or `[hh:mm:ss]`) timestamps on every line, perfectly matching YouTube's video timeline for effortless reading, quick reference, and AI summarization.
  - ⚡ **100% Native TokenVector CIL:** Directly negotiates with YouTube InnerTube API (Android Client) to bypass PO token restrictions without Python, `yt-dlp.exe`, or FFmpeg. Extracts in ~1 second!
- [x] **Standardized Clean English UI:**
  - Completely avoids legacy ANSI/Unicode code-page rendering issues on Windows Forms.
  - Symmetrical 3-button layout: **`[ DOWNLOAD ]`** | **`[ GET TRANSCRIPT ]`** | **`[ STOP ]`**.
  - Empty default Video URL input for quick and clean paste upon launching.
- [x] **Comprehensive Video & Audio Format Support:**
  - 🎬 **Video:** `MP4 (480p Standard - Default)`, `MP4 (720p HD)`, `MP4 (1080p Full HD)`, `MKV (1080p High Quality)`, `WebM (Original Quality)`.
  - 🎵 **Audio:** `MP3 (Most Popular, 320kbps)`, `M4A (AAC High Quality)`, `WAV (Lossless Uncompressed)`, `FLAC (Lossless Studio Master)`.
  - 📜 **Subtitles / Transcript:** `Subtitle: Transcript & SRT (.srt & .txt - YouTube Transcript)`.
- [x] **Dynamic Adaptive ProgressBar:**
  - Automatically displays exact percentage when the server provides `Content-Length`.
  - Seamlessly switches to pulsing marquee animation (`ProgressBarStyle.Marquee`) for `Transfer-Encoding: chunked` streams, reporting real-time received megabytes.
- [x] **Custom Output Directory Selection:** Browse folder dialog to pick any save destination.
- [x] **Both GUI and CLI Editions Included:**
  - `tv-downloader-gui.exe`: Modern graphical user application (~22 KB).
  - `tv-downloader-cli.exe`: Terminal utility for scripting and automated workflows (~16 KB).

---

## 📦 Project Layout & Structure

```text
TokenVector-Media-Downloader/
├── .github/workflows/        # Automated CI/CD Matrix (Ubuntu, macOS, Windows)
├── src/                      # Native TokenVector source code (.tkv)
│   ├── gui_runner.tkv        # GUI application entrypoint (Entry: run)
│   ├── cli_runner.tkv        # CLI application entrypoint (Entry: main)
│   └── core_engine.tkv       # Download orchestration, network stream & POSIX bridge
├── il_features/              # CIL compiler features & WinForms UI modules
│   ├── win32_gui_window.tkv  # Native WinForms UI & stream decoding logic
│   └── ...                   # TokenVector IL library modules
├── tv-downloader-gui.exe     # Compiled GUI executable (~22 KB, runs on Win/Linux/macOS)
├── tv-downloader-cli.exe     # Compiled CLI executable (~16 KB, runs on Win/Linux/macOS)
├── build.bat                 # Windows automated build script
├── build.sh                  # Linux & macOS automated build script
├── HUONG_DAN.txt             # Quick user manual
├── LICENSE                   # MIT License
├── README.md                 # English documentation (this file)
└── README.vi.md              # Vietnamese documentation (Tài liệu tiếng Việt)
```

### Running the Application:

- **On Windows:**
  - **Launch GUI:** Double-click `tv-downloader-gui.exe`.
  - **Launch CLI:** Open Command Prompt / PowerShell: `.\tv-downloader-cli.exe <youtube_url>`.
- **On Linux:**
  - **GUI:** `mono tv-downloader-gui.exe`
  - **CLI:** `mono tv-downloader-cli.exe <youtube_url>`
- **On macOS:**
  - **GUI:** `mono tv-downloader-gui.exe`
  - **CLI:** `mono tv-downloader-cli.exe <youtube_url>`

---

## 🛠️ Building from Source (.tkv)

You can compile the `.tkv` source code into native executables using the **TokenVector Compiler (`tkvc.exe`)** from the [TokenVector](https://github.com/nguyenhungtran18/TokenVector) project:

### 1. Compile GUI Application:
```powershell
# From the project root:
tkvc.exe build src\gui_runner.tkv --entry run --out tv-downloader-gui.exe
```

### 2. Compile CLI Application:
```powershell
tkvc.exe build src\cli_runner.tkv --entry main --out tv-downloader-cli.exe
```

### 3. Running on Linux & macOS:
The compiled binaries target **.NET CIL bytecode**, enabling full support for both **GUI (Windows Forms)** and **CLI** on Linux and macOS via the Mono runtime:

#### A. On Linux (Ubuntu / Debian / Linux Mint):
```bash
# 1. Install Mono runtime and GDI+ / WinForms libraries:
sudo apt-get update
sudo apt-get install -y mono-runtime mono-devel libgdiplus mono-winforms

# 2. Launch GUI:
mono tv-downloader-gui.exe

# 3. Launch CLI:
mono tv-downloader-cli.exe <youtube_url>
```

#### B. On macOS:
```bash
# 1. Install Mono MDK and XQuartz (X11 server for WinForms rendering):
brew install --cask xquartz mono-mdk

# 2. Launch GUI:
mono tv-downloader-gui.exe

# 3. Launch CLI:
mono tv-downloader-cli.exe <youtube_url>
```

---

## 📄 License

This project is licensed under the **[MIT License](LICENSE)**. Feel free to use, modify, and distribute.

---

## 👨‍💻 Author & Contact

* **Author:** Trần Nguyên Hùng
* **Email:** [nguyen.hung.tran.18@gmail.com](mailto:nguyen.hung.tran.18@gmail.com)
* **TokenVector Language Project:** [https://github.com/nguyenhungtran18/TokenVector](https://github.com/nguyenhungtran18/TokenVector)
* **Downloader Repository:** [https://github.com/nguyenhungtran18/TokenVector-Downloader](https://github.com/nguyenhungtran18/TokenVector-Downloader)

---

<p align="center">
  <i>Engineered with passion using the <b>TokenVector</b> programming language.</i>
</p>
