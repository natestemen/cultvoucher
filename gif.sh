#!/bin/bash

set -euo pipefail

png_dir=pngs
mkdir $png_dir
cp .latexmkrc latexmkrc

ITALIC='\033[0;3m'
INVERT='\033[0;7m'
NC='\033[0m'

total_commits=`git rev-list --all --count`
INDEX=1
for commit in $(git rev-list --reverse main); do
    commit_message=`git log --format=%s -n 1 $commit`
    commit_date=`git log --date=short --format=%cd -n 1 $commit`
    echo -e "processing commit ${INVERT}$INDEX${NC} of $total_commits"
    echo -e "commit message: ${ITALIC}${commit_message}${NC}"
    echo "date: ${commit_date}"
    git checkout $commit &> /dev/null
    latexmk -jobname=$commit main.tex &> /dev/null
    convert -density 75 -background white -alpha off -colorspace RGB ${commit}.pdf ${commit}.png
    printf -v formatted_index "%05d" ${INDEX} # TODO: unlikely to have >99,999 commits, but...
    convert +append *.png ./${png_dir}/${formatted_index}.png
    rm ${commit}*

    let INDEX=${INDEX}+1
done

git checkout main
rm latexmkrc

xdim=()
ydim=()
for png in ./${png_dir}/*; do
    dimensions=`convert $png -format "%w x %h" info:`
    x=$(echo $dimensions | grep '^\d*' --only-matching)
    y=$(echo $dimensions | grep '\d*$' --only-matching)
    xdim+=("${x}")
    ydim+=("${y}")
done

IFS=$'\n'
xmax=`echo "${xdim[*]}" | sort -nr | head -n 1`
ymax=`echo "${ydim[*]}" | sort -nr | head -n 1`
unset IFS

for png in ./${png_dir}/*; do
    convert -gravity west -extent "${xmax} x ${ymax}" ${png} ${png}
done

echo "deleting duplicate pngs"
to_delete=()
for png in ${png_dir}/*; do
    if [[ " ${to_delete[*]:-()} " =~ " ${png} " ]]; then
        continue
    fi

    int=$(echo $png | egrep '[1-9]\d*' --only-matching)
    next=$((int+1))
    printf -v formatted_int "%05d" ${next}
    next_png="./${png_dir}/${formatted_int}.png"
    if [ ! -f "$next_png" ]; then
        continue
    fi
    
    diff=$(convert ${png} ${next_png} -metric RMSE -compare -format "%[distortion]" info:)
    if (( $(echo "$diff == 0" | bc -l) )); then
        to_delete+=("${next_png}")
    fi
done

for png in "${to_delete[*]}"; do
    rm $png
done

echo "creating final gif"
convert -delay 20 -loop 0 pngs/*.png ./.github/anim.gif
