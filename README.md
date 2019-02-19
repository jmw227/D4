# D4
Deliverable 4 for CS1632_Fall2018

In this deliverable, you and a partner will write software which will take in a file which represents a directed acyclic graph.  Each node in the graph will contain a letter.  You must then determine all possible paths from every node in the graph, and represent the path with the letters that each node has included.  Finally, you should output what the longest possible word(s) you can make is from the permutations of all these lettered paths.

This program MUST be written in two parts and with at least two commits to GitHub.  For the second part, you will take the information you have gleaned from performance testing to make AT LEAST one change to improve performance of your application.

Under _no_ circumstances should the program crash or should the user see an exception or stack trace directly.  You should handle all edge cases that might be thrown at you, such as a non-existent file, no arguments, different failure modes, etc.

The program shall accept one argument, which is the name of a file which includes a description of a directed acyclic graph.  Note that all input is case-insensitive.

```
NODE_ID;LETTER;NEIGHBORING_NODES
```

EXAMPLE:
```
1;C;2,3
2;A;3,4,6
3;K;5
4;T;
5;E;
6;B;
```

Note that IDs must be numeric, but may not be in numeric order in the file (e.g., node ID 10 may come before node ID 9).  There also may be "missing" IDs (e.g. 1, 2, 3, 7, 8, 9 is "missing" 4, 5 and 6 - this is still a valid graph).

Graphs may be entirely connected or unconnected.  That is, there may be entirely separate sub-graphs.

In this case, from node 1, you can go to node 2 or 3.  From node 2, to 3, 4, or 6.  From node 3, the only possible node to go to is 5.  For nodes 4, 5, and 6, there are no nodes, and so all traversals must end.  Since this graph is acyclic, you are guaranteed to eventually reach a node which marks the end of the line, no matter what the starting point is.  All paths must go all the way until they reach an end-node (i.e., a node that has no neighbors to head to).

```
1(C) --->  2(A) ---> 4(T)
  |       /  \
  |      /    \
  |     /      ----> 6(B)
  |    /
  |   /
  | _/
  Vv
3(K) ---> 5(E)
```

Here are all the possible paths:

```
Starting from node 1: CAT, CAB, CKE, CAKE
Starting from node 2: AT, AB, AKE
Starting from node 3: KE
Starting from node 4: T
Starting from node 5: E
Starting from node 6: B
```

After determining all possible strings from following all paths from all nodes in the graph, you must then determine all of the permutations of the possible strings.  For example, in the above graph, all possible paths are CAT, CAB, CKE, CAKE, AT, AB, AKE, KE, T, E, and B.  Here all the possible permutations of the strings representing the paths:

```
CAKE
CAEK
CKAE
CKEA
CEAK
CEKA
ACKE
ACEK
AKCE
AKEC
AECK
AEKC
KCAE
KCEA
KACE
KAEC
KECA
KEAC
ECAK
ECKA
EACK
EAKC
EKCA
EKAC
CAT
CTA
ACT
ATC
TCA
TAC
CAB
CBA
ACB
ABC
BCA
BAC
CKE
CEK
KCE
KEC
ECK
EKC
AKE
AEK
KAE
KEA
EAK
EKA
AT
TA
AB
BA
KE
EK
T
E
B
```

Based on this, you should find the longest valid word or words.  For this exercise, a valid word is one that is defined in the `wordlist.txt` file included in this directory.  If there are multiple words that are the longest (e.g. "BIRD" and "NERD"), you should display all of them.

The longest valid word in this example is "CAKE".

The program shall be called `word_finder.rb` and should be run with `ruby word_finder.rb *name_of_file*`.  Your repository shall be named D4.  This program must be written in Ruby and use minitest for the unit tests.  You may use whatever gem you like, provided it builds on my machine.  This program must also use rubocop with the attached .rubocop.yml configuration and SimpleCov as described in class.

You should work on making this program execute as quickly as possible (i.e., minimize real execution time).  You may use all computing resources available to you.  This will be run on a four-core system with eight gigabytes of RAM.  No other programs will be running at the time (except standard background processes, the terminal program, etc.).

You must use the flamegraph gem to determine execution "hot spots" and  the `time` command (or Measure-Command for Windows) to determine total execution time, both before and after any changes you make.

In other words, I would like you to first get this to work *correctly*, and commit this to GitHub.  You must then refactor the code to improve performance in some way and commit again.

You will tag the initial (working but non-optimized) commit with the tag INITIAL.  I should then be able to do "git diff INITIAL" to see the changes that you made to refactor the program.  I should be able to run the code on BOTH commits (INITIAL and the final commit on the master branch).  However, I will only check rubocop, tests, and statement coverage on the final commit on the master branch.

You should explain how your program has been sped up in your summary.  You should see some significant speed-up in real time from your initial commit to the final commit.
