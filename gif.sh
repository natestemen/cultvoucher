#!/bin/bash

set -euo pipefail

png_dir=pngs
mkdir $png_dir
cp .latexmkrc latexmkrc

INDEX=0
for commit in $(git rev-list --reverse main); do
    echo "###################################"
    echo `git log --format=%B -n 1 $commit`
    echo "###################################"
    git checkout $commit
    latexmk -jobname=$commit main.tex
    convert -density 100 -background white -alpha off ${commit}.pdf ${commit}.png
    printf -v formatted_index "%05d" ${INDEX} # TODO: unlikely to have >99,999 commits, but...
    convert +append *.png ./${png_dir}/${formatted_index}.png
    rm *.png ${commit}*

    let INDEX=${INDEX}+1
done

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

# TODO: check if sequential images are the same with
# convert pngs/00000.png pngs/00001.png -metric RMSE -compare -format "%[distortion]" info:

convert -delay 10 -loop 0 pngs/*.png anim.gif

git checkout main
