Tournament Manager  Version 1.0  07/31/2015

What is it?
-----------

Tournament Manager is a Python script that allow you to keep track of several 
tournaments. Uses a PostgreSQL database to store tournaments, 
players and matches using swiss pairings system. With Tournament 
Manager you can quickly know the pairs list for each tournament round.

Requirements
------------
To a full success use of Tournament Manager you need:

    o PostgreSQL
    o Python 2.7
    o psycopg2

Installation
------------

    # Go to the project folder
    $ cd /vagrant/tournament
    
    # Open psql prompt
    $ psql
    
    # Create the database
    $ CREATE DATABASE tournament
    
    # Use the database tournament
    $ \c tournament
    
    # Import schema
    $ \i tournament.sql
    
How to use/test
------------

You can see the file "tournament_test.py" from this repo where 
are all the methods you can use in this script.

You can also test the script by running it in any Python IDE or 
directly from terminal using the command:

    python tournament_test.py
    
If everything runs well you will get the message:

    Success!  All tests pass!

Licensing
---------

Please see the file LICENSE.

Contacts
--------

o If you want to be informed about new code releases, bug fixes,
security fixes, general news and information about the Tournament 
Manager project just keep tracking this repository.

o If you want freely available support for this script 
or any kind of help just mail <hugophp@sapo.pt>
