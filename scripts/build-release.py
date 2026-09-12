"""Build a release ZIP from committed files. Requires Python 3 and Git."""
from pathlib import Path
import subprocess, zipfile, hashlib, json
root = Path(__file__).resolve().parents[1]
def git(*args):
    return subprocess.check_output(["git", "-C", str(root), *args])
if git("status", "--porcelain").strip():
    raise SystemExit("Commit reviewed changes before packaging.")
version = (root / "VERSION").read_text().strip()
files = git("ls-files", "-z").decode("utf-8").split("\0")
out = root / "dist"
out.mkdir(exist_ok=True)
archive = out / f"owner-workflow-kit-v{version}.zip"
manifest = {}
with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as z:
    for name in sorted(filter(None, files)):
        data = (root / name).read_bytes()
        manifest[name] = hashlib.sha256(data).hexdigest()
        z.writestr("owner-workflow-kit/" + name, data)
    z.writestr("owner-workflow-kit/MANIFEST.json", json.dumps(manifest, ensure_ascii=False, indent=2))
with zipfile.ZipFile(archive) as z:
    assert z.testzip() is None
archive.with_suffix(".zip.sha256").write_text(hashlib.sha256(archive.read_bytes()).hexdigest() + "  " + archive.name + "\n")
print(archive)
