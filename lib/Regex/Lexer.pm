package Regex::Lexer;
use 5.008001;
use strict;
use warnings;
use parent qw(Exporter);

our @EXPORT_OK = qw(tokenize);

our $VERSION = "0.01";

# TODO
# Type name should be constants

my %escapedSpecialChar = (
    t => 'Tab',                      n => 'Newline',
    r => 'Return',                   f => 'FormFeed',
    a => 'Alarm',                    e => 'Escape',
    c => 'ControlChar',              x => 'CharHex',
    N => 'CharUnicode',              o => 'CharOct',
    0 => 'CharOct',                  l => 'LowerNext',
    u => 'UpperNext',                L => 'LowerUntil',
    U => 'UpperUntil',               Q => 'QuoteMetaUntil',
    E => 'End',                      w => 'WordChar',
    W => 'NotWordChar',              s => 'WhiteSpaceChar',
    S => 'NotWhiteSpaceChar',        d => 'DigitChar',
    D => 'NotDigitChar',             p => 'prop',
    P => 'NotProp',                  X => 'UnicodeExtendedChar',
    C => 'CChar',                    1 => 'BackRef',
    2 => 'BackRef',                  3 => 'BackRef',
    4 => 'BackRef',                  5 => 'BackRef',
    6 => 'BackRef',                  7 => 'BackRef',
    8 => 'BackRef',                  9 => 'BackRef',
    g => 'BackRef',                  k => 'BackRef',
    K => 'KeepStuff',                N => 'NotNewline',
    v => 'VerticalWhitespace',       V => 'NotVerticalWhitespace',
    h => 'HorizontalWhitespace',     H => 'NotHorizontalWhitespace',
    R => 'Linebreak',                b => 'WordBoundary',
    B => 'NotWordBoundary',          A => 'BeginOfString',
    Z => 'EndOfStringBeforeNewline', z => 'EndOfString',
    G => 'pos'
);

my %specialChar = (
    '.'  => 'MatchAny',        '|'  => 'Alternation',
    '('  => 'LeftParenthesis', ')'  => 'RightParenthesis',
    '['  => 'LeftBracket',     ']'  => 'RightBracket',
    '{'  => 'LeftBrace',       '}'  => 'RightBrace',
    '<'  => 'LeftAngle',       '>'  => 'RightAngle',
    '*'  => 'Asterisk',        '+'  => 'Plus',
    '?'  => 'Question',        ','  => 'Comma',
    '-'  => 'Minus',           '$'  => 'ScalarSigil',
    '@'  => 'ArraySigil',      ':'  => 'Colon',
    '#'  => 'Sharp',           '^'  => 'Cap',
    '='  => 'Equal',           '!'  => 'Exclamation',
    q<'> => 'SingleQuote',     q<"> => 'DoubleQuote',
);

sub tokenize {
    my ($re_str) = @_;

    my @chars = split //, $re_str;

    my @tokens;
    my $index = 0;

    if ($chars[-1] eq '$') {
        my $pos = scalar @chars;
        push @tokens, {
            char  => pop @chars,
            index => $pos,
            type  => 'EndOfLine',
        };
    }

    if ($chars[0] eq '^') {
        push @tokens, {
            char  => shift @chars,
            index => ++$index,
            type  => 'BeginOfLine',
        };
    }

    my $escaped = 0;

    for my $c (@chars) {
        if ($escaped) {
            push @tokens, {
                char  => '\\' . $c,
                index => ++$index,
                type  => $escapedSpecialChar{$c} || 'Escaped'
            };

            $escaped = 0;

            next;
        }

        if ($c eq '\\') {
            $escaped = 1;
            next;
        }

        push @tokens, {
            char  => $c,
            index => ++$index,
            type  => $specialChar{$c} || 'Character',
        };
    }

    return \@tokens;
}

1;
__END__

=encoding utf-8

=head1 NAME

Regex::Lexer - It's new $module

=head1 SYNOPSIS

    use Regex::Lexer;

=head1 DESCRIPTION

Regex::Lexer is ...

=head1 LICENSE

Copyright (C) moznion.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

moznion E<lt>moznion@gmail.comE<gt>

=cut

