# IS510-dbp-classnotes

Use this repository as a scratchpad as you follow along with the class lectures. The `Schemas` folder contains the SQL files for all of the Kroenke & Auer textbook examples.

A few tips ...
* Organize your code files by chapter and database. That will help you identify where the code came from. A `Chapter_2_notes.ipynb` notebook file is included here as an example to get you started. It is pre-configured for the Cape Codd Outdoor database from chapter 2 of the textbook.
* For throwaway code that you don't intend to keep (e.g., code not from the book), just include `scratch` in the filename somewhere; Git will ignore it for commits.
* Jupyter Notebooks can be very handy for running code. `%sql` magic can make any code cell run SQL and display the results.
    * `ipython-sql` and `pmysql` must be installed in your Python environment.
    * The DBMS must be running and the database loaded.
    * To keep things simple, avoid connecting with multiple databases in a single notebook.
    * Use the following in a code cell to connect to the database:
    ```
    # Setup: Connect to the database
    %load_ext sql
    %sql mysql+pymysql://root:password@localhost/database-name
    ```
    where `password` and `database-name` reflect whatever database you are working with. *The connection won't work unless you run the cell, of course.*
    * To run a multiline SQL query and display the results, write `%%sql` (note: that's `%%`, not `%`) on the first line, followed by the query, like this:
    ```
    %%sql
    SELECT ...
    FROM ...;
    ```
    *The query will be run each time you run the cell.* If you write multiple queries in a cell then only the results of the last query will be displayed as output. (So, you probably should create a new code cell for each SELECT query.)
* If you prefer to work directly in MySQL Workbench, then save your SQL scripts this folder. Workbench will automatically add a `.sql` extension to the filename.
* Entity Relationship Diagrams (chapter 5) created in LucidChart can be exported as PDF files to this repo folder.
