# TokenVector Media Downloader — Agent Skill

> Give AI assistants a reliable way to download public videos
> (YouTube via GUI, Facebook/TikTok via CLI) without Python or yt-dlp.

## When to Use

Use this skill when the user asks to **download or save a video** from
YouTube, Facebook (video/Reel/`fb.watch`) or TikTok, or to **fetch video
info** for one of those links.

## Tool: `tv-downloader-cli.exe`

Single portable binary (~25 KB, .NET CIL). Runs on Windows natively,
on Linux/macOS via `mono`. Working directory = output directory.

### Human mode (default)

```powershell
tv-downloader-cli.exe "<media_url>" [c_user] [xs]
```

- Facebook: `facebook_video.mp4` (+ optional login cookies as 2 extra args).
- TikTok: `tiktok_video.mp4`.
- Exit code mirrors the outcome (`0` ok).

### JSON mode (preferred for agents)

Add `--json` in any position. **Stdout is exactly one JSON line**
(a trailing bare return code may follow on its own line — ignore it):

```powershell
tv-downloader-cli.exe --json "<media_url>"
# {"status":"ok","platform":"tiktok","file":"tiktok_video.mp4"}
# {"status":"error","platform":"facebook","code":3,"message":"No video link found"}
```

Schema: `status` = `ok` | `error`; `platform` = `facebook` | `tiktok` |
`unknown`; on success `file` = downloaded filename; on error `code` +
`message`:

| code | meaning |
| :--- | :--- |
| 0 | success (with `status: ok`) |
| 2 | page/API unreachable (network or blocked) |
| 3 | no video link found (non-public content) |
| 4 | file download failed |
| 5 | placeholder ad pages on every attempt (retry later) |
| 6 | JSON mode supports facebook and tiktok links only |

## Rules for Agents

1. **Public content only.** Login-walled/private videos and stories cannot
   be downloaded — report this instead of retrying blindly.
2. **TikTok needs a direct video link** (`.../video/<ID>`). A `/foryou`
   feed link contains no video — ask the user for the specific video link.
3. **Bare links are fine** (`facebook.com/...` without `https://` works).
4. **Verify the file**: a real MP4 starts with bytes `00 00 00 .. 66 74 79 70`
   (`ftyp`); anything starting with `3C` (`<`) is an HTML error page.
5. Facebook downloads may take minutes (up to 10 automatic attempts);
   prefer JSON mode and wait instead of re-issuing the command.
6. Never invent `c_user`/`xs` cookie values — only use ones the user pasted.

## GUI

For interactive use prefer `tv-downloader-gui.exe` (YouTube formats, HLS,
transcripts, progress bar, STOP button). The CLI covers Facebook/TikTok;
YouTube downloading is GUI territory.
