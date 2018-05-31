foreach $_ (`df -k | grep -v "Filesystem"`)
{
($device, $size, $used, $free, $percent, $mount) = split(/\s+/);
chop($percent);
if (($i == 0) || ($i == 3)) {
print "$percent\n";
print "$percent\n";
}
$i++;
}

