# TokenVector Coding & Token Media Downloader Build Guide

> Lessons distilled from real development on this repo
> (adding Facebook/TikTok downloads, fixing cross-platform issues).
> Only what has been verified to work — no armchair theory.

---

## 1. The TokenVector Language (.tkv) — Must-Knows

A `.tkv` file is valid Python syntax (parsed by Python's `ast`), but its
**semantics belong to a separate language** that compiles to .NET CIL/MSIL.

### 1.1. Functions, Variables, Types

```python
__tkv_import__ = "core_engine"   # import another .tkv module (same src/ dir)

def func_name(param: "str", count: "i32") -> "str":
    result = param + str(count)  # concatenate strings with +
    return result
```

Common types: `"str"`, `"i32"`, `"i64"`, `"f64"`.

**FORBIDDEN (the compiler rejects them immediately):**

| Wrong | Right | Why |
|---|---|---|
| `h: "i32" = 0` | `h = 0` | Explicitly typed locals are not supported (except a few special types) |
| `ord(s[i])` | — (does not exist) | There is no `ord` builtin |
| `foo(lst[i:j])` | `sub = lst[i:j]` then `foo(sub)` | Slicing is allowed **only** as the direct right-hand side of a simple assignment |
| `name = f(x) + "!" + g(y)` | Split into intermediate variables | Multi-operand concatenation in one expression is risky |
| `lst[-i:]` (`i` a variable) | Only **constant** negative indices (`lst[-2:]`) | Dynamic negative indices are unsupported |

### 1.2. Strings

Available: `len(s)`, `s.find(sub)`, `s.find(sub, start)`,
`s.startswith(x)`, `s.endswith(x)`, `s.replace(old, new)`, `s.strip()`,
`s.upper()`, `s.lower()`, slicing `s[a:b]` (see limits above),
`str(x)` (single **variables** only, not complex expressions —
assign to a variable first to be safe).

Example — extract a value between two markers (pattern really used in the app):

```python
def fb_extract_value(html: "str", marker: "str", from_pos: "i32") -> "str":
    mpos = html.find(marker, from_pos)
    if mpos < 0:
        return ""
    vstart = mpos + len(marker)
    vend = html.find("\"", vstart)
    if vend < 0:
        return ""
    part = html[vstart:vend]
    return part
```

Special characters in literals: `\"` for quotes (e.g. `"og:video\" content=\""`),
`"\\/"` for backslash + slash, `"\\u00253A"` for escaped unicode.

### 1.3. Branching, Loops, Errors

```python
if a == 1:
    ...
elif a == 2:
    ...
else:
    ...

i = 0
while i < 10:
    i = i + 1

try:
    html = http_get(url)
except Exception:
    return 2
```

- Number/string comparison: `==`, `!=`, `<`, `>=`... all fine.
- `try/except Exception:` (or `except <Type>:`) works, even nested in `while`.
- `while` + `break`/`continue`/`return` all fine.

### 1.4. Lists, Dicts

```python
fmts = ["480", "720", "1080"]   # list literal
f = fmts[0]                     # indexing (variable index works too: fmts[m])
n = len(fmts)

headers = {}                    # empty dict
headers["User-Agent"] = "..."   # set key
ua = headers["User-Agent"]      # read key
```

### 1.5. HTTP, Files, System (builtins, nothing to install)

```python
html = http_get(url)                          # GET -> str (throws on HTTP >= 400)
html2 = http_get_h(url, headers)              # GET with headers dict
ok = http_download_file(file_url, out_path)   # download file -> i32 (1 = done)
r = http_request("GET", url, "", headers)     # does NOT throw on 4xx
code = r["status"]                            # "200", "404"...
body = r["body"]                              # response body

n = http_post(url, payload)                   # POST, JSON by default
ex = file_exists(path)                        # -> i32 (1/0)
c = read_file(path)                           # read whole file -> str
write_file(path, content)                     # write file (standalone statement)
file_delete(path)                             # delete file (standalone statement)
home = os_getenv("HOME")                      # env var -> str
rc = os_system(cmd)                           # run shell command -> exit code i32
pad = thread_sleep(5000)                      # sleep ms (must assign: returns i32)
args = sys_argv()                             # CLI args, list[str]
```

Important notes:
- Functions returning a value (`i32`...) **cannot be called bare**
  (e.g. lone `thread_sleep(5000)` is a compile error) — assign it:
  `pad = thread_sleep(5000)`. Exceptions: `print`, `write_file`,
  `os_system`, `sys_exit` may be called bare.
- `http_get`/`http_download_file` use .NET `WebClient` — modern TLS is
  enforced in this repo's compiler code, so HTTPS works fine.
- `os_system` auto-selects the shell: uses `/bin/sh -c` when it exists,
  otherwise `cmd.exe /c` (Windows).

---

## 2. Token Media Downloader Architecture

```text
src/
  cli_runner.tkv    # CLI app, entry: main  (reads sys_argv)
  gui_runner.tkv    # GUI app, entry: run   (calls launch_downloader_gui)
  core_engine.tkv   # shared logic: URL detection, resolving, downloading
il_features/
  win32_gui_window.tkv  # WinForms UI + download engine (embedded CIL)
  stdlib_http*.tkv      # http_get / http_download_file / ... builtins
  ...                   # other TokenVector IL library modules
tv-downloader-gui.exe   # GUI release (~32 KB)
tv-downloader-cli.exe   # CLI release (~25 KB)
build.bat / build.sh    # build scripts (need the tkvc compiler)
```

- **CLI** (`cli_runner.tkv` + functions in `core_engine.tkv`): reads the link
  from `sys_argv`, branches by link type (YouTube / Facebook / TikTok),
  downloads, prints a distinct error code: `0` done, `2` page/API
  unreachable, `3` no video link found, `4` file download failed,
  `5` placeholder pages on every attempt.
- **GUI** (`win32_gui_window.tkv`): 600x355 WinForms form with URL box,
  folder box, format picker, 3 buttons, progress bar, status label.
  Download-button flow: `.m3u8?` → `YouTube?` → `Facebook?` → `TikTok?` →
  webpage sniffing → `NOT_HLS` (format select → API resolve → poll
  `progress_url`) → `START_STREAM_DOWNLOAD` (stream download with
  progress/STOP) → file content check → rename `.part` to final file.
- Downloads are named after the sanitized video title (GUI) or fixed names
  `facebook_video.mp4` / `tiktok_video.mp4` (CLI).

### Adding a New Video Source (as done for Facebook/TikTok)

1. **CLI** (`src/core_engine.tkv`): write a detector
   (`url.find("somesite.com") >= 0`), a resolver to a direct URL
   (reuse `fb_extract_value` + `fb_unescape_url` for any JSON/HTML),
   then download with `http_download_file`. Add the calling branch in
   `main()` of `src/cli_runner.tkv`.
2. **GUI** (`il_features/win32_gui_window.tkv`): write embedded-CIL code
   following the existing `static` helpers (`HttpGetWithUa`,
   `ExtractFacebookValue`), then add an `IndexOf(...)` branch in the
   Download handler that ends at `START_STREAM_DOWNLOAD` with URL
   (local 9), title (local 8), extension (local 4).
3. Label convention: use a unique prefix (`FB_`, `TT_`) to avoid collisions.

---

## 3. Building the App

You need the **tkvc** compiler from the TokenVector project
(https://github.com/nguyenhungtran18/TokenVector) — place `tkvc.exe`
next to `build.bat` (Windows) or `tkvc` next to `build.sh` (Linux/macOS).

```powershell
# Windows (from the repo root):
.\build.bat
# Single targets:
tkvc.exe build src\gui_runner.tkv --entry run  --out bin\tv-downloader-gui.exe
tkvc.exe build src\cli_runner.tkv --entry main --out bin\tv-downloader-cli.exe
```

```bash
# Linux / macOS:
./build.sh
```

Release binaries live at the repo root (`tv-downloader-*.exe`): copy them
out of `bin/` after a successful build and smoke test.

**Cross-platform:** the `.exe` files are pure CIL bytecode (no Win32
P/Invoke) and run on Linux/macOS via Mono:
`mono tv-downloader-cli.exe <link>`.
The GUI additionally needs an X server (`xvfb-run` on headless machines),
`libmono-system-windows-forms4.0-cil` and `libgdiplus`.

---

## 4. Testing

- **Unit-test .tkv logic:** create a temporary `src/fb_selftest.tkv`
  (`__tkv_import__ = "core_engine"`, own entry point), build into `bin/`,
  run it, **delete the test file afterwards** (never commit it).
- **Live test:** run the CLI with a real URL; verify the first bytes of the
  file (real MP4 starts with `00 00 00 .. 66 74 79 70` = `ftyp`,
  an error HTML page starts with `3C` = `<`).
- **Linux test:** install `mono-runtime` in WSL, then
  `mono tv-downloader-cli.exe <link>`; for the GUI, run under `Xvfb`
  and screenshot to verify rendering.
- **CI:** `.github/workflows/test.yml` runs the exe on 3 OSes.

---

## 5. Common Pitfalls (all hit for real — don't repeat them)

1. **Short CIL branches (`br.s`, `bge.s`...) out of range:** inserting code
   pushes the target label away → `ilasm` reports
   `too large for 1 byte pcrel`. Fix: switch to the long form
   (`br`, `bge`, `brtrue`, `brfalse`).
2. **Returning `i32` from a function declared `i64`:** tolerated by .NET on
   Windows, rejected by Mono with `InvalidProgramException`. Keep return
   types and values consistent (`i32`).
3. **Leaving a `try` block with `br`:** CIL forbids it — always use `leave`.
4. **Stack order in concatenation/`Concat`:** last pushed is popped first;
   wrong order crashes with `AccessViolation` at runtime.
5. **Bare calls to value-returning builtins:** assign the result to a
   variable (except `void` builtins registered for statement use).
6. **Every exe build gets a different hash** (random MVID) — compare binaries
   by **size + runtime test**, never by hash across builds.
7. **Don't delete files in the repo while working** — `src/*.tkv` is the only
   copy of the source; a whole directory was once lost and rewritten.
   Clean up test artifacts (`*.mp4`, probes) before committing;
   the `backup/` directory is ignored.
