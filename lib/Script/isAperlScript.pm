package Script::isAperlScript;

use warnings;
use strict;
use Exporter;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

our @ISA         = qw(Exporter);
our @EXPORT      = qw(isAperlScript stringIsAperlScript);
our @EXPORT_OK   = qw(isAperlScript stringIsAperlScript);
our %EXPORT_TAGS = (DEFAULT => [qw(isAperlScript stringIsAperlScript)]);

=head1 NAME

Script::isAperlScript - This does a basic check if something is a perl script or not.

=head1 VERSION

Version 0.0.0

=cut

our $VERSION = '0.0.0';


=head1 SYNOPSIS

This module does a basic check to see if something is a perl script.

It will currently check for the matches below.

    /^\#\!\/usr\/bin\/perl/
    /^\#\!\/usr\/bin\/suidperl/
    /^\#\!\/usr\/local\/bin\/perl/
    /^\#\!\/usr\/local\/bin\/suidperl/

This will also match stuff like "#!/usr/local/bin/perl5.8.9".

More will be added eventually.

=head1 EXPORT

isAperlScript

stringIsAperlScript

=head1 FUNCTIONS

=head2 isAperlScript

This checks if a file is a Perl script.

Only one arguement is taken and it is the string in question.

In regards to the returned value, see the section "RETURN" for more information.

    my $returned=isAperlScript($file);
    if(!$returned){
        print "It returned false so there for it is a perl script.\n";
    }

=cut

sub isAperlScript{
	my $file=$_[0];

	#make sure a file is specified
	if (!defined($file)) {
		return 5;
	}
	#make sure it exists
	if (! -e $file) {
		return 3;
	}

	#it is not a file
	if (! -f $file) {
		return 7;
	}

	#make sure it is readable
	if (! -r $file) {
		return 4;
	}

	#try to open it
	if (open(THEFILE, '<', $file )) {
		my $string=join("", <THEFILE>);
		close(THEFILE);
		return stringIsAperlScript($string);
	}

	#it could not be opened
	return 6;
}

=head2 stringIsAperlScript

This checks if a string is a Perl script.

Only one arguement is taken and it is the string in question.

In regards to the returned value, see the section "RETURN" for more information.

    my $returned=stringIsAperlScript($string);
    if(!$returned){
        print "It returned false so there for it is a perl script.\n";
    }

=cut

sub stringIsAperlScript{
	my $string=$_[0];

	#make sure a string is specified
	if (!defined( $string )) {
		return 2;
	}
	
	#checks if it makes #!/usr/bin/perl
	if ($string =~ /^\#\!\/usr\/bin\/perl/) {
		return 0;
	}

	#checks if it makes #!/usr/bin/suidperl
	if ($string =~ /^\#\!\/usr\/bin\/suidperl/) {
		return 0;
	}

	#checks if it makes #!/usr/local/bin/perl
	if ($string =~ /^\#\!\/usr\/local\/bin\/perl/) {
		return 0;
	}

	#checks if it makes #!/usr/local/bin/suidperl
	if ($string =~ /^\#\!\/usr\/local\/bin\/suidperl/) {
		return 0;
	}

	#not a perl script
	return 1;
}

=head1 RETURN

The easiest way to check is to verify the returned value is false.

=head2 0

It is a Perl script.

=head2 1

It is not a Perl script.

=head2 2

The string is not defined.

=head2 3

The file does not exist.

=head2 4

The file is not readable.

=head2 5

No file specified.

=head2 6

The file could not be opened.

=head2 7

The specified file is not a file.

=head1 AUTHOR

Zane C. Bowers, C<< <vvelox at vvelox.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-script-isaperlscript at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Script-isAperlScript>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Script::isAperlScript


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Script-isAperlScript>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Script-isAperlScript>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Script-isAperlScript>

=item * Search CPAN

L<http://search.cpan.org/dist/Script-isAperlScript/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2010 Zane C. Bowers, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Script::isAperlScript
