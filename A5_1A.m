cd data
load('A.dat')
for k=(1:10)
  [U,S,V] = svd(A);
  Uk = U(:,1:k);
  Sk = S(1:k,1:k);
  Vk = V(:,1:k);
  Ak = Uk*Sk*Vk';
  disp(norm(A-Ak,2));
endfor
