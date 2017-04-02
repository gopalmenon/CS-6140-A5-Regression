cd /Users/gopalmenon/Documents/workspace/CS-6140-A5-Regression/data/
load('A.dat')
[U,S,V] = svd(A)Uk = U(:,1:k)Sk = S(1:k,1:k)Vk = V(:,1:k)Ak = Uk*Sk*Vk’
norm(A-Ak,2)