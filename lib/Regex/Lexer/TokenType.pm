package Regex::Lexer::TokenType;

# *** DO NOT EDIT THIS FILE DIRECTORY ***
# This file is generated by 'author/generate_token_type.pl'

use strict;
use warnings;
use utf8;

use constant {
    Character => {
        id => 1,
        name => 'Character',
    },
    BeginningOfLine => {
        id => 2,
        name => 'BeginningOfLine',
    },
    EndOfLine => {
        id => 3,
        name => 'EndOfLine',
    },
    MatchAny => {
        id => 4,
        name => 'MatchAny',
    },
    Alternation => {
        id => 5,
        name => 'Alternation',
    },
    LeftParenthesis => {
        id => 6,
        name => 'LeftParenthesis',
    },
    RightParenthesis => {
        id => 7,
        name => 'RightParenthesis',
    },
    LeftBracket => {
        id => 8,
        name => 'LeftBracket',
    },
    RightBracket => {
        id => 9,
        name => 'RightBracket',
    },
    LeftBrace => {
        id => 10,
        name => 'LeftBrace',
    },
    RightBrace => {
        id => 11,
        name => 'RightBrace',
    },
    LeftAngle => {
        id => 12,
        name => 'LeftAngle',
    },
    RightAngle => {
        id => 13,
        name => 'RightAngle',
    },
    Equal => {
        id => 14,
        name => 'Equal',
    },
    Plus => {
        id => 15,
        name => 'Plus',
    },
    Minus => {
        id => 16,
        name => 'Minus',
    },
    Asterisk => {
        id => 17,
        name => 'Asterisk',
    },
    Sharp => {
        id => 18,
        name => 'Sharp',
    },
    Cap => {
        id => 19,
        name => 'Cap',
    },
    Comma => {
        id => 20,
        name => 'Comma',
    },
    Colon => {
        id => 21,
        name => 'Colon',
    },
    Exclamation => {
        id => 22,
        name => 'Exclamation',
    },
    Question => {
        id => 23,
        name => 'Question',
    },
    ArraySigil => {
        id => 24,
        name => 'ArraySigil',
    },
    ScalarSigil => {
        id => 25,
        name => 'ScalarSigil',
    },
    SingleQuote => {
        id => 26,
        name => 'SingleQuote',
    },
    DoubleQuote => {
        id => 27,
        name => 'DoubleQuote',
    },
    Newline => {
        id => 28,
        name => 'Newline',
    },
    Return => {
        id => 29,
        name => 'Return',
    },
    EscapedCharacter => {
        id => 30,
        name => 'EscapedCharacter',
    },
    EscapedTab => {
        id => 31,
        name => 'EscapedTab',
    },
    EscapedNewline => {
        id => 32,
        name => 'EscapedNewline',
    },
    EscapedReturn => {
        id => 33,
        name => 'EscapedReturn',
    },
    EscapedFormFeed => {
        id => 34,
        name => 'EscapedFormFeed',
    },
    EscapedAlarm => {
        id => 35,
        name => 'EscapedAlarm',
    },
    EscapedEscape => {
        id => 36,
        name => 'EscapedEscape',
    },
    EscapedControlChar => {
        id => 37,
        name => 'EscapedControlChar',
    },
    EscapedCharHex => {
        id => 38,
        name => 'EscapedCharHex',
    },
    EscapedCharUnicode => {
        id => 39,
        name => 'EscapedCharUnicode',
    },
    EscapedCharOct => {
        id => 40,
        name => 'EscapedCharOct',
    },
    EscapedLowerNext => {
        id => 41,
        name => 'EscapedLowerNext',
    },
    EscapedUpperNext => {
        id => 42,
        name => 'EscapedUpperNext',
    },
    EscapedLowerUntil => {
        id => 43,
        name => 'EscapedLowerUntil',
    },
    EscapedUpperUntil => {
        id => 44,
        name => 'EscapedUpperUntil',
    },
    EscapedQuoteMetaUntil => {
        id => 45,
        name => 'EscapedQuoteMetaUntil',
    },
    EscapedEnd => {
        id => 46,
        name => 'EscapedEnd',
    },
    EscapedWordChar => {
        id => 47,
        name => 'EscapedWordChar',
    },
    EscapedNotWordChar => {
        id => 48,
        name => 'EscapedNotWordChar',
    },
    EscapedWhiteSpaceChar => {
        id => 49,
        name => 'EscapedWhiteSpaceChar',
    },
    EscapedNotWhiteSpaceChar => {
        id => 50,
        name => 'EscapedNotWhiteSpaceChar',
    },
    EscapedDigitChar => {
        id => 51,
        name => 'EscapedDigitChar',
    },
    EscapedNotDigitChar => {
        id => 52,
        name => 'EscapedNotDigitChar',
    },
    EscapedProp => {
        id => 53,
        name => 'EscapedProp',
    },
    EscapedNotProp => {
        id => 54,
        name => 'EscapedNotProp',
    },
    EscapedUnicodeExtendedChar => {
        id => 55,
        name => 'EscapedUnicodeExtendedChar',
    },
    EscapedCChar => {
        id => 56,
        name => 'EscapedCChar',
    },
    EscapedBackRef => {
        id => 57,
        name => 'EscapedBackRef',
    },
    EscapedKeepStuff => {
        id => 58,
        name => 'EscapedKeepStuff',
    },
    EscapedNotNewline => {
        id => 59,
        name => 'EscapedNotNewline',
    },
    EscapedVerticalWhitespace => {
        id => 60,
        name => 'EscapedVerticalWhitespace',
    },
    EscapedNotVerticalWhitespace => {
        id => 61,
        name => 'EscapedNotVerticalWhitespace',
    },
    EscapedHorizontalWhitespace => {
        id => 62,
        name => 'EscapedHorizontalWhitespace',
    },
    EscapedNotHorizontalWhitespace => {
        id => 63,
        name => 'EscapedNotHorizontalWhitespace',
    },
    EscapedLinebreak => {
        id => 64,
        name => 'EscapedLinebreak',
    },
    EscapedWordBoundary => {
        id => 65,
        name => 'EscapedWordBoundary',
    },
    EscapedNotWordBoundary => {
        id => 66,
        name => 'EscapedNotWordBoundary',
    },
    EscapedBeginningOfString => {
        id => 67,
        name => 'EscapedBeginningOfString',
    },
    EscapedEndOfStringBeforeNewline => {
        id => 68,
        name => 'EscapedEndOfStringBeforeNewline',
    },
    EscapedEndOfString => {
        id => 69,
        name => 'EscapedEndOfString',
    },
    EscapedPos => {
        id => 70,
        name => 'EscapedPos',
    },
};

1;

