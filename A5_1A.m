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
# 1C - Find the first two eigen vectors
twoDVectors = V(1:end,1:2)
# Projection of all points on the eigen vectors
PointsToPlot = A*twoDVectors
scatter(PointsToPlot(1:end,1), PointsToPlot(1:end, 2)); hold on
xlabel('Coordinate 1');
ylabel('Coordinate 2');
title('Plot that minimizes sum of residuals squared')