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
    my $self  = shift;
    my $left  = @_ ? shift : 0;
    my $right = @_ ? shift : $#{$self};
    my $pivot = $self->_pivot($left, $right);

    return if( $right - $left < 1 );

    my $i = $left;
    my $j = $right;
    for(;;){
        $i++ while($self->[$i] < $pivot);
        $j-- while($self->[$j] > $pivot);
        if( $i < $j ){
            my $tmp = $self->[$i];
            $self->[$i] = $self->[$j];
            $self->[$j] = $tmp;
            $i++; $j--;
            next;
        }
        $self->sort($left, $i-1);
        $self->sort($i, $right);
        last;
    }
}

sub _pivot {
    my $self = shift;
    my $left = shift;
    my $right = shift;

    return (
            $self->[$left] + $self->[$right] +
            $self->[($left+$right)/2]
        ) / 3;
}

1;
