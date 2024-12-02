package day01

import "core:fmt"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"

main :: proc() {
	part_1()
	part_2()
}

read_data :: proc() -> ([]int, []int) {
	input, ok := os.read_entire_file("./day01/input.txt", context.allocator)
	if !ok {
		fmt.println("could not read file")
		return nil, nil
	}
	defer delete(input, context.allocator)

	it := string(input)
	left: [dynamic]int
	right: [dynamic]int
	for line in strings.split_lines_iterator(&it) {
		left_right := strings.split(line, "   ")
		append(&left, strconv.atoi(left_right[0]))
		append(&right, strconv.atoi(left_right[1]))
	}
	slice.sort(left[:])
	slice.sort(right[:])
	return left[:], right[:]
}

part_2 :: proc() {
	leftValues, rightValues := read_data()
	similarity := 0
	for left in leftValues {
		match := 0
		for right in rightValues {
			if (left == right) {
				match = match + 1
			}
		}
		similarity += (left * match)
	}

	fmt.println("similarity score : ", similarity)
}

part_1 :: proc() {
	leftValues, rightValues := read_data()
	distance: [dynamic]int
	sum := 0
	for i := 0; i < len(leftValues); i += 1 {
		if (leftValues[i] > rightValues[i]) {
			append(&distance, leftValues[i] - rightValues[i])
		} else {
			append(&distance, rightValues[i] - leftValues[i])
		}
		sum = sum + distance[i]
	}
	fmt.println("Sum distance : ", sum)
}
