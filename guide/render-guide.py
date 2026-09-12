"""Render the maintained Markdown guide as a portable, offline reading page."""
from pathlib import Path
from markdown_it import MarkdownIt

ROOT = Path(__file__).resolve().parent
source = (ROOT / 'Owner使用指南.md').read_text(encoding='utf-8')
content = MarkdownIt('commonmark', {'html': True}).enable('table').render(source)
page = '''<!doctype html>
<html lang="zh-CN"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Owner 使用指南</title>
<style>
:root{color-scheme:light dark;--bg:light-dark(#f4f6fa,#111824);--paper:light-dark(#fff,#192331);--ink:light-dark(#17283b,#edf3fb);--muted:light-dark(#4c5e73,#bac8da);--line:light-dark(#dce5ef,#34455b);--link:light-dark(#125cb8,#8fc5ff)}
*{box-sizing:border-box}html{scroll-behavior:smooth}body{margin:0;background:var(--bg);color:var(--ink);font:17px/1.85 system-ui,'Microsoft YaHei',sans-serif}main{max-width:1100px;margin:32px auto;padding:36px 52px 70px;background:var(--paper);border:1px solid var(--line);border-radius:16px}h1{font-size:36px;line-height:1.3;margin-top:0}h2{font-size:25px;line-height:1.4;margin-top:48px;padding-top:12px;border-top:1px solid var(--line)}p,li{max-width:85ch}a{color:var(--link);text-decoration-thickness:1px;text-underline-offset:3px}a[id]{scroll-margin-top:24px}blockquote{margin:22px 0;padding:12px 22px;border-left:4px solid var(--link);background:var(--bg);border-radius:0 8px 8px 0}blockquote p{margin:4px 0}table{border-collapse:collapse;width:100%;font-size:16px;margin:24px 0}th,td{border:1px solid var(--line);padding:12px 16px;text-align:left;vertical-align:top;overflow-wrap:anywhere}th{background:var(--bg)}code{font-size:.9em;overflow-wrap:anywhere}ol,ul{padding-left:26px}li{margin:7px 0}strong{font-weight:700}.top{position:fixed;bottom:22px;right:22px;background:var(--paper);border:1px solid var(--line);padding:8px 14px;border-radius:24px;font-size:14px;text-decoration:none}
@media(max-width:700px){main{margin:0;padding:24px 18px;border:0;border-radius:0}body{font-size:16px}h1{font-size:30px}h2{font-size:22px}th,td{padding:9px 8px;font-size:14px}.top{bottom:10px;right:10px}}
@media print{main{margin:0;border:0;padding:0;max-width:none}body{font-size:11pt;background:#fff;color:#111}.top{display:none}h2{break-after:avoid}tr,blockquote{break-inside:avoid}a{color:#111}}
</style></head><body><main id="top">'''+content+'''</main><a class="top" href="#top">回到目录 ↑</a></body></html>'''
(ROOT / 'Owner使用指南.html').write_text(page, encoding='utf-8')
print('Rendered Owner使用指南.html')
