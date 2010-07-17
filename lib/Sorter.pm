package Sorter;

use strict;

sub new {
    my $class = shift;
    return bless([], $class);
}

sub set_values {
    my $self = shift;
    @$self = @_;
    return;
}

sub get_values {
    my $self = shift;
    return @$self;
}

sub sort {
    
}

1;
