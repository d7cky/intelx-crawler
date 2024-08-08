import argparse
from intelxapi import intelx
import shutil
from tqdm import tqdm
from colorama import init, Fore

init(autoreset=True)

parser = argparse.ArgumentParser(description='Search IntelX and save results.')
parser.add_argument('-q', '--query', required=True, help='Query keyword for search')
parser.add_argument('-o', '--output', required=True, help='Output file to save results')
parser.add_argument('-k', '--apikey', required=True, help='APIKey to authorization')

args = parser.parse_args()

if not args.query:
    print(Fore.RED + "Error: Query keyword (-q) is required.")
    sys.exit(1)
if not args.apikey:
    print(Fore.RED + "Error: API key (-k) is required.")
    sys.exit(1)
if not args.output:
    print(Fore.RED + "Error: Output file (-o) is required.")
    sys.exit(1)

query = args.query
output_file = args.output
apikey = args.apikey

intelx = intelx(apikey)

results = intelx.search(query, 1000, [], 5, "", "", 4, 24, [])

if isinstance(results, dict):
    if 'records' in results and isinstance(results['records'], list):
        total_records = len(results['records'])
        success_count = 0

        progress_bar = tqdm(total=total_records, bar_format='{l_bar}{bar}| {n_fmt}/{total_fmt} [{elapsed}<{remaining}] {rate_fmt} {postfix}', dynamic_ncols=True)

        for index, record in enumerate(results['records']):
            if 'systemid' in record and 'bucket' in record:
                try:
                    intelx.FILE_READ(record['systemid'], 0, record['bucket'], "output/temp.txt")

                    with open("output/temp.txt", "rb") as source_file:
                        with open(output_file, "ab") as dest_file:
                            shutil.copyfileobj(source_file, dest_file)

                    success_count += 1
                    percent_complete = (success_count / total_records) * 100
                    progress_bar.set_postfix_str(Fore.GREEN + f'{percent_complete:.2f}%')
                    progress_bar.update(1)
                except Exception as e:
                    print(Fore.RED + f"Error processing record {index+1}/{total_records}: {e}")

        progress_bar.close()