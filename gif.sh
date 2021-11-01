#!/bin/bash

set -euo pipefail

png_dir=pngs
mkdir $png_dir
cp .latexmkrc latexmkrc

INDEX=1
for commit in $(git rev-list --reverse main); do
    echo "###################################"
    echo `git log --format=%B -n 1 $commit`
    echo "###################################"
    git checkout $commit
    latexmk -jobname=$commit main.tex
    convert -density 75 -background white -alpha off ${commit}.pdf ${commit}.png
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
    echo "getting dimensions of ${png}"
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

convert -delay 20 -loop 0 pngs/*.png anim.gif
