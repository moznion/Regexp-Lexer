use strict;
use warnings;
use utf8;
use Regex::Lexer qw(tokenize);
use Regex::Lexer::TokenType;

use Test::More;
use Test::Deep;

subtest 'has not meta newline' => sub {
    my $tokens = tokenize(qr{h\\\n\\
w\\\\});
    cmp_deeply($tokens->{tokens}, [
        {
            char => "h",
            index => 1,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => "\\\\",
            index => 2,
            type => Regex::Lexer::TokenType::EscapedCharacter,
        },
        {
            char => "\\n",
            index => 3,
            type => Regex::Lexer::TokenType::EscapedNewline,
        },
        {
            char => "\\\\",
            index => 4,
            type => Regex::Lexer::TokenType::EscapedCharacter,
        },
        {
            char => "\\n",
            index => 5,
            type => Regex::Lexer::TokenType::Newline,
        },
        {
            char => "w",
            index => 6,
            type => Regex::Lexer::TokenType::Character,
        },
        {
            char => "\\\\",
            index => 7,
            type => Regex::Lexer::TokenType::EscapedCharacter,
        },
        {
            char => "\\\\",
            index => 8,
            type => Regex::Lexer::TokenType::EscapedCharacter,
        },
    ]);
};

done_testing;

