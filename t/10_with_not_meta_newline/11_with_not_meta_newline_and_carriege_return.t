use strict;
use warnings;
use utf8;
use Regexp::Lexer qw(tokenize);
use Regexp::Lexer::TokenType;

use Test::More;
use Test::Deep;

subtest 'has not meta newline' => sub {
    my $tokens = tokenize(qr{h\\\r\n\\
w\\\\});
    cmp_deeply($tokens->{tokens}, [
        {
            char => "h",
            index => 1,
            type => Regexp::Lexer::TokenType::Character,
        },
        {
            char => "\\\\",
            index => 2,
            type => Regexp::Lexer::TokenType::EscapedCharacter,
        },
        {
            char => "\\r",
            index => 3,
            type => Regexp::Lexer::TokenType::EscapedReturn,
        },
        {
            char => "\\n",
            index => 4,
            type => Regexp::Lexer::TokenType::EscapedNewline,
        },
        {
            char => "\\\\",
            index => 5,
            type => Regexp::Lexer::TokenType::EscapedCharacter,
        },
        {
            char => "\\r",
            index => 6,
            type => Regexp::Lexer::TokenType::Return,
        },
        {
            char => "\\n",
            index => 7,
            type => Regexp::Lexer::TokenType::Newline,
        },
        {
            char => "w",
            index => 8,
            type => Regexp::Lexer::TokenType::Character,
        },
        {
            char => "\\\\",
            index => 9,
            type => Regexp::Lexer::TokenType::EscapedCharacter,
        },
        {
            char => "\\\\",
            index => 10,
            type => Regexp::Lexer::TokenType::EscapedCharacter,
        },
    ]);
};

done_testing;

# vim: set ff=dos :

