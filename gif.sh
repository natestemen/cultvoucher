#!/bin/bash

set -euo pipefail

png_dir=pngs
gif_dir=$(mktemp -d)
rm -rf $png_dir
mkdir $png_dir

# Preserve current latexmkrc so it's available when old commits are checked out
cp .latexmkrc latexmkrc
trap 'git checkout main 2>/dev/null || true; rm -f latexmkrc; rm -rf "$gif_dir"' EXIT

ITALIC='\033[0;3m'
INVERT='\033[0;7m'
NC='\033[0m'

total_commits=$(git rev-list --count main)
INDEX=1
for commit in $(git rev-list --reverse main); do
    commit_message=$(git log --format=%s -n 1 $commit)
    commit_date=$(git log --date=short --format=%cd -n 1 $commit)
    echo -e "processing commit ${INVERT}$INDEX${NC} of $total_commits"
    echo -e "commit message: ${ITALIC}${commit_message}${NC}"
    echo "date: ${commit_date}"
    git reset --hard HEAD &> /dev/null
    git clean -fdq --exclude="${png_dir}" --exclude="latexmkrc"
    git checkout $commit &> /dev/null
    if ! latexmk -jobname=$commit main.tex &> /dev/null; then
        echo "skipping (failed to compile)"
        ((INDEX++))
        continue
    fi
    magick -density 75 ${commit}.pdf -background white -alpha off -colorspace RGB ${commit}.png
    printf -v formatted_index "%05d" ${INDEX}
    magick ${commit}*.png +append ./${png_dir}/${formatted_index}.png
    rm ${commit}*

    ((INDEX++))
done

git clean -fdq --exclude="${png_dir}"
git checkout main

xdim=()
ydim=()
for png in ./${png_dir}/*; do
    dimensions=$(magick $png -format "%w x %h" info:)
    x=$(echo $dimensions | grep -E '^[0-9]+' --only-matching)
    y=$(echo $dimensions | grep -E '[0-9]+$' --only-matching)
    xdim+=("${x}")
    ydim+=("${y}")
done

IFS=$'\n'
xmax=$(echo "${xdim[*]}" | sort -nr | head -n 1)
ymax=$(echo "${ydim[*]}" | sort -nr | head -n 1)
unset IFS

for png in ./${png_dir}/*; do
    magick ${png} -background white -gravity west -extent "${xmax}x${ymax}" ${png}
done

echo "deleting duplicate pngs"
to_delete=()
for png in ${png_dir}/*; do
    if [[ " ${to_delete[*]:-()} " =~ " ${png} " ]]; then
        continue
    fi

    int=$(echo $png | grep -E '[1-9][0-9]*' --only-matching)
    next=$((int+1))
    printf -v formatted_int "%05d" ${next}
    next_png="./${png_dir}/${formatted_int}.png"
    if [ ! -f "$next_png" ]; then
        continue
    fi

    diff=$(magick compare -metric RMSE -format "%[distortion]" ${png} ${next_png} info: 2>/dev/null) || true
    if [[ -n "$diff" ]] && (( $(echo "$diff == 0" | bc -l) )); then
        to_delete+=("${next_png}")
    fi
done

for png in "${to_delete[@]}"; do
    rm $png
done

echo "creating final gif"
for png in ./${png_dir}/*; do
    base=$(basename $png .png)
    magick $png -colors 256 "${gif_dir}/${base}.gif"
done
gifsicle --delay=20 --loop "${gif_dir}"/*.gif > ./.github/anim.gif
