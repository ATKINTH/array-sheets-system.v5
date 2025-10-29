import os, json, gspread
from google.oauth2.service_account import Credentials

SCOPES = ["https://www.googleapis.com/auth/spreadsheets", "https://www.googleapis.com/auth/drive"]

def _creds_from_env():
    raw = os.getenv("GOOGLE_CREDENTIALS_JSON")
    if not raw:
        raise RuntimeError("No GOOGLE_CREDENTIALS_JSON secret found")
    return Credentials.from_service_account_info(json.loads(raw), scopes=SCOPES)

def get_ws(sheet_id, tab):
    gc = gspread.authorize(_creds_from_env())
    return gc.open_by_key(sheet_id).worksheet(tab)

def read_all(sheet_id, tab):
    return get_ws(sheet_id, tab).get_all_values()

def append_row(sheet_id, tab, values):
    get_ws(sheet_id, tab).append_row(values, value_input_option="USER_ENTERED")

def update_range(sheet_id, tab, a1, rows):
    get_ws(sheet_id, tab).update(a1, rows, value_input_option="USER_ENTERED")
