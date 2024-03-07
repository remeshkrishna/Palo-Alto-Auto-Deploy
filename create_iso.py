import os
import argparse

## Generate ISO##
def create_iso_from_folder(iso_file_name, working_dir):
    # Note: genisoimage must be in your PATH
    repo_path = f"{working_dir}/Palo-Alto-Auto-Deploy/iso"
    cmd = os.system(f"mkisofs -o {working_dir}/Palo-Alto-Auto-Deploy/{iso_file_name} -J -R {repo_path}")
    if cmd != 0:
        print(f"Error during 'iso create'")
    else:
        print(f"Successfully created ISO")
##End Generate ISO##

def main():
    parser = argparse.ArgumentParser(description="Create ISO from a given folder.")
    parser.add_argument('iso_file_name', type=str, help="The name for the output ISO file.")
    parser.add_argument('working_dir', type=str, help="The directory containing the files to be turned into an ISO.")
    args = parser.parse_args()

    create_iso_from_folder(args.iso_file_name, args.working_dir)

if __name__ == '__main__':
    main()