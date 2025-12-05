# Implementation Plan

- [x] 1. Fix deprecated Parser and refactor calculation logic
  - [x] 1.1 Replace deprecated `Parser` with `GrammarParser` in expression evaluation
    - Update the `onButtonPressed` method to use `GrammarParser` instead of `Parser`
    - Ensure expression parsing and evaluation work correctly
    - _Requirements: 6.1, 6.2_
  - [x] 1.2 Write property test for valid expression evaluation
    - **Property 4: Valid Expression Evaluation**
    - **Validates: Requirements 1.3**
  - [x] 1.3 Write property test for invalid expression error handling
    - **Property 5: Invalid Expression Error Handling**
    - **Validates: Requirements 3.1, 6.2**

- [x] 2. Implement modern Material Design 3 theming
  - [x] 2.1 Create theme configuration with light and dark color schemes
    - Define color constants for dark theme (near black background, orange operators)
    - Define color constants for light theme (light gray background, orange operators)
    - Wrap app in MaterialApp with theme and darkTheme properties
    - _Requirements: 4.1, 4.5_
  - [x] 2.2 Update button styling with modern appearance
    - Apply rounded corners (16px radius) to all buttons
    - Remove elevation for flat modern look
    - Apply distinct colors: numbers (surface), operators (primary/orange), functions (secondary)
    - Ensure minimum touch target size of 48x48 pixels
    - _Requirements: 4.2, 4.3, 7.1, 7.2_

- [x] 3. Improve display and layout
  - [x] 3.1 Update display area with visual hierarchy
    - Style input text as secondary (smaller, lighter color)
    - Style output/result as primary (larger, bold, prominent)
    - Add appropriate padding and spacing
    - _Requirements: 4.4_
  - [x] 3.2 Ensure horizontal scrolling for long expressions
    - Verify SingleChildScrollView with reverse: true is working
    - Test with long expressions to confirm auto-scroll behavior
    - _Requirements: 5.1, 5.2_

- [x] 4. Implement input handling logic
  - [x] 4.1 Verify digit and operator appending works correctly
    - Test all digit buttons (0-9) append to input
    - Test all operator buttons (+, -, ×, ÷) append to input
    - Test decimal point and parentheses append correctly
    - _Requirements: 1.1, 1.2, 1.4, 1.5_
  - [x] 4.2 Write property test for input appending
    - **Property 1: Input Appending Preserves Order**
    - **Validates: Requirements 1.1, 1.2**
  - [x] 4.3 Implement clear and backspace functionality
    - Verify clear (C) resets input to empty and output to "0"
    - Verify backspace (⌫) removes last character
    - Handle edge case: backspace on empty input
    - _Requirements: 2.1, 2.2, 2.3_
  - [x] 4.4 Write property test for clear functionality
    - **Property 2: Clear Resets to Initial State**
    - **Validates: Requirements 2.1**
  - [x] 4.5 Write property test for backspace functionality
    - **Property 3: Backspace Removes Last Character**
    - **Validates: Requirements 2.2**

- [x] 5. Implement result formatting
  - [x] 5.1 Format output to show integers without decimals
    - Check if result is whole number (result % 1 == 0)
    - Display as integer string if whole, otherwise as decimal string
    - _Requirements: 5.3_
  - [x] 5.2 Write property test for result formatting
    - **Property 6: Result Formatting**
    - **Validates: Requirements 5.3**

- [x] 6. Error handling verification
  - [x] 6.1 Verify error handling for invalid expressions
    - Test unbalanced parentheses show "Error"
    - Test consecutive operators show "Error"
    - Test division by zero shows "Error"
    - Verify app doesn't crash on any invalid input
    - _Requirements: 3.1, 3.2, 3.3_

- [x] 7. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [x] 8. Write unit tests for edge cases
  - [x] 8.1 Write unit tests for calculation examples
    - Test "2+2" = "4"
    - Test "10/4" = "2.5"
    - Test "(2+3)*4" = "20"
    - Test empty input returns "0"
    - _Requirements: 1.3, 3.3_

- [x] 9. Final Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.
