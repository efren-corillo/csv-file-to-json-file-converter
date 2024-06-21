import pandas as pd
import json
import sys
import os

def main(csv_file_path):
    if not os.path.isfile(csv_file_path):
        print(f"File not found: {csv_file_path}")
        sys.exit(1)

    json_file_path = os.path.splitext(csv_file_path)[0] + '.json'

    try:
        df = pd.read_csv(csv_file_path)
        df.to_json(json_file_path, orient='records', lines=False, indent=4)
        print(f"Conversion successful: {json_file_path}")
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python main.py <csv_file_path>")
        sys.exit(1)

    csv_file_path = sys.argv[1]
    main(csv_file_path)
