cd /Users/gopalmenon/Documents/workspace/CS-6140-A5-Regression/data/
load('A.dat')
[U,S,V] = svd(A)
norm(A-Ak,2)