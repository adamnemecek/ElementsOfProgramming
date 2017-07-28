#!/usr/bin/env bash

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" || exit 1

declare -a chapters=("01" "02" "03" "04" "05" "06" "07" "08" "09" "10")
for i in "${chapters[@]}"
do
    # Copy files to Sources direcotry
    rm -rf "Playgrounds/Chapter$i.playground/Sources/"*
    cp -R EOP/*.swift "Playgrounds/Chapter$i.playground/Sources/"
    cp -R EOP/Types/*.swift "Playgrounds/Chapter$i.playground/Sources/"
    # Copy Chapter contents
    rm -f "Playgrounds/Chapter$i.playground/Contents.swift"
    cp "ElementsOfProgramming/Chapter$i.swift" "Playgrounds/Chapter$i.playground/Contents.swift"
    sed -i '' '/import EOP/d' "Playgrounds/Chapter$i.playground/Contents.swift"
done

# Chapter 6 dependencies
declare -a chapters=("04" "05")
for i in "${chapters[@]}"
do
    cp -R "ElementsOfProgramming/Chapter$i.swift" Playgrounds/Chapter06.playground/Sources/
done

# Chapter 7 dependencies
declare -a chapters=("01" "04" "05" "06")
for i in "${chapters[@]}"
do
    cp -R "ElementsOfProgramming/Chapter$i.swift" Playgrounds/Chapter07.playground/Sources/
done

# Chapter 9 dependencies
declare -a chapters=("08")
for i in "${chapters[@]}"
do
    cp -R "ElementsOfProgramming/Chapter$i.swift" Playgrounds/Chapter09.playground/Sources/
done

# Chapter 10 dependencies
declare -a chapters=("04" "05" "06" "08" "09")
for i in "${chapters[@]}"
do
    cp -R "ElementsOfProgramming/Chapter$i.swift" Playgrounds/Chapter10.playground/Sources/
done

sed -i '' '/import EOP/d' Playgrounds/Chapter*.playground/Sources/Chapter*.swift
