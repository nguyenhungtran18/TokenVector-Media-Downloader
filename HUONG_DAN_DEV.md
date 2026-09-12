# Hướng dẫn viết code TokenVector & build app Token Media Downloader

> Tài liệu này đúc kết từ quá trình phát triển thật trên repo này
> (thêm tải Facebook/TikTok, sửa lỗi đa nền tảng). Chỉ ghi những gì
> đã kiểm chứng chạy được — không ghi lý thuyết suông.

---

## 1. Ngôn ngữ TokenVector (.tkv) — những điều phải biết

File `.tkv` là Python hợp lệ về cú pháp (được parse bằng `ast` của Python),
nhưng **ngữ nghĩa là ngôn ngữ riêng**, biên dịch ra mã máy .NET CIL/MSIL.

### 1.1. Khai báo hàm, biến, kiểu

```python
__tkv_import__ = "core_engine"   # import module .tkv khác (cùng thư mục src/)

def ten_ham(tham: "str", dem: "i32") -> "str":
    ket_qua = tham + str(dem)    # nối chuỗi bằng +
    return ket_qua

def dem_muc(list_hang: "str") -> "i32":  # annotation list? xem 1.4
    ...
```

Các kiểu hay dùng: `"str"`, `"i32"`, `"i64"`, `"f64"`.

**CẤM kỵ (trình biên dịch báo lỗi ngay):**

| Viết sai | Viết đúng | Lý do |
|---|---|---|
| `h: "i32" = 0` | `h = 0` | Khai báo local có kiểu tường minh không được hỗ trợ (trừ một số kiểu đặc biệt) |
| `ord(s[i])` | — (không có hàm này) | Không tồn tại builtin `ord` |
| `foo(lst[i:j])` | `sub = lst[i:j]` rồi `foo(sub)` | Slicing **chỉ** được ở vế phải trực tiếp của phép gán đơn |
| `ten = ham(x) + "!" + ham(y)` | Tách từng bước ra biến trung gian | Nối chuỗi nhiều toán hạng trong 1 biểu thức dễ rủi ro |
| `lst[-i:]` (i là biến) | Chỉ dùng chỉ số âm **hằng số** (`lst[-2:]`) | Chỉ số âm động chưa hỗ trợ |

### 1.2. Chuỗi (string)

Có sẵn: `len(s)`, `s.find(sub)`, `s.find(sub, start)`, `s.startswith(x)`,
`s.endswith(x)`, `s.replace(old, new)`, `s.strip()`, `s.upper()`, `s.lower()`,
slicing `s[a:b]` (xem giới hạn ở trên), `str(x)` (chỉ dùng cho **biến đơn**,
không dùng cho biểu thức phức tạp — muốn chắc thì gán ra biến trước).

Ví dụ tách giá trị giữa 2 marker (mẫu dùng thật trong app):

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

Chuỗi chứa ký tự đặc biệt: `\"` cho dấu nháy (vd `"og:video\" content=\""`),
`"\\/"` cho chuỗi `\` + `/`, `"\\u00253A"` cho mã unicode thoát.

### 1.3. Rẽ nhánh, vòng lặp, lỗi

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

- So sánh số/chuỗi: `==`, `!=`, `<`, `>=`... đều dùng được.
- `try/except Exception:` (có thể `except <Loai>:`) dùng được, kể cả lồng trong `while`.
- `while` + `break`/`continue`/`return` đều ổn.

### 1.4. List, dict

```python
fmts = ["480", "720", "1080"]   # list literal
f = fmts[0]                     # index (chỉ số biến cũng được: fmts[m])
n = len(fmts)

headers = {}                    # dict rỗng
headers["User-Agent"] = "..."   # gán key
ua = headers["User-Agent"]      # đọc key
```

### 1.5. HTTP, file, hệ thống (builtin có sẵn, không cần cài gì)

```python
html = http_get(url)                          # GET -> str (ném lỗi nếu HTTP >= 400)
html2 = http_get_h(url, headers)              # GET kèm dict headers
ok = http_download_file(file_url, out_path)   # tải file -> i32 (1 = xong)
r = http_request("GET", url, "", headers)     # KHÔNG ném lỗi với 4xx
code = r["status"]                            # "200", "404"...
body = r["body"]                              # thân trang

n = http_post(url, payload)                   # POST JSON mặc định
ex = file_exists(path)                        # -> i32 (1/0)
c = read_file(path)                           # đọc toàn bộ file -> str
write_file(path, content)                     # ghi file (dạng lệnh độc lập)
file_delete(path)                             # xóa file (dạng lệnh độc lập)
home = os_getenv("HOME")                      # biến môi trường -> str
rc = os_system(cmd)                           # chạy lệnh shell -> mã thoát i32
pad = thread_sleep(5000)                      # ngủ ms (phải gán vì trả về i32)
args = sys_argv()                             # tham số dòng lệnh, list[str]
```

Lưu ý quan trọng:
- Hàm trả về giá trị (`i32`...) **không được gọi suông** (vd `thread_sleep(5000)`
  một mình sẽ lỗi biên dịch) — phải gán: `pad = thread_sleep(5000)`.
  Ngoại lệ: `print`, `write_file`, `os_system`, `sys_exit` gọi suông được.
- `http_get`/`http_download_file` dùng `WebClient` (.NET) — đã ép TLS hiện đại
  trong mã nguồn compiler của repo này nên HTTPS chạy tốt.
- `os_system` tự chọn shell theo máy: thấy `/bin/sh` thì dùng `-c`,
  không thì dùng `cmd.exe /c` (Windows).

---

## 2. Kiến trúc app Token Media Downloader

```text
src/
  cli_runner.tkv    # app dòng lệnh, entry: main  (đọc sys_argv)
  gui_runner.tkv    # app giao diện, entry: run   (gọi launch_downloader_gui)
  core_engine.tkv   # logic dùng chung: nhận diện URL, resolve, tải
il_features/
  win32_gui_window.tkv  # form WinForms + toàn bộ máy tải (mã CIL nhúng)
  stdlib_http*.tkv      # builtin http_get / http_download_file / ...
  ...                   # các module thư viện TokenVector khác
tv-downloader-gui.exe   # bản phát hành GUI (~32 KB)
tv-downloader-cli.exe   # bản phát hành CLI (~25 KB)
build.bat / build.sh    # script build (cần trình biên dịch tkvc)
```

- **CLI** (`cli_runner.tkv` + hàm trong `core_engine.tkv`): nhận link từ
  `sys_argv`, rẽ nhánh theo loại link (YouTube / Facebook / TikTok), tải xong
  in mã lỗi riêng: `0` xong, `2` không tải được trang/API, `3` không thấy link
  video, `4` tải file thất bại, `5` toàn gặp trang đệm.
- **GUI** (`win32_gui_window.tkv`): form WinForms 600x355 gồm ô URL, thư mục,
  định dạng, 3 nút, tiến trình, trạng thái. Luồng nút Download:
  `m3u8?` → `YouTube?` → `Facebook?` → `TikTok?` → dò luồng web →
  `NOT_HLS` (chọn format → gọi API resolve → poll `progress_url`) →
  `START_STREAM_DOWNLOAD` (tải stream có tiến trình/STOP) →
  kiểm tra nội dung file → đổi tên `.part` thành file chính.
- File tải về đặt theo tiêu đề video đã làm sạch (GUI) hoặc tên cố định
  `facebook_video.mp4` / `tiktok_video.mp4` (CLI).

### Thêm 1 nguồn video mới (mẫu: cách đã làm với Facebook/TikTok)

1. **CLI** (`src/core_engine.tkv`): viết hàm nhận diện
   (`url.find("tenmieng.com") >= 0`), hàm resolve ra URL trực tiếp
   (tái dùng `fb_extract_value` + `fb_unescape_url` cho mọi JSON/HTML),
   rồi tải bằng `http_download_file`. Thêm nhánh gọi trong `main()`
   của `src/cli_runner.tkv`.
2. **GUI** (`il_features/win32_gui_window.tkv`): viết mã CIL nhúng theo mẫu
   các method `static` sẵn có (`HttpGetWithUa`, `ExtractFacebookValue`),
   rồi thêm nhánh `IndexOf(...)` → `br[ s] TEN_NHANH` trong handler Download,
   cuối cùng nhảy vào `START_STREAM_DOWNLOAD` với URL (local 9),
   tiêu đề (local 8), đuôi file (local 4).
3. Quy ước nhãn CIL: đặt tiền tố riêng (vd `FB_`, `TT_`) để không đụng nhãn cũ.

---

## 3. Build app

Cần trình biên dịch **tkvc** của dự án TokenVector
(https://github.com/nguyenhungtran18/TokenVector) — đặt `tkvc.exe`
cạnh `build.bat` (Windows) hoặc `tkvc` cạnh `build.sh` (Linux/macOS).

```powershell
# Windows (từ thư mục gốc repo):
.\build.bat
# Bản lẻ:
tkvc.exe build src\gui_runner.tkv --entry run  --out bin\tv-downloader-gui.exe
tkvc.exe build src\cli_runner.tkv --entry main --out bin\tv-downloader-cli.exe
```

```bash
# Linux / macOS:
./build.sh
```

Bản phát hành nằm ở gốc repo (`tv-downloader-*.exe`): copy từ `bin/` ra
sau khi build xong và kiểm tra chạy thử.

**Chạy đa nền tảng:** file `.exe` là mã CIL thuần (không P/Invoke Win32),
chạy trên Linux/macOS bằng Mono:
`mono tv-downloader-cli.exe <link>`,
GUI cần thêm X server (`xvfb-run` nếu máy không màn hình),
`libmono-system-windows-forms4.0-cil` và `libgdiplus`.

---

## 4. Test

- **Test đơn vị logic .tkv:** tạo file tạm `src/fb_selftest.tkv`
  (`__tkv_import__ = "core_engine"`, entry riêng), build ra `bin/`,
  chạy, **xóa file test sau khi xong** (đừng commit).
- **Test live:** CLI chạy trực tiếp với URL thật; kiểm tra byte đầu file
  (video MP4 bắt đầu bằng `00 00 00 .. 66 74 79 70` = `ftyp`,
  trang HTML lỗi bắt đầu bằng `3C` = `<`).
- **Test Linux:** cài `mono-runtime` trong WSL rồi
  `mono tv-downloader-cli.exe <link>`; GUI thì chạy dưới `Xvfb` và chụp
  màn hình kiểm tra.
- **Test CI:** `.github/workflows/test.yml` chạy exe trên 3 OS.

---

## 5. Bẫy thường gặp (đã vấp thật, đừng lặp lại)

1. **Nhánh ngắn CIL (`br.s`, `bge.s`...) vượt tầm:** chèn thêm mã làm nhãn
   đích trôi xa → `ilasm` báo `too large for 1 byte pcrel`. Sửa: đổi sang
   dạng dài (`br`, `bge`, `brtrue`, `brfalse`).
2. **Trả `i32` trong hàm khai `i64`:** .NET Windows châm chước, Mono ném
   `InvalidProgramException`. Giữ kiểu trả về và giá trị đồng nhất (`i32`).
3. **Thoát khối `try` bằng `br`:** CIL cấm — bắt buộc dùng `leave`.
4. **Thứ tự stack khi nối chuỗi/`Concat`:** giá trị push sau bị lấy ra trước;
   sai thứ tự gây crash `AccessViolation` lúc chạy.
5. **`os_system`/`thread_sleep` gọi suông:** phải gán kết quả vào biến
   (trừ các hàm void đã đăng ký riêng).
6. **Mỗi lần build exe hash khác nhau** (MVID ngẫu nhiên) — so sánh binary
   bằng **kích thước + test chạy**, đừng so hash giữa các lần build.
7. **Đừng xóa file trong repo lúc đang làm** — `src/*.tkv` là mã nguồn duy
   nhất; đã từng mất cả thư mục và phải viết lại. File rác thử nghiệm
   (`*.mp4`, probe) nhớ dọn trước khi commit; thư mục `backup/` đã ignore.
