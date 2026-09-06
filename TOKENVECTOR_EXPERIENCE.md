# Tổng Hợp Lỗi & Kinh Nghiệm Lập Trình Với TokenVector (tkvc)

Tài liệu này đúc kết toàn bộ các lỗi biên dịch thực tế và kinh nghiệm kỹ thuật rút ra trong quá trình phát triển dự án với ngôn ngữ **TokenVector Native (`.tkv`)** và trình biên dịch **`tkvc.exe`** ([`nguyenhungtran18/TokenVector`](https://github.com/nguyenhungtran18/TokenVector)).

---

## 1. Hạn Chế Logic Ở Module Level (Top-Level Scope)

### Lỗi thường gặp:
```text
[tkv] Loi: Chi ho tro dinh nghia ham/class-record top-level, HANG SO cap module (vd MAX = 10), (va '__tkv_import__') trong 1 file TokenVector; gap If o dong ...
```

### Nguyên nhân:
TokenVector biên dịch mã nguồn thẳng sang cấu trúc tĩnh của .NET Common Intermediate Language (CIL). Parser của TokenVector không hỗ trợ các lệnh thực thi tự do ở phạm vi ngoài hàm/class như trình thông dịch Python.

### Quy tắc khắc phục:
- **Tuyệt đối không sử dụng:** Khối `if __name__ == "__main__":` hoặc các câu lệnh chạy tự do ngoài hàm.
- **Phạm vi module chỉ được chứa:**
  - Import module: `__tkv_import__ = "module_name"`
  - Khai báo Assembly ngoại vi: `__tkv_extern_assembly__ = ["System.Drawing", "System.Windows.Forms"]`
  - Hằng số cấp module (tên biến viết hoa toàn bộ): `BUFFER_SIZE = 65536`

  - Định nghĩa hàm: `def function_name(...) -> "...":`
  - Định nghĩa lớp/record: `class RecordName:`
- **Điểm vào (Entry Point):** Được chỉ định thông qua tham số CLI của compiler:
  ```cmd
  tkvc build src/cli_runner.tkv --entry main --out bin/app.exe
  ```

---

## 2. Quy Chuẩn Định Nghĩa Class (Record Struct Model)

### Lỗi thường gặp:
```text
[tkv] Loi: class 'PosixRuntimeBridge': record khong co field nao
SyntaxError: il_codegen: record 'TransferMetricsCalculator' can 2 tham so (alpha, smoothed_speed), gap 0
```

### Nguyên nhân:
Trong TokenVector, từ khóa `class` thực chất biểu diễn một **CIL Typed Record / Struct**. Trình sinh mã (`il_codegen`) yêu cầu:
1. Mỗi record bắt buộc phải khai báo ít nhất một trường dữ liệu (field) có định kiểu rõ ràng ở đầu class.
2. Trình biên dịch tự động sinh ra một **Positional Constructor** nhận đúng và đủ tất cả các trường theo thứ tự khai báo.

### Quy tắc khắc phục:
```TokenVector
# 1. Khai báo đúng chuẩn:
class TransferMetricsCalculator:
    alpha: "f64"
    smoothed_speed: "f64"

    def record_transfer(self, delta: "i64") -> "f64":
        return self.smoothed_speed

# 2. Khởi tạo instance (bắt buộc truyền đủ tham số):
calc = TransferMetricsCalculator(0.2, 0.0)
```

---

## 3. Hệ Thống Kiểu Vô Hướng (Unboxed Scalar Types)

### Lỗi thường gặp:
```text
[tkv] Loi: class '...' field '...': dtype 'bool' khong hop le (vo huong: ['f32', 'f64', 'i32', 'i64', 'int', 'str']...)
```

### Nguyên nhân:
Hệ thống kiểu của TokenVector tập trung vào hiệu năng cao không cấp phát heap (Zero heap boxing). Kiểu `bool` không nằm trong danh mục kiểu vô hướng hỗ trợ mà được ánh xạ qua số nguyên 32-bit.

### Bảng kiểu vô hướng hợp lệ:
| Kiểu DSL | Kiểu .NET CIL Tương Ứng | Miền Giá Trị / Ý Nghĩa |
| :--- | :--- | :--- |
| `"i32"` | `int32` | Số nguyên 32-bit (dùng thay thế cho cả logic `bool`: `1` = True, `0` = False). |
| `"i64"` | `int64` | Số nguyên 64-bit cho kích thước file, offset byte lớn. |
| `"int"` | `TkvInt` | Số nguyên lớn (BigInteger). |
| `"f32"` | `float32` | Số thực đơn 32-bit. |
| `"f64"` | `float64` | Số thực kép 64-bit cho tính toán tốc độ mạng, thời gian. |
| `"str"` | `string` | Chuỗi ký tự UTF-8 bất biến. |

---

## 4. Yêu Cầu Về Hàm Top-Level Và Giá Trị Trả Về

### Lỗi thường gặp:
```text
[tkv] Loi: File khong co ham top-level nao co annotation kieu DSL
SyntaxError: il_codegen: khong dich duoc dong: 'return'
```

### Nguyên nhân:
- `tkvc.exe` yêu cầu mỗi tệp `.tkv` phải chứa ít nhất một hàm ở phạm vi ngoài cùng (top-level) có chú thích kiểu trả về để neo giữ bảng phương thức CIL.
- Trong các hàm có định kiểu, lệnh `return` trần (không có giá trị) bị coi là cú pháp không hợp lệ.

### Quy tắc khắc phục:
- Luôn đảm bảo mỗi file có hàm top-level:
  ```TokenVector
  def init_module() -> "i32":
      return 1
  ```
- Luôn trả về giá trị khớp với kiểu dữ liệu đã khai báo:
  - Kiểu `"i32"` / `"i64"`: `return 0`
  - Kiểu `"str"`: `return ""`
  - Kiểu `"f64"`: `return 0.0`

---

## 5. Cơ Chế Tìm Kiếm & Phân Giải Import (`__tkv_import__`)

### Lỗi thường gặp:
```text
[tkv] Loi: file '...': import module 'core_engine' khong tim thay trong thu muc hien tai hoac site-packages
```

### Nguyên nhân:
`tkvc.exe` tìm kiếm các tệp `.tkv` được import tương đối dựa trên **Current Working Directory (CWD)** tại thời điểm gọi lệnh shell, thay vì dựa theo thư mục chứa file nguồn.

### Quy tắc khắc phục:
Khi biên dịch các module phụ thuộc lẫn nhau nằm trong thư mục con (ví dụ `src/`):
```cmd
:: Di chuyển vào thư mục chứa module trước khi gọi build
cd src
..\tkvc.exe build cli_runner.tkv --entry main --out ..\bin\tv-downloader-cli.exe
cd ..
```

---

## 6. Tạo Thư Mục Đầu Ra Trước Khi Build

### Lỗi thường gặp:
```text
FileNotFoundError: [Errno 2] No such file or directory: 'bin\\output.il'
```

### Nguyên nhân:
Trong pipeline nội bộ của `tkvc.exe`, compiler sẽ phát sinh tệp mã trung gian CIL (`.il`) tại cùng thư mục với file `.exe` chỉ định trong `--out`, sau đó mới gọi assembler `ilasm` để lắp ráp. Nếu thư mục đích (như `bin/`) chưa tồn tại sẵn trên hệ thống tệp, compiler sẽ dừng với lỗi `FileNotFoundError`.

### Quy tắc khắc phục:
Luôn tạo thư mục đầu ra trong kịch bản tự động hóa trước khi gọi `tkvc`:
```cmd
if not exist "bin" mkdir "bin"
```

---

## 7. Tính Toán Số Học Tránh Tràn Số & Lỗi Dấu Phẩy Động (`nan%`)

### Hiện tượng:
Biểu thức chia số thực lồng nhau: `percent = (float(bytes) / float(total)) * 100.0` đôi khi phát sinh mã opcode CIL tính toán ra kết quả `nan%` nếu các biến số nguyên `i64` quá lớn hoặc con trỏ bộ đệm chưa được đồng bộ tức thì.

### Quy tắc khắc phục:
Ưu tiên thực hiện phép nhân trước rồi chia nguyên số học trong các logic tính phần trăm tiến trình:
```TokenVector
# Cách tối ưu và ổn định tuyệt đối trên CIL:
pct = (bytes_received * 100) // stream_size
progress_str = "[download] " + str(pct) + "% complete"
```

---

## 8. Lỗi Restricted Headers Trong `http_request` (`System.ArgumentException`)

### Lỗi thường gặp:
```text
Unhandled Exception: System.ArgumentException: The 'Range' header must be modified using the appropriate property or method.
   at System.Net.WebHeaderCollection.ThrowOnRestrictedHeader(String headerName)
   at System.Net.WebHeaderCollection.Set(String name, String value)
```

### Nguyên nhân:
TokenVector ánh xạ `http_request` sang lớp `[System]System.Net.HttpWebRequest` của .NET BCL. Theo quy định bảo mật của .NET, một số HTTP Header bị coi là "Restricted" và không được phép gán trực tiếp qua tập hợp `Headers.Set(name, value)`:
- `Range`, `Host`, `Connection`, `Content-Length`, `Expect`, `Date`, `If-Modified-Since`, `Transfer-Encoding`, `Proxy-Connection`.

### Quy tắc khắc phục:
- Không truyền các header bị hạn chế trên vào dictionary `headers` khi gọi `http_request`.
- Chỉ truyền các header hợp lệ như `User-Agent`, `Accept`, `Authorization`, `X-Custom-Header`, v.v.

---

## 9. Khởi Tạo Dictionary (`dict`) Trong Mã Nguồn `.tkv`

### Lỗi thường gặp:
```text
SyntaxError: il_codegen: khong tokenize duoc bieu thuc tai '{"key": "val"}'
SyntaxError: il_codegen: ham 'dict' khong ton tai
```

### Nguyên nhân:
Parser và Tokenizer của TokenVector không hỗ trợ khai báo dictionary trực tiếp dạng `{k: v}` hoặc qua hàm gọi `dict()`.

### Quy tắc khắc phục:
- Khởi tạo một dictionary rỗng bằng dấu ngoặc nhọn `{}` trên một dòng độc lập:
```TokenVector
headers = {}
headers["User-Agent"] = "TokenVector-Agent"
headers["Accept"] = "*/*"
```

---

## 10. Cơ Chế Ánh Xạ Tham Số CLI Vào Hàm Entry Point (`main`)

### Lỗi thường gặp:
```text
Unhandled Exception: System.IndexOutOfRangeException: Index was outside the bounds of the array.
   at TKVApp.Main(String[] args)
```

### Nguyên nhân:
Khi một hàm entry point khai báo tham số: `def main(url: "str") -> "i32":`, trình biên dịch `tkvc` tự động sinh mã CIL đọc trực tiếp `args[0]`. Nếu người dùng chạy file `.exe` trần (không truyền tham số trong dòng lệnh hoặc click đúp chuột), chỉ số mảng sẽ bị vượt quá biên.

### Quy tắc khắc phục:
- Đối với các binary CLI cho người dùng cuối có thể click đúp chuột hoặc chạy không cần tham số, định nghĩa entry point không tham số:
```TokenVector
def main() -> "i32":
    # Thiết lập giá trị mặc định hoặc đọc từ cấu hình
    target_url = "https://example.com/default.mp4"
    return 0
```

---

## 11. Bắt Buộc Sử Dụng UTF-8 Without BOM Cho File Nguồn `.tkv`

### Lỗi thường gặp:
```text
SyntaxError: invalid non-printable character U+FEFF
    \ufeff# -*- coding: utf-8 -*-
    ^
```

### Nguyên nhân:
Trình phân tích AST nội bộ của `tkvc` đọc file văn bản thuần. Nếu file được lưu với UTF-8 có Byte Order Mark (BOM: `0xEF, 0xBB, 0xBF`), ký tự vô hình `U+FEFF` sẽ nằm ở đầu file và làm hỏng token đầu tiên.

### Quy tắc khắc phục:
- Luôn cấu hình editor hoặc script sinh file với encoding `UTF-8 (without BOM)`.
- Trong PowerShell: sử dụng `[System.IO.File]::WriteAllText(path, content, [System.Text.UTF8Encoding]::new($false))` thay vì `Out-File -Encoding utf8`.

---

## 12. Phát Triển Windows GUI Với WinForms & Kiến Trúc Plugin (`il_features/`)

### Lỗi thường gặp:
```text
[tkv] Syntax baseline linter: tim thay 2 loi cu phap khong ho tro:
  dong 7: goi ham/bieu thuc doc lap o cap top-level
```

### Nguyên nhân:
- `__tkv_extern_assembly__` không phải là lời gọi hàm mà là một gán danh sách các chuỗi tên Assembly:
  `__tkv_extern_assembly__ = ["System.Windows.Forms", "System.Drawing"]`.
- Để xây dựng ứng dụng Windows GUI (Form, TextBox, Button, FolderBrowserDialog, Event Handler) với TokenVector, mã nguồn `.tkv` kết hợp với hệ thống plugin mở rộng trong thư mục `il_features/`.

### Quy tắc phát triển GUI:
1. **Plugin Mở Rộng (`il_features/win32_gui_window.tkv`):**
   - Đăng ký hàm builtin thông qua `register_expr_builtin('launch_downloader_gui', _push_launch_downloader_gui, 'i32')`.
   - Bơm lớp CIL Form (`DownloaderForm`) vào `ctx['extra_classes']`, bao gồm các control WinForms:
     - `txtUrl`: Nhập đường dẫn link video/audio stream.
     - `txtFolder`: Thư mục lưu đích.
     - `btnBrowse`: Nút duyệt thư mục qua `FolderBrowserDialog`.
     - `btnDownload`: Nút tải xuống, kích hoạt luồng tải qua CLI engine.
     - `lblStatus`: Hiển thị trạng thái tiến trình tải.
2. **Mã Nguồn Ứng Dụng (`src/gui_runner.tkv`):**
   > [!NOTE]
   > `System.Drawing` sử dụng `PublicKeyToken = b03f5f7f11d50a3a` (khác với token mặc định `b77a5c561934e089` của `mscorlib` / `System.Windows.Forms`), do đó cần khai báo dưới dạng tuple 3 phần tử `(name, pubkeytoken, version)`:
   ```TokenVector
   # -*- coding: utf-8 -*-
   __tkv_extern_assembly__ = [
       "System.Windows.Forms",
       ("System.Drawing", "B0 3F 5F 7F 11 D5 0A 3A", "4:0:0:0")
   ]

   def run() -> "i32":
       return launch_downloader_gui()
   ```
3. **Biên Dịch & Đóng Gói Thành Executable Native:**
   ```cmd
   tkvc build src/gui_runner.tkv --entry run --out bin/tv-downloader-gui.exe
   ```

---

## 13. Loại Bỏ Cửa Sổ Console Bằng `.subsystem 0x0002` (Zero-Console GUI) & Ẩn CMD Con

### Vấn đề:
Khi chạy ứng dụng WinForms được biên dịch từ `tkvc`, Windows mặc định mở kèm một cửa sổ console màu đen (CMD) phía sau, hoặc khi bấm nút Download, cửa sổ CMD con lại bung lên làm gián đoạn trải nghiệm người dùng.

### Nguyên nhân:
1. Trình biên dịch `ilasm.exe` mặc định gắn cờ subsystem `3` (`IMAGE_SUBSYSTEM_WINDOWS_CUI` - Console User Interface).
2. Khi gọi `Process::Start("cmd.exe", ...)`, nếu không cấu hình ẩn cửa sổ và tắt ShellExecute, hệ điều hành sẽ tự cấp phát một console mới.

### Quy tắc khắc phục:
1. **Chuyển subsystem của file `.exe` sang GUI (Subsystem 2):**
   Thêm chỉ thị `.subsystem 0x0002` vào phần đầu của các lớp ngoài (`ctx['extra_classes']`). ILASM sẽ tự động ghi cờ Subsystem = 2 (`IMAGE_SUBSYSTEM_WINDOWS_GUI`) vào PE header:
   ```cil
   .subsystem 0x0002
   .class public auto ansi beforefieldinit DownloaderForm extends [System.Windows.Forms]System.Windows.Forms.Form
   ```
2. **Chạy Process ngầm không tạo cửa sổ (`CreateNoWindow = true`):**
   Trong phương thức khởi chạy tiến trình CIL:
   ```cil
   ldloc.s psi
   ldc.i4.1 // WindowStyle.Hidden
   callvirt instance void [System]System.Diagnostics.ProcessStartInfo::set_WindowStyle(valuetype [System]System.Diagnostics.ProcessWindowStyle)

   ldloc.s psi
   ldc.i4.0 // UseShellExecute = false
   callvirt instance void [System]System.Diagnostics.ProcessStartInfo::set_UseShellExecute(bool)

   ldloc.s psi
   ldc.i4.1 // CreateNoWindow = true
   callvirt instance void [System]System.Diagnostics.ProcessStartInfo::set_CreateNoWindow(bool)
   ```

---

## 14. Tránh Lỗi Ký Tự (Mojibake) Trong Trình Hợp Dịch ILASM

### Vấn đề:
Ký tự đặc biệt (ví dụ icon mũi tên `⬇`, ký tự Unicode) trên nút bấm hoặc nhãn hiển thị bị biến thành ký tự lạ dạng `â¬‡` hoặc ô vuông rác.

### Nguyên nhân:
Mặc dù file mã nguồn lưu theo chuẩn `UTF-8 without BOM`, `ilasm.exe` của .NET Framework theo mặc định đọc file nguồn dưới dạng Windows ANSI code page (`Source file is ANSI`). Các ký tự Unicode đa byte bị ngắt thành nhiều ký tự ANSI riêng lẻ gây hiện tượng vỡ font (Mojibake).

### Quy tắc khắc phục:
- Đối với nhãn control giao diện (`Button`, `Label`), ưu tiên sử dụng text chuẩn ASCII (ví dụ `"DOWNLOAD"`, `"[ BROWSE ]"` thay vì kèm icon Unicode trực tiếp vào chuỗi `ldstr`).
- Nếu bắt buộc dùng ký tự Unicode đặc biệt trong IL, phải mã hóa qua mảng byte UTF-8 / UTF-16 hoặc nạp qua tài nguyên Resource.




