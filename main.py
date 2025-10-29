import sys, json
from sheets_client import read_all, append_row, update_range

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python main.py read|append|update ...")
        sys.exit(1)
    cmd = sys.argv[1]
    try:
        if cmd == "read":
            _, _, sid, tab = sys.argv
            data = read_all(sid, tab)
            print(json.dumps({"ok": True, "rows": len(data), "preview": data[:5]}, ensure_ascii=False))
        elif cmd == "append":
            _, _, sid, tab, csv = sys.argv
            append_row(sid, tab, [v.strip() for v in csv.split(",")])
            print(json.dumps({"ok": True, "appended": 1}, ensure_ascii=False))
        elif cmd == "update":
            _, _, sid, tab, a1, payload = sys.argv
            update_range(sid, tab, a1, json.loads(payload))
            print(json.dumps({"ok": True, "range": a1}, ensure_ascii=False))
        else:
            print(json.dumps({"ok": False, "error": "bad command"}))
            sys.exit(1)
    except Exception as e:
        print(json.dumps({"ok": False, "error": str(e)}, ensure_ascii=False))
        sys.exit(1)
