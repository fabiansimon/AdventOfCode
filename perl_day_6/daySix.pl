sub get_data {
    my ($path) = @_;

    open(my $file, '<', $path) or die "Could not open file '$path' $!";

    my @times;
    my @distances;

    while (<$file>) {
        chomp;
        
        if (/^Time:/) {
            @times = /(\d+)/g;
        }

        if (/^Distance:/) {
            @distances = /(\d+)/g;
        }
    }

    close($file);

    return (\@times, \@distances);
}

sub get_total_distances {
    my ($time, $target) = @_; 
    my $winners = 0; 

    my $speed; 
    my $rest;

    for my $i (0..$time) {
        $speed = $i;
        $rest = $time - $i;

        if ($rest * $speed > $target) {
            $winners++;
        }
    }

    return $winners;
}

my $file_path = "./daySix_input.txt";

my @data = get_data($file_path);

my $game_size = scalar @{$data[0]};

my $time;
my $target;
my $total = 1; 
for my $i (0..$game_size-1) {
    $time = $data[0][$i];
    $target = $data[1][$i];

    my $winners = get_total_distances($time, $target);
    $total *= $winners;
}

print $total
