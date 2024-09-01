import glob
import os
import time

current_directory_name = os.path.dirname(__file__)
content_directory_glob = os.path.join(
    current_directory_name,
    "..", "..", "content", "*.tex"
)
content_chap_four_path = os.path.join(
    current_directory_name,
    "..", "..", "content", "aufwand.tex"
)

def count_time(path):
    characters  = 0
    seconds     = 0

    for file in glob.glob(path):
        with open(file, "r") as filepointer:
            text = filepointer.read()
            characters += len(text)
            start_time             = time.time()
            text[::-1]
            end_time = time.time()
            seconds += end_time - start_time

    print(f"Runtime and number of characters for {path}")
    print(f"{'Seconds:':<12}{seconds:>15.10f}",
          f"{'Characters:':<12}{characters:>15}",
          sep="\n")

count_time(content_chap_four_path)
count_time(content_directory_glob)
