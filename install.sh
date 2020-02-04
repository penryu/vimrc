#!/bin/sh

set -eu

NVIM_DIR="$HOME/.config/nvim"
NVIM_FILES="init.vim coc-settings.json"

install_nvim(){
    if [ -d "$NVIM_DIR" ]; then
        echo "- $NVIM_DIR exists."
    else
        echo "* $NVIM_DIR not present; creating..."
        mkdir -p "$NVIM_DIR"
    fi

    for file in $NVIM_FILES; do
        src_path="$PWD/$file"
        dst_path="$NVIM_DIR/$file"

        if [ -e "$dst_path" -o -L "$dst_path" ]; then
            echo "- $dst_path exists; not linking..."
            if diff $src_path $dst_path; then
                echo "- File contents match; ignoring."
            else
                echo "! Contents of $file differ!"
            fi
        else
            echo "* Linking $file to $dst_path ..."
            ln -s "$src_path" "$dst_path"
        fi
    done
}

install_nvim
