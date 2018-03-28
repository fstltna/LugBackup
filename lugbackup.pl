#!/usr/bin/perl

# Set these for your situation
my $HOST = "104.237.153.176"; # You need to run this script from this host also!
my $PORT = 41975;
my $LUGDIR = "/root/lugdunon/dat";

#-------------------
# No changes below here...
#-------------------

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
