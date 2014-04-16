package Chart::Clicker::Data::Series::ErrorBar;
use Moose;

extends 'Chart::Clicker::Data::Series';

# ABSTRACT: Chart data with additional attributes for Size charts

use List::Util qw(min max);

=head1 DESCRIPTION

Chart::Clicker::Data::Series::ErrorBar is an extension of the Series class
that provides storage for x and y error bar values. These values are plus and minus
the given value. This is useful for the ErrorBar renderer.

=head1 SYNOPSIS

  use Chart::Clicker::Data::Series::ErrorBar;

  my @keys = ();
  my @values = ();
  my @yerrors = ();
  my @xerrors = ();

  my $series = Chart::Clicker::Data::Series::Size->new({
    keys     => \@keys,
    values   => \@values,
    x_errors => \@xerrors,
    y_errors => \@yerrors,
  });

=head1 ATTRIBUTES

=head2 x_errors

Set/Get the x error bar values for this series.

=head2 y_errors

Set/Get the y error bar values for this series.

=head1 METHODS

=head2 add_to_x_errors

Adds a x_error value to this series as push would.

=head2 add_to_y_errors

Adds a y_error value to this series as push would.

=head2 get_x_error

Get an x_error value by it's index.

=head2 get_y_error

Get an y_error value by it's index.

=head2 x_error_count

Gets the count of x_error values in this series.

=head2 y_error_count

Gets the count of y_error values in this series.

=cut

has 'x_errors' => (
    traits => [ 'Array' ],
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [] },
    handles => {
        'add_to_x_errors' => 'push',
        'x_error_count' => 'count',
        'get_x_error' => 'get'
    }
);

has 'y_errors' => (
    traits => [ 'Array' ],
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [] },
    handles => {
        'add_to_y_errors' => 'push',
        'y_error_count' => 'count',
        'get_y_error' => 'get'
    }
);

=head2 max_x_error

Gets the largest x-error value from this Series' C<x_errors>.

=cut

has max_x_error => (
    is => 'ro',
    isa => 'Num',
    lazy => 1,
    default => sub {
        my ($self) = @_;
        return max(@{ $self->x_errors });
    }
);

=head2 min_x_error

Gets the smallest value from this Series' C<x_errors>.

=cut

has min_x_error => (
    is => 'ro',
    isa => 'Num',
    lazy => 1,
    default => sub {
        my ($self) = @_;
        return min(@{ $self->x_errors });
    }
);


=head2 max_y_error

Gets the largest y-error value from this Series' C<y_errors>.

=cut

has max_y_error => (
    is => 'ro',
    isa => 'Num',
    lazy => 1,
    default => sub {
        my ($self) = @_;
        return max(@{ $self->y_errors });
    }
);


=head2 min_y_error

Gets the smallest value from this Series' C<y_errors>.

=cut

has min_y_error => (
    is => 'ro',
    isa => 'Num',
    lazy => 1,
    default => sub {
        my ($self) = @_;
        return min(@{ $self->y_errors });
    }
);


__PACKAGE__->meta->make_immutable;

no Moose;

1;
