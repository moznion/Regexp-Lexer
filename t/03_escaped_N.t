use strict;
use warnings;
use utf8;

use Regex::Lexer qw(tokenize);
use Regex::Lexer::TokenType;

use Test::More;
use Test::Deep;

subtest 'has not meta newline' => sub {
    my $tokens = tokenize(qr{\N\N{U+000}\N});
    cmp_deeply($tokens, {
        tokens => [
            {
                char => "\\N",
                index => 1,
                type => Regex::Lexer::TokenType::EscapedNotNewline,
            },
            {
                char => "\\N",
                index => 2,
                type => Regex::Lexer::TokenType::EscapedCharUnicode,
            },
            {
                char => "{",
                index => 3,
                type => Regex::Lexer::TokenType::LeftBrace,
            },
            {
                char => "U",
                index => 4,
                type => Regex::Lexer::TokenType::Character,
            },
            {
                char => "+",
                index => 5,
                type => Regex::Lexer::TokenType::Plus,
            },
            {
                char => 0,
                index => 6,
                type => Regex::Lexer::TokenType::Character,
            },
            {
                char => 0,
                index => 7,
                type => Regex::Lexer::TokenType::Character,
            },
            {
                char => 0,
                index => 8,
                type => Regex::Lexer::TokenType::Character,
            },
            {
                char => "}",
                index => 9,
                type => Regex::Lexer::TokenType::RightBrace,
            },
            {
                char => "\\N",
                index => 10,
                type => Regex::Lexer::TokenType::EscapedNotNewline,
            }
        ],
        modifiers => [
            "^",
            "u"
        ],
    });
};

done_testing;

