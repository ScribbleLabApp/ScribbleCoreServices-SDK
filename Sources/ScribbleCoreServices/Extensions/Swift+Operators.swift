//
//  File.swift
//  
//
//  Created by Nevio Hirani on 11.05.24.
//

import Foundation

/// Increment postfix operator. Increments the operand by 1.
postfix operator ++

/// Addition postfix operator. Adds 1 to the operand.
postfix operator +-

/// Decrement postfix operator. Decrements the operand by 1.
postfix operator --

/// Subtraction postfix operator. Subtracts 1 from the operand.
postfix operator -+

/// Addition infix operator. Adds two operands together.
infix operator + : AdditionPrecedence

/// Subtraction infix operator. Subtracts the right-hand operand from the left-hand operand.
infix operator - : AdditionPrecedence

/// Multiplication infix operator. Multiplies two operands together.
infix operator * : MultiplicationPrecedence

/// Division infix operator. Divides the left-hand operand by the right-hand operand.
infix operator / : MultiplicationPrecedence

/// Modulus infix operator. Calculates the remainder of the division of the left-hand operand by the right-hand operand.
infix operator % : MultiplicationPrecedence

/// Bitwise AND infix operator. Computes the bitwise AND of two integers.
infix operator & : BitwiseShiftPrecedence

/// Bitwise OR infix operator. Computes the bitwise OR of two integers.
infix operator | : BitwiseShiftPrecedence

/// Bitwise XOR infix operator. Computes the bitwise XOR of two integers.
infix operator ^ : BitwiseShiftPrecedence

/// Left shift infix operator. Shifts the bits of the left-hand operand to the left by the number of positions specified by the right-hand operand.
infix operator << : BitwiseShiftPrecedence

/// Right shift infix operator. Shifts the bits of the left-hand operand to the right by the number of positions specified by the right-hand operand.
infix operator >> : BitwiseShiftPrecedence

/// Equality infix operator. Checks if two operands are equal.
infix operator == : ComparisonPrecedence

/// Inequality infix operator. Checks if two operands are not equal.
infix operator != : ComparisonPrecedence

/// Less than infix operator. Checks if the left-hand operand is less than the right-hand operand.
infix operator < : ComparisonPrecedence

/// Less than or equal to infix operator. Checks if the left-hand operand is less than or equal to the right-hand operand.
infix operator <= : ComparisonPrecedence

/// Greater than infix operator. Checks if the left-hand operand is greater than the right-hand operand.
infix operator > : ComparisonPrecedence

/// Greater than or equal to infix operator. Checks if the left-hand operand is greater than or equal to the right-hand operand.
infix operator >= : ComparisonPrecedence

/// Logical AND infix operator. Performs a logical AND operation on two boolean operands.
infix operator && : LogicalConjunctionPrecedence

/// Logical OR infix operator. Performs a logical OR operation on two boolean operands.
infix operator || : LogicalDisjunctionPrecedence
