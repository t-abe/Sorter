package Sorter;

use strict;
use Carp;

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
    my $self  = shift;
    my $left  = @_ ? shift : 0;
    my $right = @_ ? shift : $#{$self};
    my $pivot = $self->_select_pivot($left, $right);

    return if( $right - $left < 1 );

    # print $pivot, "@";
    # print join(',', $self->get_values), "\n";
    # print join(',', @$self[$left..$right]);
    # <>;

    my $i = $left;
    my $j = $right;
    for(;;){
        my $l = $self->_search_to_right($i, $right, $pivot);
        my $r = $self->_search_to_left($j, $left, $pivot);
        if( $l < $r ){
            my $tmp = $self->[$l];
            $self->[$l] = $self->[$r];
            $self->[$r] = $tmp;
            $i = $l + 1;
            $j = $r - 1;
            next;
        }
        $self->sort($left, $l-1);
        $self->sort($l, $right);
        last;
    }
}

sub _search_to_right {
    my $self  = shift;
    my $left  = shift;
    my $right = shift;
    my $pivot = shift;

    for my $i ($left..$right){
        return $i if( $self->[$i] >= $pivot );
    }
    croak("何かおかしい");
}

sub _search_to_left {
    my $self  = shift;
    my $right = shift;
    my $left  = shift;
    my $pivot = shift;

    for my $i (0..$right - $left){
        my $j = $right - $i;
        return $j if( $self->[$j] <= $pivot );
    }
    croak("何かおかしい");
}

sub _select_pivot {
    my $self = shift;
    my $left = shift;
    my $right = shift;

    return (
            $self->[$left] + $self->[$right] +
            $self->[($left+$right)/2]
        ) / 3;
}

1;
