#!/usr/bin/perl

# Set these for your situation
my $HOSTFILE = "/etc/hostname"; # The file that contains the FDN host name
my $PORT = 41975;
my $LUGDIR = "/home/lugowner/lugdunon/dat";

#-------------------
# No changes below here...
#-------------------

my $LUGBACKUP_Version = "1.2.0";

# Read in host name
open FILE, $HOSTFILE or die "Couldn't open file: $HOSTFILE";
my $HOST = <FILE>;
close FILE;
chop($HOST);

print "LugBackup version $LUGBACKUP_VERSION\n";
print "==========================\n";
print "Moving existing backups: ";

if (-f "$LUGDIR/lugbackup-5.lug")
{
	unlink("$LUGDIR/lugbackup-5.lug")  or warn "Could not unlink $LUGDIR/lugbackup-5.lug: $!";
}
if (-f "$LUGDIR/lugbackup-4.lug")
{
	rename("$LUGDIR/lugbackup-4.lug", "$LUGDIR/lugbackup-5.lug");
}
if (-f "$LUGDIR/lugbackup-3.lug")
{
	rename("$LUGDIR/lugbackup-3.lug", "$LUGDIR/lugbackup-4.lug");
}
if (-f "$LUGDIR/lugbackup-2.lug")
{
	rename("$LUGDIR/lugbackup-2.lug", "$LUGDIR/lugbackup-3.lug");
}
if (-f "$LUGDIR/lugbackup-1.lug")
{
	rename("$LUGDIR/lugbackup-1.lug", "$LUGDIR/lugbackup-2.lug");
}
print "Done\nRequesting Backup: ";
system("wget http://$HOST:$PORT/management/CORE.COMMAND.SAVE?mode=lugbackup-1 2>/dev/null >/dev/null");
print("Done!\n");
exit 0;
