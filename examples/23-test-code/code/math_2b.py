#!/usr/bin/env python3
# File: code/math_1.py

from math_2a import *
import sys

num1 = int(sys.argv[1])
num2 = int(sys.argv[2])

print(f'Sum = {sum(num1, num2)}')
print(f'Mul = {mul(num1, num2)}')
