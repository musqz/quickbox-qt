"""Basic sanity tests for quickbox-qt (no display required)."""

import importlib.util, sys, types, pathlib

# ── stub heavy deps so tests run headless ─────────────────────────────────────
for mod in [
    "gi", "gi.repository", "gi.repository.GLib",
    "PySide6", "PySide6.QtWidgets", "PySide6.QtCore", "PySide6.QtGui",
]:
    sys.modules.setdefault(mod, types.ModuleType(mod))

ROOT = pathlib.Path(__file__).parent.parent


def _load_script():
    spec = importlib.util.spec_from_file_location("quickbox", ROOT / "quickbox")
    return spec


def test_version_txt_matches_script():
    version_txt = (ROOT / "version.txt").read_text().strip()
    source = (ROOT / "quickbox").read_text()
    # Extract VERSION = "x.y.z" from the script
    import re
    m = re.search(r'^VERSION\s*=\s*["\']([^"\']+)["\']', source, re.MULTILINE)
    assert m, "VERSION not found in quickbox script"
    assert m.group(1) == version_txt, (
        f"version.txt ({version_txt}) does not match script VERSION ({m.group(1)})"
    )


def test_translations_present():
    translation_dir = ROOT / "translations"
    json_files = list(translation_dir.glob("*.json"))
    assert len(json_files) > 0, "No translation files found"


def test_translations_valid_json():
    import json
    for path in (ROOT / "translations").glob("*.json"):
        with open(path) as f:
            data = json.load(f)
        assert isinstance(data, dict), f"{path.name} is not a JSON object"


def test_script_is_executable():
    script = ROOT / "quickbox"
    assert script.exists(), "quickbox script not found"
    assert script.stat().st_mode & 0o111, "quickbox script is not executable"
