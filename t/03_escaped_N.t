use strict;
use warnings;
use utf8;

use Regexp::Lexer qw(tokenize);
use Regexp::Lexer::TokenType;

use Test::More;
use Test::Deep;

subtest 'has not meta newline' => sub {
    my $tokens = tokenize(qr{\N\N{U+000}\N});
    cmp_deeply($tokens->{tokens}, [
        {
            char => "\\N",
            index => 1,
            type => Regexp::Lexer::TokenType::EscapedNotNewline,
        },
        {
            char => "\\N",
            index => 2,
            type => Regexp::Lexer::TokenType::EscapedCharUnicode,
        },
        {
            char => "{",
            index => 3,
            type => Regexp::Lexer::TokenType::LeftBrace,
        },
        {
            char => "U",
            index => 4,
            type => Regexp::Lexer::TokenType::Character,
        },
        {
            char => "+",
            index => 5,
            type => Regexp::Lexer::TokenType::Plus,
        },
        {
            char => 0,
            index => 6,
            type => Regexp::Lexer::TokenType::Character,
        },
        {
            char => 0,
            index => 7,
            type => Regexp::Lexer::TokenType::Character,
        },
        {
            char => 0,
            index => 8,
            type => Regexp::Lexer::TokenType::Character,
        },
        {
            char => "}",
            index => 9,
            type => Regexp::Lexer::TokenType::RightBrace,
        },
        {
            char => "\\N",
            index => 10,
            type => Regexp::Lexer::TokenType::EscapedNotNewline,
        }
    ]);
};

done_testing;

