package Regex::Lexer;
use 5.008001;
use strict;
use warnings;
use B;
use Carp qw/croak/;
use Regex::Lexer::TokenType;
use parent qw(Exporter);

our @EXPORT_OK = qw(tokenize);

our $VERSION = "0.01";

my %escapedSpecialChar = (
    t => Regex::Lexer::TokenType::EscapedTab,
    n => Regex::Lexer::TokenType::EscapedNewline,
    r => Regex::Lexer::TokenType::EscapedReturn,
    f => Regex::Lexer::TokenType::EscapedFormFeed,
    F => Regex::Lexer::TokenType::EscapedFoldcase,
    a => Regex::Lexer::TokenType::EscapedAlarm,
    e => Regex::Lexer::TokenType::EscapedEscape,
    c => Regex::Lexer::TokenType::EscapedControlChar,
    x => Regex::Lexer::TokenType::EscapedCharHex,
    o => Regex::Lexer::TokenType::EscapedCharOct,
    0 => Regex::Lexer::TokenType::EscapedCharOct,
    l => Regex::Lexer::TokenType::EscapedLowerNext,
    u => Regex::Lexer::TokenType::EscapedUpperNext,
    L => Regex::Lexer::TokenType::EscapedLowerUntil,
    U => Regex::Lexer::TokenType::EscapedUpperUntil,
    Q => Regex::Lexer::TokenType::EscapedQuoteMetaUntil,
    E => Regex::Lexer::TokenType::EscapedEnd,
    w => Regex::Lexer::TokenType::EscapedWordChar,
    W => Regex::Lexer::TokenType::EscapedNotWordChar,
    s => Regex::Lexer::TokenType::EscapedWhiteSpaceChar,
    S => Regex::Lexer::TokenType::EscapedNotWhiteSpaceChar,
    d => Regex::Lexer::TokenType::EscapedDigitChar,
    D => Regex::Lexer::TokenType::EscapedNotDigitChar,
    p => Regex::Lexer::TokenType::EscapedProp,
    P => Regex::Lexer::TokenType::EscapedNotProp,
    X => Regex::Lexer::TokenType::EscapedUnicodeExtendedChar,
    C => Regex::Lexer::TokenType::EscapedCChar,
    1 => Regex::Lexer::TokenType::EscapedBackRef,
    2 => Regex::Lexer::TokenType::EscapedBackRef,
    3 => Regex::Lexer::TokenType::EscapedBackRef,
    4 => Regex::Lexer::TokenType::EscapedBackRef,
    5 => Regex::Lexer::TokenType::EscapedBackRef,
    6 => Regex::Lexer::TokenType::EscapedBackRef,
    7 => Regex::Lexer::TokenType::EscapedBackRef,
    8 => Regex::Lexer::TokenType::EscapedBackRef,
    9 => Regex::Lexer::TokenType::EscapedBackRef,
    g => Regex::Lexer::TokenType::EscapedBackRef,
    k => Regex::Lexer::TokenType::EscapedBackRef,
    K => Regex::Lexer::TokenType::EscapedKeepStuff,
    v => Regex::Lexer::TokenType::EscapedVerticalWhitespace,
    V => Regex::Lexer::TokenType::EscapedNotVerticalWhitespace,
    h => Regex::Lexer::TokenType::EscapedHorizontalWhitespace,
    H => Regex::Lexer::TokenType::EscapedNotHorizontalWhitespace,
    R => Regex::Lexer::TokenType::EscapedLinebreak,
    b => Regex::Lexer::TokenType::EscapedWordBoundary,
    B => Regex::Lexer::TokenType::EscapedNotWordBoundary,
    A => Regex::Lexer::TokenType::EscapedBeginningOfString,
    Z => Regex::Lexer::TokenType::EscapedEndOfStringBeforeNewline,
    z => Regex::Lexer::TokenType::EscapedEndOfString,
    G => Regex::Lexer::TokenType::EscapedPos,
);

my %specialChar = (
    '.'  => Regex::Lexer::TokenType::MatchAny,
    '|'  => Regex::Lexer::TokenType::Alternation,
    '('  => Regex::Lexer::TokenType::LeftParenthesis,
    ')'  => Regex::Lexer::TokenType::RightParenthesis,
    '['  => Regex::Lexer::TokenType::LeftBracket,
    ']'  => Regex::Lexer::TokenType::RightBracket,
    '{'  => Regex::Lexer::TokenType::LeftBrace,
    '}'  => Regex::Lexer::TokenType::RightBrace,
    '<'  => Regex::Lexer::TokenType::LeftAngle,
    '>'  => Regex::Lexer::TokenType::RightAngle,
    '*'  => Regex::Lexer::TokenType::Asterisk,
    '+'  => Regex::Lexer::TokenType::Plus,
    '?'  => Regex::Lexer::TokenType::Question,
    ','  => Regex::Lexer::TokenType::Comma,
    '-'  => Regex::Lexer::TokenType::Minus,
    '$'  => Regex::Lexer::TokenType::ScalarSigil,
    '@'  => Regex::Lexer::TokenType::ArraySigil,
    ':'  => Regex::Lexer::TokenType::Colon,
    '#'  => Regex::Lexer::TokenType::Sharp,
    '^'  => Regex::Lexer::TokenType::Cap,
    '='  => Regex::Lexer::TokenType::Equal,
    '!'  => Regex::Lexer::TokenType::Exclamation,
    q<'> => Regex::Lexer::TokenType::SingleQuote,
    q<"> => Regex::Lexer::TokenType::DoubleQuote,
);

sub tokenize {
    my ($re) = @_;

    if (ref $re ne 'Regexp') {
        croak "Not regexp quoted argument is given";
    }

    # B::cstring() is used to escape backslashes
    my $re_cluster_string = B::cstring($re);

    # to remove double-quotes and parenthesis on leading and trailing
    my $re_str = substr(substr($re_cluster_string, 2), 0, -2);

    # extract modifiers
    $re_str =~ s/\A[?]([^:]*)://;
    my @modifiers;
    for my $modifier (split //, $1) {
        push @modifiers, $modifier;
    }

    my @chars = split //, $re_str;

    my @tokens;
    my $index = 0;

    my $end_of_line_exists = 0;
    if ($chars[-1] eq '$') {
        pop @chars;
        $end_of_line_exists = 1;
    }

    if ($chars[0] eq '^') {
        push @tokens, {
            char  => shift @chars,
            index => ++$index,
            type  => Regex::Lexer::TokenType::BeginningOfLine,
        };
    }

    my $backslashes = 0;
    my $next_c;
    for (my $i = 0; defined(my $c = $chars[$i]); $i++) {
        if ($c eq '\\') {
            if ($backslashes <= 1) {
                $backslashes++;
                next;
            }

            # now status -> '\\\\\\'
            if ($backslashes == 2) {
                $next_c = $chars[++$i];
                if (!defined $next_c || $next_c ne '\\') {
                    croak "Invalid syntax regexp is given";
                }

                push @tokens, {
                    char  => '\\\\',
                    index => ++$index,
                    type  => Regex::Lexer::TokenType::EscapedCharacter,
                };

                $backslashes = 0;
                next;
            }
        }

        # To support *NOT META* newline character which is in regexp
        if ($backslashes == 1) {
            if ($c ne 'n' && $c ne 'r') {
                croak "Invalid syntax regexp is given";
            }

            push @tokens, {
                char  => '\\' . $c,
                index => ++$index,
                type  => $c eq 'n' ? Regex::Lexer::TokenType::Newline
                                   : Regex::Lexer::TokenType::Return,
            };

            $backslashes = 0;
            next;
        }

        if ($backslashes == 2) {
            my $type = $escapedSpecialChar{$c};

            # Determine meaning of \N
            if ($c eq 'N') {
                $type = Regex::Lexer::TokenType::EscapedCharUnicode;

                $next_c = $chars[$i+1];
                if (!defined $next_c || $next_c ne '{') {
                    $type = Regex::Lexer::TokenType::EscapedNotNewline;
                }
            }

            push @tokens, {
                char  => '\\' . $c,
                index => ++$index,
                type  => $type || Regex::Lexer::TokenType::EscapedCharacter,
            };

            $backslashes = 0;
            next;
        }

        push @tokens, {
            char  => $c,
            index => ++$index,
            type  => $specialChar{$c} || Regex::Lexer::TokenType::Character,
        };

        $backslashes = 0; # for fail safe
    }

    if ($end_of_line_exists) {
        push @tokens, {
            char  => '$',
            index => ++$index,
            type  => Regex::Lexer::TokenType::EndOfLine,
        };
    }

    return {
        tokens    => \@tokens,
        modifiers => \@modifiers,
    };
}

1;
__END__

=encoding utf-8

=head1 NAME

Regex::Lexer - Lexer for regular expression of perl

=head1 SYNOPSIS

    use Regex::Lexer qw(tokenize);
    my $tokens = tokenize(qr{\Ahello\s+world\z}i);

=head1 DESCRIPTION

Regex::Lexer is a lexer for regular expression of perl.

This module splits the regular expression string to tokens
which has minimum meaning.

=head1 FUNCTIONS

=over 4

=item * C<tokenize($re:Regexp)>

Tokenizes the regular expression.

This function takes a argument as C<Regexp>, namely it must be regexp quoted variable (i.e. C<qr/SOMETHING/>).
If not C<Regexp> argument is given, this function throws exception.

This function returns the result like so;

    {
        tokens => [
            {
                char => '\A',
                index => 1,
                type => {
                    id => 67,
                    name => 'EscapedBeginningOfString',
                },
            },
            {
                char => 'h',
                index => 2,
                type => {
                    id => 1,
                    name => 'Character',
                },
            },
            ...
        ],
        modifiers => ['^', 'i'],
    }

C<tokens> is the token list. Information C<type> of token is located in the L<Regex::Lexer::TokenType>.

C<modifiers> is the list of modifiers of regular expression. Please see also L<perlre>.

=back

=head1 SEE ALSO

=over 4

=item * L<perlre>

=item * L<perlrebackslash>

=item * L<Regex::Lexer::TokenType>

=back

=head1 LICENSE

Copyright (C) moznion.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

moznion E<lt>moznion@gmail.comE<gt>

=cut

