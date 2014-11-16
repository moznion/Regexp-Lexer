use strict;
use warnings;
use utf8;
use Regex::Lexer qw(tokenize);
use Regex::Lexer::TokenType;

use Test::More;
use Test::Deep;

subtest 'basic pass' => sub {
    my $tokens = tokenize(qr{^hello\s+world's\\ end\\$}mi);
    cmp_deeply($tokens->{tokens}, [
        {
            char => '^',
            index => 1,
            type => Regex::Lexer::TokenType::BeginningOfLine,
        },
        {
            char => 'h',
            index => 2,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => 'e',
            index => 3,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => 'l',
            index => 4,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => 'l',
            index => 5,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => 'o',
            index => 6,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => '\s',
            index => 7,
            type => Regex::Lexer::TokenType::EscapedWhiteSpaceChar,
        },
        {
            char => '+',
            index => 8,
            type => Regex::Lexer::TokenType::Plus,
        },
        {
            char => 'w',
            index => 9,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => 'o',
            index => 10,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => 'r',
            index => 11,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => 'l',
            index => 12,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => 'd',
            index => 13,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => q<'>,
            index => 14,
            type => Regex::Lexer::TokenType::SingleQuote,
        },
        {
            char => 's',
            index => 15,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => '\\\\',
            index => 16,
            type => Regex::Lexer::TokenType::EscapedCharacter,
        },
        {
            char => ' ',
            index => 17,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => 'e',
            index => 18,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => 'n',
            index => 19,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => 'd',
            index => 20,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => '\\\\',
            index => 21,
            type => Regex::Lexer::TokenType::EscapedCharacter,
        },
        {
            char => '$',
            index => 22,
            type => Regex::Lexer::TokenType::EndOfLine,
        },
    ]);

    ok grep {$_ eq 'm'} @{$tokens->{modifiers}};
    ok grep {$_ eq 'i'} @{$tokens->{modifiers}};
};

done_testing;
